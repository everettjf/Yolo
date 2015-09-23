//
//  EVTViewController.m
//  EVTTabPageScrollView
//
//  Created by everettjf on 09/22/2015.
//  Copyright (c) 2015 everettjf. All rights reserved.
//

#import "EVTViewController.h"
#import <Masonry.h>
#import <EVTTabPageScrollView.h>

@interface EVTViewController ()

@property (nonatomic,strong) EVTTabPageScrollView *pageScroll;

@end

@implementation EVTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f];
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f];
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f];
    UIView *view4 = [UIView new];
    view4.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f];
    UIView *view5 = [UIView new];
    view5.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f];
    
    NSArray *pageItems = @[
                           [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"头条" andTabView:view1],
                           [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"国内" andTabView:view2],
                           [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"国际" andTabView:view3],
                           [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"科技" andTabView:view4],
                           [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"生活" andTabView:view5],
                           ];
    _pageScroll = [[EVTTabPageScrollView alloc]initWithPageItems:pageItems];
    
    UIView *rootView = self.view;
    
    [rootView addSubview:_pageScroll];
    [_pageScroll mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(rootView.mas_top).offset(30);
        make.left.equalTo(rootView.mas_left);
        make.right.equalTo(rootView.mas_right);
        make.bottom.equalTo(rootView.mas_bottom);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
