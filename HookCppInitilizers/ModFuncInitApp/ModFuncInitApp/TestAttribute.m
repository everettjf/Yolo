//
//  TestAttribute.m
//  ModFuncInitApp
//
//  Created by everettjf on 2016/12/6.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "TestAttribute.h"


__attribute__((constructor)) void myentry(){
    NSLog(@"constructor");
}
