//
//  SecondLoader.m
//  LoadCostSample
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "SecondLoader.h"

@implementation SecondLoader

+ (void)load{
    NSLog(@"second +load");
    usleep(1000 * 25);
}

@end
