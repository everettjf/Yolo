//
//  AppDelegate.m
//  FastImageCacheSample
//
//  Created by everettjf on 2018/8/28.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "AppDelegate.h"
#import "FastImageCache/FICImageCache.h"
#import "FastImageCache/FICUtilities.h"

@interface XXUser : NSObject <FICEntity>

@property (nonatomic, copy) NSString *name;

@end

@implementation XXUser

- (NSString *)fic_UUID{
    CFUUIDBytes UUIDBytes = FICUUIDBytesFromMD5HashOfString(_name);
    NSString *UUID = FICStringWithUUIDBytes(UUIDBytes);
    return UUID;
}

- (NSString *)fic_sourceImageUUID{
    CFUUIDBytes UUIDBytes = FICUUIDBytesFromMD5HashOfString(_name);
    NSString *UUID = FICStringWithUUIDBytes(UUIDBytes);
    return UUID;
}

- (NSURL *)fic_sourceImageURLWithFormatName:(NSString *)formatName{
    return [NSURL URLWithString:_name];
}

- (FICEntityImageDrawingBlock)fic_drawingBlockForImage:(UIImage *)image withFormatName:(NSString *)formatName{
    FICEntityImageDrawingBlock drawingBlock = ^(CGContextRef context, CGSize contextSize) {
        CGRect contextBounds = CGRectZero;
        contextBounds.size = contextSize;
        CGContextClearRect(context, contextBounds);

        UIGraphicsPushContext(context);
        [image drawInRect:contextBounds];
        UIGraphicsPopContext();
    };
    return drawingBlock;
}

@end

@interface AppDelegate ()<FICImageCacheDelegate>

@end

@implementation AppDelegate

- (NSArray<NSString*> *)getImages{
    NSArray *imageUrls = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"jpg" subdirectory:@"DemoImages"];
    NSMutableArray<NSString*> *images = [[NSMutableArray alloc] initWithCapacity:imageUrls.count];
    for(NSURL *url in imageUrls){
        NSString *urlString = [url absoluteString];
        [images addObject:urlString];
    }
    return images;
}

- (NSArray<XXUser*>*)getUsers{
    NSMutableArray *users = [[NSMutableArray alloc]initWithCapacity:99];
    for(NSUInteger idx = 1; idx <= 99; ++idx){
        NSString *name = [NSString stringWithFormat:@"FICDDemoImage%0.3lu",idx];
        XXUser *user = [[XXUser alloc]init];
        user.name = name;
        [users addObject:user];
    }
    return users;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    CFTimeInterval begin = CACurrentMediaTime();
//    [self normalImageNamedLoad];
//    [self normalLoad];
    [self fastLoad];
    CFTimeInterval end = CACurrentMediaTime();
    NSLog(@"cost = %@ms",@(1000 * (end - begin)));

    return YES;
}

- (void)normalLoad{
    NSArray *images = [self getImages];
    NSMutableArray * ret = [[NSMutableArray alloc] initWithCapacity:images.count];
    for(NSString *urlString in images){
        NSString *fixedString = [urlString stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        UIImage *img = [UIImage imageWithContentsOfFile:fixedString];
        [ret addObject:img];
    }
}

- (void)normalImageNamedLoad{
    NSMutableArray * ret = [[NSMutableArray alloc] initWithCapacity:100];
    for(NSUInteger idx = 1; idx <= 99; ++idx){
        NSString *name = [NSString stringWithFormat:@"FICDDemoImage%0.3lu",idx];
        UIImage *img = [UIImage imageNamed:name];
        [ret addObject:img];
    }
    
}


- (void)fastLoad{
    static NSString *formatName = @"com.mycompany.myapp.XXImageFormatNameUserThumbnailMedium";
    static NSString *familyName = @"com.mycompany.myapp.XXImageFormatFamilyUserThumbnails";
    
    FICImageFormat *mediumUserThumbnailImageFormat = [[FICImageFormat alloc] init];
    mediumUserThumbnailImageFormat.name = formatName;
    mediumUserThumbnailImageFormat.family = familyName;
    mediumUserThumbnailImageFormat.style = FICImageFormatStyle32BitBGRA;
    mediumUserThumbnailImageFormat.imageSize = CGSizeMake(100, 100);
    mediumUserThumbnailImageFormat.maximumCount = 250;
    mediumUserThumbnailImageFormat.devices = FICImageFormatDevicePhone;
    mediumUserThumbnailImageFormat.protectionMode = FICImageFormatProtectionModeNone;
    
    NSArray *imageFormats = @[mediumUserThumbnailImageFormat];
    FICImageCache * sharedImageCache = [FICImageCache sharedImageCache];
    sharedImageCache.delegate = self;
    [sharedImageCache setFormats:imageFormats];
    
    NSArray *users = [self getUsers];
    
    int cnt = 0;
    for(XXUser *user in users){
        BOOL imageExists = [sharedImageCache retrieveImageForEntity:user withFormatName:formatName completionBlock:^(id<FICEntity>  _Nullable entity, NSString * _Nonnull formatName, UIImage * _Nullable image) {
//            NSLog(@"%@ = %@",[entity fic_UUID],image);
        }];
        if(!imageExists){
            ++cnt;
//            NSLog(@"%@ not exists : %@",[user fic_UUID],@(cnt));
        }
    }

}

-(void)imageCache:(FICImageCache *)imageCache wantsSourceImageForEntity:(id<FICEntity>)entity withFormatName:(NSString *)formatName completionBlock:(FICImageRequestCompletionBlock)completionBlock{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [entity fic_sourceImageURLWithFormatName:@""];
        UIImage *img = [UIImage imageNamed:[url absoluteString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(img);
        });
    });
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
