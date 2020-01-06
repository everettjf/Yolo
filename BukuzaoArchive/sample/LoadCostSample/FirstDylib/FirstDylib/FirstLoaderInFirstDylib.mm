//
//  FirstLoaderInFirstDylib.m
//  FirstDylib
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "FirstLoaderInFirstDylib.h"
@implementation FirstLoaderInFirstDylib

+(void)load{
    NSLog(@"first +load in first dylib");
    usleep(1000 * 10);
}
@end
