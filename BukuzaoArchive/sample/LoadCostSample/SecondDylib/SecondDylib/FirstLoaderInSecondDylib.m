//
//  FirstLoaderInSecondDylib.m
//  SecondDylib
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "FirstLoaderInSecondDylib.h"

@implementation FirstLoaderInSecondDylib

+(void)load{
    NSLog(@"first +load in second dylib");
    usleep(1000 * 30);
}

@end
