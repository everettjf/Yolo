//
//  FBTimelineActionBarDefaultConfiguration.m
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/20.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "FBTimelineActionBarDefaultConfiguration.h"

char * kFBTimelineActionBarDefaultConfiguration FBInjectableDATA = "+[FBTimelineActionBarDefaultConfiguration(FBInjectable) fb_injectable]";

@implementation FBTimelineActionBarDefaultConfiguration

+ (void)fb_injectable{
}

+ (NSUInteger)integrationPriority{
    return 0;
}

+ (BOOL)areWorkCallsEnabledForSession:(id)arg1{
    return YES;
}

+ (BOOL)shouldShowFollowersInPrimary{
    return YES;
}

+ (BOOL)shouldShowPrivacyShortcutInSecondary{
    return YES;
}

+ (BOOL)shouldShowWritePostInPrimary{
    return YES;
}

@end
