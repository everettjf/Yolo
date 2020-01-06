//
//  SecondLoaderInSecondDylib.m
//  SecondDylib
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "SecondLoaderInSecondDylib.h"

@implementation SecondLoaderInSecondDylib

+(void)load{
    NSLog(@"second +load in second dylib");
    usleep(1000 * 40);
}

@end
