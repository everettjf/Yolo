//
//  TKKTaskList.m
//  TaskSample
//
//  Created by everettjf on 2018/8/23.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "TKKTaskList.h"

@implementation TKKTaskList

+ (NSArray<NSString*>*)basicTasks
{
    static NSArray<NSString*> *tasks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = @[
                  @"TTHookTask",
                  @"TTObserveTask",
                  ];
    });
    return tasks;
}

+ (NSArray<NSString *> *)syncTasks
{
    static NSArray<NSString*> *tasks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = @[
                  @"TTAppleTask",
                  @"TTBananaTask",
                  @"TTPearTask",
                  ];
    });
    return tasks;
}

+ (NSArray<NSString *> *)asyncTasks
{
    static NSArray<NSString*> *tasks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = @[
                  @"TTLoginTask",
                  @"TTPrepareTask",
                  @"TTPrefetchTask",
                  @"TTProcessTask",
                  @"TTCompletionTask",
                  @"TTDoneTask",
                  ];
    });
    return tasks;
}

+ (NSArray<NSString *> *)asyncTasksAfterLaunch
{
    static NSArray<NSString*> *tasks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = @[
                  @"TTDownloadTask",
                  @"TTRenderTask",
                  ];
    });
    return tasks;
}
@end
