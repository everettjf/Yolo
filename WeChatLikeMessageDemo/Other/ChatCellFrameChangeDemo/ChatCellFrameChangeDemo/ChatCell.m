//
//  ChatCell.m
//  ChatCellFrameChangeDemo
//
//  Created by everettjf on 16/6/18.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "ChatCell.h"


#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)

@implementation ChatCell{
    UIImageView *_headView;
    UILabel *_textView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _headView = [UIImageView new];
        _headView.bounds = CGRectMake(0, 0, 30, 30);
        _headView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_headView];
        
        _textView = [UILabel new];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor whiteColor];
        _textView.bounds = CGRectMake(0, 0, 100, 30);
        _textView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_textView];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)_layoutAsLeft{
    _headView.center = CGPointMake(15 + 10, 15 + 10);
    _headView.bounds = CGRectMake(0, 0, 30, 30);
    
    CGSize textSize = [_textView sizeThatFits:CGSizeMake(200, FLT_MAX)];
    _textView.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    _textView.center = CGPointMake(10+30+10+textSize.width/2, textSize.height/2+ 10);
}

- (void)_layoutAsRight{
    _headView.center = CGPointMake(SCREEN_WIDTH - (15 + 10), 15 + 10);
    _headView.bounds = CGRectMake(0, 0, 30, 30);
    
    CGSize textSize = [_textView sizeThatFits:CGSizeMake(200, FLT_MAX)];
    _textView.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    _textView.center = CGPointMake(SCREEN_WIDTH - (30 + 10) -10- textSize.width/2, textSize.height/2+ 10);
}

- (void)setText:(NSString *)text{
    _text = text;
    
    _textView.text = _text;
}

- (void)setMine:(BOOL)mine{
    _mine = mine;
}

- (void)layout{
    if(_mine) [self _layoutAsRight];
    else [self _layoutAsLeft];
}


@end
