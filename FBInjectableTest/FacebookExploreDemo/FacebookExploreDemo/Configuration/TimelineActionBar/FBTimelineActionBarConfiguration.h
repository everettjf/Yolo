//
//  FBTimelineActionBarConfiguration.h
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/20.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "FBIntegrationToOne.h"

@protocol FBTimelineActionBarConfiguration <FBIntegrationToOne>

+ (BOOL)areWorkCallsEnabledForSession:(id)arg1;
+ (BOOL)shouldShowFollowersInPrimary;
+ (BOOL)shouldShowPrivacyShortcutInSecondary;
+ (BOOL)shouldShowWritePostInPrimary;

@end
