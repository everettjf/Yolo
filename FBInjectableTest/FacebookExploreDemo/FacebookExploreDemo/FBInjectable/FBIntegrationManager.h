//
//  FBIntegrationManager.h
//  FacebookExploreDemo
//
//  Created by everettjf on 16/8/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBIntegrationManager : NSObject

+ (Class)classForProtocol:(Protocol*)protocol;
+ (NSArray<Class>*)classesForProtocol:(Protocol*)protocol;

@end
