//
//  SecondLoaderInFirstDylib.m
//  FirstDylib
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "SecondLoaderInFirstDylib.h"

@implementation SecondLoaderInFirstDylib

+(void)load{
    NSLog(@"second +load in first dylib");
    usleep(1000 * 20);
}

@end
