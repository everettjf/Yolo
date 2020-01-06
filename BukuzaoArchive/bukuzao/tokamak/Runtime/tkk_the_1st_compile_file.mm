//
//  tkk_the_1st_compile_file.m
//  bukuzao
//
//  Created by everettjf on 2018/8/6.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern CFTimeInterval tkkAppLaunchBeginAbsoluteTime;
extern NSTimeInterval tkkAppLaunchBeginSystemTime;

@interface TKKThe1stCompileFile : NSObject
@end
@implementation TKKThe1stCompileFile

+ (void)load{
    tkkAppLaunchBeginAbsoluteTime = CACurrentMediaTime();
    tkkAppLaunchBeginSystemTime = [[NSDate date]timeIntervalSince1970];
}

@end
