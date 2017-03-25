//
//  AreaCodeViewController.h
//  AreaCodeViewController
//
//  Created by everettjf on 16/6/8.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVTPhoneAreaCodeViewControllerTheme : NSObject
// Background
@property (strong,nonatomic) UIColor *backgroundColor;

// Section
@property (strong,nonatomic) UIColor *sectionBackgroundColor;
@property (strong,nonatomic) UIColor *sectionForegroundColor;
@property (assign,nonatomic) CGFloat sectionHeight;
@property (strong,nonatomic) UIFont *sectionFont;

// Section Index
@property (strong,nonatomic) UIColor *sectionIndexBackgroundColor;
@property (strong,nonatomic) UIColor *sectionIndexColor;

// TableView
@property (strong,nonatomic) UIColor *tableViewBackgroundColor;
@property (strong,nonatomic) UIColor *tableViewSeparatorColor;

// ViewController
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *titleEn;

// SearchBar
@property (copy,nonatomic) NSString *searchBarPlaceHolder;
@property (copy,nonatomic) NSString *searchBarPlaceHolderEn;
@property (strong,nonatomic) UIColor *searchBarTintColor;
@property (strong,nonatomic) UIColor *searchBarBackgroundColor;

+ (EVTPhoneAreaCodeViewControllerTheme*)defaultTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)whiteTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)grayTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)greenTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)redTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)orangeTheme;

@end

@interface EVTPhoneAreaCodeViewController : UIViewController
@property (strong,nonatomic) EVTPhoneAreaCodeViewControllerTheme *theme;
@property (assign,nonatomic) BOOL localeEn;
@property (copy,nonatomic) void(^completion)(NSString *name, NSString *code);
@end
