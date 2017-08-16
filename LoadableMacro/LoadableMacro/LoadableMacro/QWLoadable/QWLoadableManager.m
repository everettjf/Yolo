//
//  QWLoadableManager.m
//  LoadableMacroCore
//
//  Created by everettjf on 16/10/9.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "QWLoadableManager.h"
#import "QWLoadable.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>


@interface QWLoadableManager ()

+ (BOOL)filter:(const char*) name;

@end


static int QWLoadableFunctionCallbackImpl(const char *name){
    if([QWLoadableManager filter:name])
        return 1;
    
    return 0;
}

static void QWLoadableRun(){
    CFTimeInterval loadStart = CFAbsoluteTimeGetCurrent();
    
    Dl_info info;
    int ret = dladdr(QWLoadableRun, &info);
    if(ret == 0){
        // fatal error
    }
    
#ifndef __LP64__
    const struct mach_header *mhp = (struct mach_header*)info.dli_fbase;
    unsigned long size = 0;
    uint32_t *memory = (uint32_t*)getsectiondata(mhp, QWLoadableSegmentName, QWLoadableSectionName, & size);
#else /* defined(__LP64__) */
    const struct mach_header_64 *mhp = (struct mach_header_64*)info.dli_fbase;
    unsigned long size = 0;
    uint64_t *memory = (uint64_t*)getsectiondata(mhp, QWLoadableSegmentName, QWLoadableSectionName, & size);
#endif /* defined(__LP64__) */
    
    CFTimeInterval loadComplete = CFAbsoluteTimeGetCurrent();
    NSLog(@"QWLoadable:loadcost:%@ms",@(1000.0*(loadComplete-loadStart)));
    if(size == 0){
        NSLog(@"QWLoadable:empty");
        return;
    }
    
    for(int idx = 0; idx < size/sizeof(void*); ++idx){
        QWLoadableFunctionTemplate func = (QWLoadableFunctionTemplate)memory[idx];
        func(QWLoadableFunctionCallbackImpl);
    }
    
    NSLog(@"QWLoadable:callcost:%@ms",@(1000.0*(CFAbsoluteTimeGetCurrent()-loadComplete)));
}

@implementation QWLoadableManager
+ (void)run{
    QWLoadableRun();
}

+ (BOOL)filter:(const char*) name{
    return NO;
}

@end
