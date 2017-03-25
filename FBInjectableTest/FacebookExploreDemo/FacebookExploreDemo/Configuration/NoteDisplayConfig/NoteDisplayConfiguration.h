//
//  NoteDisplayConfiguration.h
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/20.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "FBIntegrationToOne.h"

#import <UIKit/UIKit.h>

@protocol NoteDisplayConfiguration<FBIntegrationToOne>

+ (BOOL)showDeleteButton;
+ (UIColor *)noteBackgroundColor;

@end
