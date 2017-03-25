//
//  NoteDisplayYellowConfiguration.m
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/20.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "NoteDisplayYellowConfiguration.h"

char * kNoteDisplayYellowConfiguration FBInjectableDATA = "+[NoteDisplayYellowConfiguration(FBInjectable) fb_injectable]";

@implementation NoteDisplayYellowConfiguration

+ (void)fb_injectable{
}
+ (NSUInteger)integrationPriority{
    return 1;
}

+ (BOOL)showDeleteButton{
    return NO;
}

+ (UIColor *)noteBackgroundColor{
    return [UIColor yellowColor];
}

@end
