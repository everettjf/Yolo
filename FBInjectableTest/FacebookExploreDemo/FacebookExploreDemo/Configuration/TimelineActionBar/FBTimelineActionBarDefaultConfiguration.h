//
//  FBTimelineActionBarDefaultConfiguration.h
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/20.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "FBTimelineActionBarConfiguration.h"

@interface FBTimelineActionBarDefaultConfiguration : NSObject<FBTimelineActionBarConfiguration>

+ (void)fb_injectable;
+ (NSUInteger)integrationPriority;

+ (BOOL)areWorkCallsEnabledForSession:(id)arg1;
+ (BOOL)shouldShowFollowersInPrimary;
+ (BOOL)shouldShowPrivacyShortcutInSecondary;
+ (BOOL)shouldShowWritePostInPrimary;

@end
