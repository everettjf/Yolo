#include <Foundation/Foundation.h>

#include <cstdarg>
#include <cstdio>

#include <sys/types.h>
#include <sys/stat.h>

#include <pthread.h>
#include <objc/runtime.h>
#include "ARM64Types.h"

#import "fishhook.h"

#define DEFAULT_CALLSTACK_DEPTH 128
#define CALLSTACK_DEPTH_INCREMENT 64

// Shared structures.
typedef struct CallRecord_ {
    id obj;
    SEL _cmd;
    uintptr_t lr;
} CallRecord;

typedef struct ThreadCallStack_ {
    CallRecord *stack;
    int allocatedCount;
    int index;
} ThreadCallStack;

static pthread_key_t threadKey;

static inline ThreadCallStack * getThreadCallStack() {
    ThreadCallStack *cs = (ThreadCallStack *)pthread_getspecific(threadKey);
    if (cs == NULL) {
        cs = (ThreadCallStack *)malloc(sizeof(ThreadCallStack));
        cs->allocatedCount = DEFAULT_CALLSTACK_DEPTH;
        cs->stack = (CallRecord *)calloc(cs->allocatedCount, sizeof(CallRecord));
        cs->index = -1;
        pthread_setspecific(threadKey, cs);
    }
    return cs;
}
    
struct PointerAndInt_ {
  uintptr_t ptr;
  int i; // if enabled
};
// The original objc_msgSend.
static id (*orig_objc_msgSend)(id, SEL, ...);
// arm64 hooking magic.

    

static inline void pushCallRecord(id obj, uintptr_t lr, SEL _cmd, ThreadCallStack *cs) {
    int nextIndex = (++cs->index);
    if (nextIndex >= cs->allocatedCount) {
        cs->allocatedCount += CALLSTACK_DEPTH_INCREMENT;
        cs->stack = (CallRecord *)realloc(cs->stack, cs->allocatedCount * sizeof(CallRecord));
    }
    CallRecord *newRecord = &cs->stack[nextIndex];
    newRecord->obj = obj;
    newRecord->_cmd = _cmd;
    newRecord->lr = lr;
}

static inline CallRecord * popCallRecord(ThreadCallStack *cs) {
    return &cs->stack[cs->index--];
}
    

    
// Called in our replacementObjc_msgSend before calling the original objc_msgSend.
// This pushes a CallRecord to our stack, most importantly saving the lr.
// Returns orig_objc_msgSend in x0 and isLoggingEnabled in x1.
struct PointerAndInt_ preObjc_msgSend(id self, uintptr_t lr, SEL _cmd, struct RegState_ *rs) {
  ThreadCallStack *cs = getThreadCallStack();
  pushCallRecord(self, lr, _cmd, cs);
    
    printf("pre msg send : %s\n",sel_getName(_cmd));
  return (struct PointerAndInt_) {reinterpret_cast<uintptr_t>(orig_objc_msgSend), 1};
}
// Called in our replacementObjc_msgSend after calling the original objc_msgSend.
// This returns the lr in r0/x0.
uintptr_t postObjc_msgSend() {
    ThreadCallStack *cs = (ThreadCallStack *)pthread_getspecific(threadKey);
    CallRecord *record = popCallRecord(cs);
    printf("post msg send : %s\n",sel_getName(record->_cmd));
    return record->lr;
}

// Our replacement objc_msgSend (arm64).
//
// See:
// https://blog.nelhage.com/2010/10/amd64-and-va_arg/
// http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
// https://developer.apple.com/library/ios/documentation/Xcode/Conceptual/iPhoneOSABIReference/Articles/ARM64FunctionCallingConventions.html
__attribute__((__naked__))
static void replacementObjc_msgSend() {
  __asm__ volatile (
    // push {q0-q7}
      "stp q6, q7, [sp, #-32]!\n"
      "stp q4, q5, [sp, #-32]!\n"
      "stp q2, q3, [sp, #-32]!\n"
      "stp q0, q1, [sp, #-32]!\n"
    // push {x0-x8, lr}
      "stp x8, lr, [sp, #-16]!\n"
      "stp x6, x7, [sp, #-16]!\n"
      "stp x4, x5, [sp, #-16]!\n"
      "stp x2, x3, [sp, #-16]!\n"
      "stp x0, x1, [sp, #-16]!\n"
    // Swap args around for call.
      "mov x2, x1\n"
      "mov x1, lr\n"
      "mov x3, sp\n"
    // Call preObjc_msgSend which puts orig_objc_msgSend into x0 and isLoggingEnabled into x1.
      "bl __Z15preObjc_msgSendP11objc_objectmP13objc_selectorP9RegState_\n"
      "mov x9, x0\n"
      "mov x10, x1\n"
      "tst x10, x10\n" // Set condition code for later branch.
    // pop {x0-x8, lr}
      "ldp x0, x1, [sp], #16\n"
      "ldp x2, x3, [sp], #16\n"
      "ldp x4, x5, [sp], #16\n"
      "ldp x6, x7, [sp], #16\n"
      "ldp x8, lr, [sp], #16\n"
    // pop {q0-q7}
      "ldp q0, q1, [sp], #32\n"
      "ldp q2, q3, [sp], #32\n"
      "ldp q4, q5, [sp], #32\n"
      "ldp q6, q7, [sp], #32\n"
    // Make sure it's enabled.
      "b.eq Lpassthrough\n"
    // Call through to the original objc_msgSend.
      "blr x9\n"
    // push {x0-x9}
      "stp x0, x1, [sp, #-16]!\n"
      "stp x2, x3, [sp, #-16]!\n"
      "stp x4, x5, [sp, #-16]!\n"
      "stp x6, x7, [sp, #-16]!\n"
      "stp x8, x9, [sp, #-16]!\n" // Not sure if needed - push for alignment.
    // push {q0-q7}
      "stp q0, q1, [sp, #-32]!\n"
      "stp q2, q3, [sp, #-32]!\n"
      "stp q4, q5, [sp, #-32]!\n"
      "stp q6, q7, [sp, #-32]!\n"
    // Call our postObjc_msgSend hook.
      "bl __Z16postObjc_msgSendv\n"
      "mov lr, x0\n"
    // pop {q0-q7}
      "ldp q6, q7, [sp], #32\n"
      "ldp q4, q5, [sp], #32\n"
      "ldp q2, q3, [sp], #32\n"
      "ldp q0, q1, [sp], #32\n"
    // pop {x0-x9}
      "ldp x8, x9, [sp], #16\n"
      "ldp x6, x7, [sp], #16\n"
      "ldp x4, x5, [sp], #16\n"
      "ldp x2, x3, [sp], #16\n"
      "ldp x0, x1, [sp], #16\n"
      "ret\n"

    // Pass through to original objc_msgSend.
      "Lpassthrough:\n"
      "br x9"
    );
}
    static void destroyThreadCallStack(void *ptr) {
        ThreadCallStack *cs = (ThreadCallStack *)ptr;
        free(cs->stack);
        free(cs);
    }


    extern "C" void gohook(){
        pthread_key_create(&threadKey, &destroyThreadCallStack);
        
        rebind_symbols((struct rebinding[1]){
            {"objc_msgSend",
                (void*)replacementObjc_msgSend,
                (void**)&orig_objc_msgSend},
        }, 1);

    }
    
    
    
