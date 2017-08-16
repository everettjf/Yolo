//
//  TestMacro.m
//  ModFuncInitApp
//
//  Created by everettjf on 2016/12/6.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "TestMacro.h"

NSString *description(const char *str){
    return [NSString stringWithFormat:@"hello %s",str];
}

#define E(str) description(str)


NSString* globalArray[] = {
    E("hello"),
    E("hello"),
    E("hello"),
    E("hello"),
    E("hello"),
    E("hello"),
};

NSString *globalString = E("world");

