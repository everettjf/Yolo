//
//  NoteDisplayDefaultConfiguration.m
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/20.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "NoteDisplayDefaultConfiguration.h"


char * kNoteDisplayDefaultConfiguration FBInjectableDATA = "+[NoteDisplayDefaultConfiguration(FBInjectable) fb_injectable]";

@implementation NoteDisplayDefaultConfiguration

+ (void)fb_injectable{
}
+ (NSUInteger)integrationPriority{
    return 0;
}

+ (BOOL)showDeleteButton{
    return YES;
}
+ (UIColor *)noteBackgroundColor{
    return [UIColor blackColor];
}

@end
