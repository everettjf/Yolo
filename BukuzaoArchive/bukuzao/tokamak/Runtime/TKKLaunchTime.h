//
//  TKKLaunchTime.h
//  bukuzao
//
//  Created by everettjf on 2018/8/6.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TKKLaunchTime : NSObject

+ (CFTimeInterval)appLaunchBeginAbsoluteTime;

+ (NSTimeInterval)appLaunchBeginSystemTime;

+ (CFTimeInterval)currentAbsoluteTime;

+ (NSTimeInterval)currentSystemTime;

+ (NSTimeInterval)processCreateTime;

@end
