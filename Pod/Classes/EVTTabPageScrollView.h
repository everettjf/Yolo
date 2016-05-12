//
//  EVTTabPageScrollView.h
//  Pods
//
//  Created by everettjf on 9/22/15.
//
//

#import <UIKit/UIKit.h>

/**
 *  Page Item for init EVTTabPageScrollView
 */
@interface EVTTabPageScrollViewPageItem : NSObject

@property (nonatomic,strong) NSString *tabName;
@property (nonatomic,strong) UIView *tabView;

-(instancetype)initWithTabName:(NSString*)tabName andTabView:(UIView*)tabView;

@end

@class EVTTabPageScrollView;
@protocol EVTTabPageScrollViewDelegate<NSObject>
@optional
-(void)EVTTabPageScrollView:(EVTTabPageScrollView*)tabPageScrollView
          decorateTabButton:(UIButton*)tabButton;

-(void)EVTTabPageScrollView:(EVTTabPageScrollView*)tabPageScrollView
        didPageItemSelected:(EVTTabPageScrollViewPageItem*)pageItem
               withTabIndex:(NSInteger)tabIndex;
@end

@interface EVTTabPageScrollViewParameter : NSObject
@property (nonatomic,assign) NSInteger tabHeight;

@property (nonatomic,strong) UIColor *indicatorColor;
@property (nonatomic,assign) NSInteger indicatorHeight;

@property (nonatomic,strong) UIColor *separatorColor;
@property (nonatomic,assign) NSInteger separatorHeight;

@property (nonatomic,assign) CGFloat indicatorWidthFactor;
@end

@interface EVTTabPageScrollView : UIView

@property (nonatomic, weak) id<EVTTabPageScrollViewDelegate> delegate;

/**
 *  init with Array of EVTTabPageScrollViewPageItem
 *
 *  @param pageItems Array of EVTTabPageScrollViewPageItem
 *
 *  @return new tab page scroll view
 */
-(instancetype)initWithPageItems:(NSArray *)pageItems;
-(instancetype)initWithPageItems:(NSArray *)pageItems withParameter:(EVTTabPageScrollViewParameter*)parameter;

-(instancetype)initWithPageItems:(NSArray *)pageItems withDelegate:(id<EVTTabPageScrollViewDelegate>)deleate;
-(instancetype)initWithPageItems:(NSArray *)pageItems withParameter:(EVTTabPageScrollViewParameter*)parameter withDelegate:(id<EVTTabPageScrollViewDelegate>)deleate;

@end
