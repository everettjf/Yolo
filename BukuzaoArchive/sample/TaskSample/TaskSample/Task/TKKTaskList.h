//
//  TKKTaskList.h
//  TaskSample
//
//  Created by everettjf on 2018/8/23.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKKTaskList : NSObject

+ (NSArray<NSString*>*)basicTasks;

+ (NSArray<NSString*>*)syncTasks;

+ (NSArray<NSString*>*)asyncTasks;

+ (NSArray<NSString*>*)asyncTasksAfterLaunch;

@end
