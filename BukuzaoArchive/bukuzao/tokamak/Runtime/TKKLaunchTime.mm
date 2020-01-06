//
//  TKKLaunchTime.m
//  bukuzao
//
//  Created by everettjf on 2018/8/6.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "TKKLaunchTime.h"
#import <UIKit/UIKit.h>
#include <sys/sysctl.h>
#include <sys/types.h>

CFTimeInterval tkkAppLaunchBeginAbsoluteTime = 0;
NSTimeInterval tkkAppLaunchBeginSystemTime = 0;

@implementation TKKLaunchTime

+ (CFTimeInterval)appLaunchBeginAbsoluteTime{
    return tkkAppLaunchBeginAbsoluteTime;
}

+ (NSTimeInterval)appLaunchBeginSystemTime{
    return tkkAppLaunchBeginSystemTime;
}

+ (CFTimeInterval)currentAbsoluteTime{
    return CACurrentMediaTime();
}

+ (NSTimeInterval)currentSystemTime{
    return [[NSDate date]timeIntervalSince1970];
}

+ (NSTimeInterval)processCreateTime{
    pid_t pid = [[NSProcessInfo processInfo] processIdentifier];
    int mib[4] = { CTL_KERN, KERN_PROC, KERN_PROC_PID, pid };
    struct kinfo_proc proc;
    size_t size = sizeof(proc);
    sysctl(mib, 4, &proc, &size, NULL, 0);
    
    return proc.kp_proc.p_starttime.tv_sec;
}

@end
