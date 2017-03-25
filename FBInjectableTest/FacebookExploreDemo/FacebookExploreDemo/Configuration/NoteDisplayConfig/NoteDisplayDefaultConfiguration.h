//
//  NoteDisplayDefaultConfiguration.h
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/20.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "NoteDisplayConfiguration.h"

@interface NoteDisplayDefaultConfiguration : NSObject<NoteDisplayConfiguration>

+ (void)fb_injectable;
+ (NSUInteger)integrationPriority;

+ (BOOL)showDeleteButton;
+ (UIColor *)noteBackgroundColor;

@end
