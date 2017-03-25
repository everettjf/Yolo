//
//  EIMMessageManager.h
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EIMMessageWrap.h"

@interface EIMMessageManager : NSObject

+ (EIMMessageManager*)manager;

- (NSArray*)getMessageArray;

@end
