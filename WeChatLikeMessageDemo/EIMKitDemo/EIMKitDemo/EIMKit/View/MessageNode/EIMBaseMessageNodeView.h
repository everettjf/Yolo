//
//  EIMBaseMessageNodeView.h
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//


#import "EIMView.h"
#import "EIMMessageWrap.h"

typedef NS_ENUM(NSUInteger, EIMMessageNodeType) {
    EIMMessageNodeTypeText = 0,
    EIMMessageNodeTypeImage = 1,
};

@interface EIMBaseMessageNodeView : EIMView

@property (strong,nonatomic) EIMMessageWrap *msgWrap;

+ (BOOL)canCreateMessageNodeViewInstanceWithMessageWrap:(EIMMessageWrap*)msg;

- (instancetype)initWithMessageWrap:(EIMMessageWrap*)msg;

@end
