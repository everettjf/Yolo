/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/

#import <substrate.h>
#import "header.h"


%hook FavAudioPlayerController

%new
- (void)evt_alert:(id)msg{
	UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                message:[NSString stringWithFormat:@"%@",msg]
                                                delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    [alert show];
}

- (void)onPlayBtnClick{
	FavAudioInfo *info = [self valueForKey:@"m_audioInfo"];

	if(!info){
		[self evt_alert:@"null"];
		return;
	}
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = (id)[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSString *voiceBaseDir = [[url path] stringByAppendingPathComponent:@"voice"];
    if(![fileManager fileExistsAtPath:voiceBaseDir]){
        if(![fileManager createDirectoryAtPath:voiceBaseDir withIntermediateDirectories:YES attributes:nil error:nil]){
        	[self evt_alert:@"error create dir"];
        	return;
        }
    }
    NSString *voiceUserDir = [voiceBaseDir stringByAppendingPathComponent:@"fav"];
    if(![fileManager fileExistsAtPath:voiceUserDir]){
        if(![fileManager createDirectoryAtPath:voiceUserDir withIntermediateDirectories:YES attributes:nil error:nil]){
        	[self evt_alert:@"error create dir"];
        	return;
        }
    }

    unsigned long seconds = info.m_uiAudioDuration / 1000;
    if(info.m_uiAudioDuration % 1000 > 0) ++seconds;
    
    NSString *fileName = [NSString stringWithFormat:@"%@(%@).silk",[NSDate date],@(seconds)];
    NSString *filePath = [voiceUserDir stringByAppendingPathComponent:fileName];

    NSString *srcPath = info.m_nsAudioPath;
    NSString *destPath = filePath;
    NSError *error = nil;
    [[NSFileManager defaultManager]copyItemAtPath:srcPath toPath:destPath error:&error];
    
    if(!error){
    	NSString *msg = [NSString stringWithFormat:@"succeed saved to %@",filePath];
    	[self evt_alert:msg];
    }else{
    	[self evt_alert:@"failed to save"];
    }

    %orig;
}

%end
