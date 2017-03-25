//
//  FBNavigationBarDefaultConfiguration.h
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "FBNavigationBarConfiguration.h"



@interface FBNavigationBarDefaultConfiguration : NSObject<FBNavigationBarConfiguration>

+ (void)fb_injectable;
+ (NSUInteger)integrationPriority;
+ (BOOL)shouldShowBackButton;

@end
