//
//  AppDelegate.m
//  ThreadNumberDemo
//
//  Created by everettjf on 2018/11/12.
//  Copyright © 2018 everettjf. All rights reserved.
// _____   _     _   _____   _____    _____   _____   _____       _   _____
//| ____| | |   / / | ____| |  _  \  | ____| |_   _| |_   _|     | | |  ___|
//| |__   | |  / /  | |__   | |_| |  | |__     | |     | |       | | | |__
//|  __|  | | / /   |  __|  |  _  /  |  __|    | |     | |    _  | | |  __|
//| |___  | |/ /    | |___  | | \ \  | |___    | |     | |   | |_| | | |
//|_____| |___/     |_____| |_|  \_\ |_____|   |_|     |_|   \_____/ |_|
//

#import "AppDelegate.h"
#import "pthread.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)testCost:(NSString*)name callback:(void(^)(void)) callback{
    CFTimeInterval begin = CACurrentMediaTime();
    
    callback();
    
    CFTimeInterval end = CACurrentMediaTime();
    NSLog(@"%@ms - %@",@((end - begin) * 1000),name);
}

#define kMaxCount 10000

- (void)test{
    
    NSLog(@"[[NSThread currentThread] description] = %@", [[NSThread currentThread] description]);
    NSLog(@"[NSThread currentThread] = %p",[NSThread currentThread]);
    NSLog(@"pthread_self = %p",pthread_self());
    uint64_t tid;
    pthread_threadid_np(NULL, &tid);
    NSLog(@"pthread_threadid_np = %llu",tid);
    NSLog(@"");
    
    [self testCost:@"NSThread description" callback:^{
        for(int i = 0; i < kMaxCount; i++){
            [[NSThread currentThread] description];
        }
    }];
    
    [self testCost:@"NSThread" callback:^{
        for(int i = 0; i < kMaxCount; i++){
            [NSThread currentThread];
        }
    }];
    
    [self testCost:@"pthread_self" callback:^{
        for(int i = 0; i < kMaxCount; i++){
            pthread_t tid = pthread_self();
        }
    }];
    
    
    [self testCost:@"pthread_threadid_np" callback:^{
        for(int i = 0; i < kMaxCount; i++){
            uint64_t tid;
            pthread_threadid_np(NULL, &tid);
        }
    }];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"-------main thread------");

    [self test];
    
    NSLog(@"-------child thread------");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self test];
    });
    return YES;
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
