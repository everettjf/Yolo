//
//  AppDelegate.m
//  SignPostSample
//
//  Created by everettjf on 2018/8/12.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "AppDelegate.h"
#include <os/signpost.h>

void doSomethingOther(){
    sleep(1);
}
void doSomethingShort(){
    sleep(arc4random() % 3 + 1);
}
void doSomethingLong(){
    sleep(arc4random() % 3 + 1);
}

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [self dotest1];
    
//    [self dotest2];
    
    [self dotest3];
    
    return YES;
}

- (void)dotest1{
    // 第一步，创建一个log对象
    os_log_t log = os_log_create("com.everettjf.sample.signpost", "hellosignpost");

    // 创建os_signpost的ID
    os_signpost_id_t spid = os_signpost_id_generate(log);

    // 标记开始和结束
    os_signpost_interval_begin(log, spid, "task");
    doSomethingShort();
    os_signpost_interval_end(log, spid, "task");
}

- (void)dotest2{
    
    
    os_log_t log = os_log_create("com.everettjf.sample.signpost", "thread");
    os_signpost_id_t spid = os_signpost_id_generate(log);
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.everettjf.test1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("com.everettjf.test2", DISPATCH_QUEUE_SERIAL);
    
    for(int i = 0; i < 10; i++){
        dispatch_async(queue1, ^{
            doSomethingOther();
            os_signpost_interval_begin(log, spid, "task", "infobegin%d", i);
            doSomethingShort();
            os_signpost_interval_end(log, spid, "task","infoend%d",i);
        });
        
        dispatch_async(queue2, ^{
            doSomethingOther();
            os_signpost_interval_begin(log, spid, "task2","info");
            doSomethingLong();
            os_signpost_interval_end(log, spid, "task2");
        });
    }
    

}
- (void)dotest3{
    
    os_log_t loginterest = os_log_create("com.everettjf.sample.signpost", OS_LOG_CATEGORY_POINTS_OF_INTEREST);
    os_signpost_id_t spidinterest = os_signpost_id_generate(loginterest);
    
    os_log_t log = os_log_create("com.everettjf.sample.signpost", "thread");
    os_signpost_id_t spid = os_signpost_id_generate(log);
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.everettjf.test1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("com.everettjf.test2", DISPATCH_QUEUE_SERIAL);
    
    for(int i = 0; i < 10; i++){
        dispatch_async(queue1, ^{
            doSomethingOther();
            os_signpost_interval_begin(log, spid, "task", "infobegin%d", i);
            doSomethingShort();
            os_signpost_interval_end(log, spid, "task","infoend%d",i);
        });
        
        dispatch_async(queue2, ^{
            doSomethingOther();
            os_signpost_interval_begin(log, spid, "task2","info");
            doSomethingLong();
            os_signpost_event_emit(loginterest, spidinterest, "alive");
            doSomethingShort();
            os_signpost_interval_end(log, spid, "task2");
        });
    }
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
