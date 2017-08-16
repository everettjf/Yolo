//
//  TestClass.m
//  ModFuncInitApp
//
//  Created by everettjf on 2016/12/6.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "TestClass.h"

class FooObject{
public:
    FooObject(){
        // do somthing
        NSLog(@"in fooobject");
    }
    
};

static FooObject globalObj = FooObject();
FooObject globalObj2 = FooObject();
