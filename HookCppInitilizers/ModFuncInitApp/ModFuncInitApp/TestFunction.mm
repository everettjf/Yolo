//
//  TestFunction.m
//  ModFuncInitApp
//
//  Created by everettjf on 2016/12/6.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "TestFunction.h"

bool initBar(){
    int i = 0;
    ++i;
    return i == 1;
}


//bool globalBar2 = initBar();

void hello(){
    
    static bool globalBar = initBar();
    
    NSLog(@"%@",@(globalBar));
}
