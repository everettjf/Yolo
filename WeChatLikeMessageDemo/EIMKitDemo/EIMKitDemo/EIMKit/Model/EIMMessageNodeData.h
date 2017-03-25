//
//  EIMMessageNodeData.h
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EIMMessageWrap.h"
#import "EIMBaseMessageNodeView.h"

@interface EIMMessageNodeData : NSObject

@property (assign,nonatomic) EIMMessageNodeType nodeType;
@property (strong,nonatomic) EIMMessageWrap *messageWrap;
@property (strong,nonatomic) UIView *view;

@property (assign,nonatomic) CGFloat cellHeight;

@end
