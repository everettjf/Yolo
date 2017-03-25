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

#import "header.h"

%hook MailboxPickerController
%new
- (void)evt_showWhiteList{
	 
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"White List" message:@"Input an email address:" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *field = alertController.textFields.firstObject;
        if(field.text.length > 0){
            [[NSUserDefaults standardUserDefaults]setObject:field.text forKey:@"evt_whitelist"];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"xfz610@163.com";
        textField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"evt_whitelist"];
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)viewWillAppear:(BOOL)arg1{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"WhiteList" style:UIBarButtonItemStylePlain target:self action:@selector(evt_showWhiteList)];
    %orig;
}
%end

%hook MailboxContentViewController
- (void)megaMallMessageCountChanged:(id)arg1{
	%orig;

    NSMutableSet *targetMessages = [NSMutableSet setWithCapacity:100];
    NSString *whitelist = [[NSUserDefaults standardUserDefaults]objectForKey:@"evt_whitelist"];
    
    MessageMegaMall *mall = [arg1 object];
    
    NSSet *messages = [mall copyAllMessages];
    for (MFLibraryMessage *message in messages) {
        MFMessageInfo *messageInfo = [message copyMessageInfo];
        
        for(NSString *sender in [message senders]){
            if(!messageInfo.read
               && [sender rangeOfString:[NSString stringWithFormat:@"<%@>",whitelist]].location == NSNotFound){
                [targetMessages addObject:message];
            }
        }
        [messageInfo release];
    }
    [messages release];
    
    [mall markMessagesAsViewed:targetMessages];
}

%end

