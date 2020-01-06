//
//  TKKTaskManager.h
//  TaskSample
//
//  Created by everettjf on 2018/8/23.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKKTaskManager : NSObject

+ (instancetype)sharedManager;

- (void)runBasicTasks;
- (void)runAsyncTasks;
- (void)runSyncTasks;
- (void)runAsyncTasksAfterLaunch;

@end
