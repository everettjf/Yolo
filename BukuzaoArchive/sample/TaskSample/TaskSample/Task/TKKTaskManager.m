//
//  TKKTaskManager.m
//  TaskSample
//
//  Created by everettjf on 2018/8/23.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "TKKTaskManager.h"
#import "TKKTaskList.h"
#include <os/signpost.h>

os_log_t _log;
os_signpost_id_t _spid;

@implementation TKKTaskManager
{
    dispatch_queue_t _async_queue;
    dispatch_queue_t _async_queue_after_launch;
}

+ (instancetype)sharedManager{
    static TKKTaskManager *o;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        o = [[TKKTaskManager alloc] init];
    });
    return o;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _async_queue = dispatch_queue_create("com.everettjf.asynctask", DISPATCH_QUEUE_SERIAL);
        _async_queue_after_launch = dispatch_queue_create("com.everettjf.asynctaskafterlaunch", DISPATCH_QUEUE_SERIAL);

        _log = os_log_create("com.everettjf.taskmamager", "task");
        _spid = os_signpost_id_generate(_log);
    }
    return self;
}

- (void)runBasicTasks
{
    [TKKTaskManager executeTasks:[TKKTaskList basicTasks] queue:0];
}

- (void)runAsyncTasks
{
    dispatch_async(_async_queue, ^{
        [TKKTaskManager executeTasks:[TKKTaskList asyncTasks] queue:1];
    });
}


- (void)runSyncTasks
{
    [TKKTaskManager executeTasks:[TKKTaskList syncTasks] queue:0];
}

- (void)runAsyncTasksAfterLaunch
{
    dispatch_async(_async_queue_after_launch, ^{
        [TKKTaskManager executeTasks:[TKKTaskList asyncTasks] queue:2];
    });
}

+ (void)executeTasks:(NSArray<NSString*>*) tasks queue:(int)queueType
{
    for(NSString *className in tasks){
        if(queueType == 0)
            os_signpost_interval_begin(_log, _spid, "0 main","%s",className.UTF8String);
        else if(queueType == 1)
            os_signpost_interval_begin(_log, _spid, "1 async","%s",className.UTF8String);
        else
            os_signpost_interval_begin(_log, _spid, "2 async after launch","%s",className.UTF8String);

        Class cls = NSClassFromString(className);
        if([cls respondsToSelector:@selector(run)]){
            [cls run];
        }else{
            NSLog(@"no +run for %@", className);
        }
        
        if(queueType == 0)
            os_signpost_interval_end(_log, _spid, "0 main","%s",className.UTF8String);
        else if(queueType == 1)
            os_signpost_interval_end(_log, _spid, "1 async","%s",className.UTF8String);
        else
            os_signpost_interval_end(_log, _spid, "2 async after launch","%s",className.UTF8String);
        
        
        usleep(1000*300);
    }
}

@end
