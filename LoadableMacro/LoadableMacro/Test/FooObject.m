//
//  FooObject.m
//  LoadableMacro
//
//  Created by everettjf on 2017/1/4.
//  Copyright © 2017年 everettjf. All rights reserved.
//

#import "FooObject.h"
#import "QWLoadable.h"


@interface FooObject : NSObject
@end
@implementation FooObject
+ (void)userDefinedLoad{
    NSLog(@"FooObject");
}

+ (void)load{
    
}

@end

QWLoadableFunctionBegin(FooObject)
[FooObject userDefinedLoad];
QWLoadableFunctionEnd(FooObject)
