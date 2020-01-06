//
//  LetMeituanCrash.mm
//  LetMeituanCrash
//
//  Created by everettjf on 2018/9/23.
//  Copyright (c) 2018 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <notify.h> // not required; for examples only

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()



@class ClassToHook;

CHDeclareClass(ClassToHook); // declare class

CHOptimizedMethod(0, self, void, ClassToHook, messageName) // hook method (with no arguments and no return value)
{
	// write code here ...
	
	CHSuper(0, ClassToHook, messageName); // call old (original) method
}

CHOptimizedMethod(2, self, BOOL, ClassToHook, arg1, NSString*, value1, arg2, BOOL, value2) // hook method (with 2 arguments and a return value)
{
	// write code here ...

	return CHSuper(2, ClassToHook, arg1, value1, arg2, value2); // call old (original) method and return its return value
}

static void WillEnterForeground(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}

static void ExternallyPostedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}


@interface AAAAAMakingCrash : NSObject

@end

@implementation AAAAAMakingCrash

- (void)hello
{
    NSLog(@"AAAAMakingCrash hello");
    
    [self world];
}

- (void)world
{
    NSLog(@"AAAAMakingCrash world");

//    [self performSelector:NSSelectorFromString(@"ThisIsACrashTestingMethod:") withObject:nil];
    
    char *a = (char*)0x1; *a = 1;
}

@end


void letsCrash()
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AAAAAMakingCrash *obj = [[AAAAAMakingCrash alloc] init];
        [obj hello];
    });
}

CHConstructor // code block that runs immediately upon load
{
	@autoreleasepool
	{
//        // listen for local notification (not required; for example only)
//        CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
//        CFNotificationCenterAddObserver(center, NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
//
//        // listen for system-side notification (not required; for example only)
//        // this would be posted using: notify_post("com.everettjf.LetMeituanCrash.eventname");
//        CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
//        CFNotificationCenterAddObserver(darwin, NULL, ExternallyPostedNotification, CFSTR("com.everettjf.LetMeituanCrash.eventname"), NULL, CFNotificationSuspensionBehaviorCoalesce);
//
//        // CHLoadClass(ClassToHook); // load class (that is "available now")
//        // CHLoadLateClass(ClassToHook);  // load class (that will be "available later")
//
//        CHHook(0, ClassToHook, messageName); // register hook
//        CHHook(2, ClassToHook, arg1, arg2); // register hook
        
        
        letsCrash();
	}
}
