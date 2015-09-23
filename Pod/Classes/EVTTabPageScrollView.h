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
@property (nonatomic,strong) UIColor *indicatorColor;
//todo


@end

@interface EVTTabPageScrollView : UIView

@property (nonatomic,weak) id<EVTTabPageScrollViewDelegate> delegate;

/**
 *  init with Array of EVTTabPageScrollViewPageItem
 *
 *  @param pageItems Array of EVTTabPageScrollViewPageItem
 *
 *  @return new tab page scroll view
 */
-(instancetype)initWithPageItems:(NSArray *)pageItems;

@end
