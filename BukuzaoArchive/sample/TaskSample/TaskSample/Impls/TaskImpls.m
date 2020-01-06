//
//  TaskImpls.m
//  TaskSample
//
//  Created by everettjf on 2018/8/23.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "TaskImpls.h"

#define TaskDeclare(TaskName) \
@interface TaskName : NSObject \
@end \
@implementation TaskName \
+(void)run{ usleep(arc4random() % 4 * 1000 *1000 + 1000*1000); } \
@end

@interface TTHookTask : NSObject
@end
@implementation TTHookTask
+(void)run{
    usleep(arc4random() % 4 * 1000 *1000 + 1000*1000);
}
@end


TaskDeclare(TTObserveTask)

TaskDeclare(TTAppleTask)
TaskDeclare(TTBananaTask)
TaskDeclare(TTPearTask)

TaskDeclare(TTLoginTask)
TaskDeclare(TTPrepareTask)
TaskDeclare(TTPrefetchTask)
TaskDeclare(TTProcessTask)
TaskDeclare(TTCompletionTask)
TaskDeclare(TTDoneTask)

TaskDeclare(TTDownloadTask)
TaskDeclare(TTRenderTask)
