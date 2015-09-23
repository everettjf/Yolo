//
//  EVTTabPageScrollView.h
//  Pods
//
//  Created by everettjf on 9/22/15.
//
//

#import <UIKit/UIKit.h>

@interface EVTTabPageScrollViewPageItem : NSObject
@property (nonatomic,strong) NSString *tabName;
@property (nonatomic,strong) UIView *tabView;

-(instancetype)initWithTabName:(NSString*)tabName andTabView:(UIView*)tabView;

@end

@interface EVTTabPageScrollView : UIView

-(instancetype)initWithPageItems:(NSArray *)pageItems;

@end
