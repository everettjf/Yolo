//
//  FirstCategoryLoader.m
//  LoadCostSample
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "FirstCategoryLoader.h"

@implementation FirstLoader (FirstCategory)

+(void)load{
    NSLog(@"first category +load for FirstLoader");
    usleep(1000 * 45);
}

@end
