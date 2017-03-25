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
#import <UIKit/UIkit.h>
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>

int main(int argc, char * argv[]);


@interface FBNewsFeedViewController : UIViewController
- (void)didTapPublishCheckInButton:(id)arg1;
@end

%hook FBNewsFeedViewController

- (void)didTapPublishCheckInButton:(id)arg1{
 
    
    const struct mach_header *mhp = _dyld_get_image_header(0);

    
    unsigned long size = 0;
    uint8_t *data = getsectiondata(mhp, "__DATA", "FBInjectable", & size);
    NSData *d = [NSData dataWithBytes:(const void *)data length:72];
    
    
    NSString *text = [NSString stringWithFormat:@"%@", d];
    NSLog(@"injectable text = %@", text);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    
}

%end
