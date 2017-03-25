//
//  EIMMessageWrap.m
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "EIMMessageWrap.h"

@implementation EIMMessageWrap

+ (EIMMessageWrap *)createText:(BOOL)mine text:(NSString *)text{
    EIMMessageWrap *m = [EIMMessageWrap new];
    m.type = EIMMessageTypeText;
    m.mine = mine;
    m.text = text;
    return m;
}

+ (EIMMessageWrap *)createImage:(BOOL)mine image:(NSString *)image{
    EIMMessageWrap *m = [EIMMessageWrap new];
    m.type = EIMMessageTypeImage;
    m.mine = mine;
    m.image = image;
    return m;
}

@end
