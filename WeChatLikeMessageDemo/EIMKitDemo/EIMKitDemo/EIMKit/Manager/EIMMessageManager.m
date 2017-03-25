//
//  EIMMessageManager.m
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "EIMMessageManager.h"

@implementation EIMMessageManager

+ (EIMMessageManager *)manager{
    static EIMMessageManager *o;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        o = [EIMMessageManager new];
    });
    return o;
}

- (NSArray *)getMessageArray{
    NSMutableArray *arr = [NSMutableArray new];
    
    NSInteger i = 0;
    [arr addObject:[EIMMessageWrap createText:i%3==0 text:@"Hello World"]];
    [arr addObject:[EIMMessageWrap createText:i%3==0 text:@"Hello World"]];
    [arr addObject:[EIMMessageWrap createText:i%3==0 text:@"Hello World"]];
    [arr addObject:[EIMMessageWrap createText:i%3==0 text:@"Hello World"]];
    
    [arr addObject:[EIMMessageWrap createImage:i%3==0 image:@"image"]];
    [arr addObject:[EIMMessageWrap createImage:i%3==0 image:@"image"]];
    [arr addObject:[EIMMessageWrap createImage:i%3==0 image:@"image"]];
    [arr addObject:[EIMMessageWrap createImage:i%3==0 image:@"image"]];
    
    return arr;
}

@end
