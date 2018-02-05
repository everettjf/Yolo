

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <pthread.h>
#include <objc/runtime.h>

#import "fishhook.h"

#define DEFAULT_CALLSTACK_DEPTH 128
#define CALLSTACK_DEPTH_INCREMENT 64

// Shared structures.
typedef struct CallRecord_ {
    id obj;
    SEL _cmd;
    uintptr_t lr;
    char * classname;
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
    
static inline void pushCallRecord(id obj, SEL _cmd ,uintptr_t lr, const char * classname) {
    ThreadCallStack *cs = getThreadCallStack();
    
    int nextIndex = (++cs->index);
    if (nextIndex >= cs->allocatedCount) {
        cs->allocatedCount += CALLSTACK_DEPTH_INCREMENT;
        cs->stack = (CallRecord *)realloc(cs->stack, cs->allocatedCount * sizeof(CallRecord));
    }
    
    CallRecord *newRecord = &cs->stack[nextIndex];
    newRecord->obj = obj;
    newRecord->_cmd = _cmd;
    newRecord->lr = lr;
    
    unsigned long namelen = strlen(classname);
    newRecord->classname = malloc(namelen + 1);
    strncpy(newRecord->classname,classname,namelen);
}

static inline CallRecord * popCallRecord() {
    ThreadCallStack *cs = (ThreadCallStack *)pthread_getspecific(threadKey);
    return &cs->stack[cs->index--];
}

void before_objc_msgSend(id self, SEL _cmd, uintptr_t lr) {
    const char * classname = class_getName(object_getClass(self));
    pushCallRecord(self, _cmd, lr, classname);
    
    printf("pre msg send : %s %s\n",classname, sel_getName(_cmd));
}

uintptr_t after_objc_msgSend() {
    CallRecord *record = popCallRecord();
    printf("post msg send : %s %s\n",record->classname,sel_getName(record->_cmd));
    
    free(record->classname);
    record->classname = NULL;
    
    return record->lr;
}

// The original objc_msgSend.
static id (*orig_objc_msgSend)(id, SEL, ...);


// Our replacement objc_msgSend (arm64).
//
// See:
// https://blog.nelhage.com/2010/10/amd64-and-va_arg/
// http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
// https://developer.apple.com/library/ios/documentation/Xcode/Conceptual/iPhoneOSABIReference/Articles/ARM64FunctionCallingConventions.html
#define call(b, value) \
__asm volatile ("stp x8, x9, [sp, #-16]!\n"); \
__asm volatile ("mov x12, %0\n" :: "r"(value)); \
__asm volatile ("ldp x8, x9, [sp], #16\n"); \
__asm volatile (#b " x12\n");

#define save() \
__asm volatile ( \
"stp x8, x9, [sp, #-16]!\n" \
"stp x6, x7, [sp, #-16]!\n" \
"stp x4, x5, [sp, #-16]!\n" \
"stp x2, x3, [sp, #-16]!\n" \
"stp x0, x1, [sp, #-16]!\n");

#define load() \
__asm volatile ( \
"ldp x0, x1, [sp], #16\n" \
"ldp x2, x3, [sp], #16\n" \
"ldp x4, x5, [sp], #16\n" \
"ldp x6, x7, [sp], #16\n" \
"ldp x8, x9, [sp], #16\n" );

#define link(b, value) \
__asm volatile ("stp x8, lr, [sp, #-16]!\n"); \
__asm volatile ("sub sp, sp, #16\n"); \
call(b, value); \
__asm volatile ("add sp, sp, #16\n"); \
__asm volatile ("ldp x8, lr, [sp], #16\n");

#define ret() __asm volatile ("ret\n");

__attribute__((__naked__))
static void hook_Objc_msgSend() {
    // Save parameters.
    save()
    
    __asm volatile ("mov x2, lr\n");
    __asm volatile ("mov x3, x4\n");
    
    // Call our before_objc_msgSend.
    call(blr, &before_objc_msgSend)
    
    // Load parameters.
    load()
    
    // Call through to the original objc_msgSend.
    call(blr, orig_objc_msgSend)
    
    // Save original objc_msgSend return value.
    save()
    
    // Call our after_objc_msgSend.
    call(blr, &after_objc_msgSend)
    
    // restore lr
    __asm volatile ("mov lr, x0\n");
    
    // Load original objc_msgSend return value.
    load()
    
    // return
    ret()
}

static void destroyThreadCallStack(void *ptr) {
        ThreadCallStack *cs = (ThreadCallStack *)ptr;
        free(cs->stack);
        free(cs);
}


void gohook(){
        pthread_key_create(&threadKey, &destroyThreadCallStack);

        rebind_symbols((struct rebinding[1]){
            {"objc_msgSend",
                (void*)hook_Objc_msgSend,
                (void**)&orig_objc_msgSend},
        }, 1);

}
    
    
    
