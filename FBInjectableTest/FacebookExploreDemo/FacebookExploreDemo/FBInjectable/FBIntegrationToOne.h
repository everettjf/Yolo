//
//  FBIntegrationToOne.h
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FBInjectableDATA __attribute((used, section("__DATA,FBInjectable")))

@protocol FBIntegrationToOne <NSObject>
+ (NSUInteger)integrationPriority;
@end
