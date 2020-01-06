//
//  SecondCategoryLoad.m
//  LoadCostSample
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "SecondCategoryLoad.h"

@implementation  FirstLoader (SecondCategory)

+ (void)load{
    NSLog(@"second category +load for FirstLoader");
    usleep(1000 * 55);
}

@end
