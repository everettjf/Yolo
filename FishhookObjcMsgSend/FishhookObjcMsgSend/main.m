#import <dlfcn.h>

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

void gohook();



@interface Test :NSObject
+(void)hello;
@end
@implementation Test
+(void)hello{
    printf("hello\n");
    [self internal];
    
//    NSString *str = [NSString stringWithUTF8String:"hi"];
    NSString *s = @"hi";
    NSLog(s);
}

+(void)world{
    printf("world\n");
    
}

+(void)internal{
    
    printf("internal\n");
}

@end

int main(int argc, char * argv[])
{
    @autoreleasepool {
        gohook();
        
        NSString *s = @"hi";
        NSLog(s);
//        [Test hello];
//        [Test world];

//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
