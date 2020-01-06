//
//  FirstLoader.m
//  LoadCostSample
//
//  Created by everettjf on 2018/8/18.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "FirstLoader.h"

@implementation FirstLoader

+ (void)load{
    NSLog(@"first +load");
    usleep(1000 * 15);
}

- (void)hello{
    
    NSLog(@"hello");
}

@end
