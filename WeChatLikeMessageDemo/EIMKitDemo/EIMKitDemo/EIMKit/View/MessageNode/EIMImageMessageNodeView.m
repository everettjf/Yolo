//
//  EIMImageMessageNodeView.m
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "EIMImageMessageNodeView.h"
#import "EIMUtility.h"

@implementation EIMImageMessageNodeView{
    UIImageView *_headView;
    UILabel *_textView;
}

+ (BOOL)canCreateMessageNodeViewInstanceWithMessageWrap:(EIMMessageWrap *)msg{
    if(msg.image) return YES;
    return NO;
}

- (instancetype)initWithMessageWrap:(EIMMessageWrap *)msg{
    self = [super init];
    if(self){
        _headView = [UIImageView new];
        _headView.backgroundColor = [UIColor blueColor];
        [self addSubview:_headView];
        
        _textView = [UILabel new];
        _textView.backgroundColor = [UIColor grayColor];
        [self addSubview:_textView];
        
        _textView.text = msg.image;
        
        CGFloat height = 0;
        if(msg.mine){
            _headView.center = CGPointMake(SCREEN_WIDTH - (15 + 10), 15 + 10);
            _headView.bounds = CGRectMake(0, 0, 30, 30);
            
            CGSize textSize = [_textView sizeThatFits:CGSizeMake(200, FLT_MAX)];
            _textView.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
            _textView.center = CGPointMake(SCREEN_WIDTH - (30 + 10) -10- textSize.width/2, textSize.height/2+ 10);
            
            height = textSize.height;
        }else{
            _headView.center = CGPointMake(15 + 10, 15 + 10);
            _headView.bounds = CGRectMake(0, 0, 30, 30);
            
            CGSize textSize = [_textView sizeThatFits:CGSizeMake(200, FLT_MAX)];
            _textView.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
            _textView.center = CGPointMake(10+30+10+textSize.width/2, textSize.height/2+ 10);
            
            height = textSize.height;
        }
        
        if(height < 44)height = 44;
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    }
    return self;
}


@end
