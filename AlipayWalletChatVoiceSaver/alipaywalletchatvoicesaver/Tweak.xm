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
#import <mach-o/dyld.h>
#import <dlfcn.h>
#import "header.h"


/*
// these
int fake_ptrace(int request, pid_t pid, caddr_t addr, int data){
	return 0;
}

void *(*old_dlsym)(void *handle, const char *symbol);

void *my_dlsym(void *handle, const char *symbol){
	if(strcmp(symbol,"ptrace") == 0){
		return (void*)fake_ptrace;
	}

	return old_dlsym(handle,symbol);
}

%ctor{
	MSHookFunction((void*)dlsym,(void*)my_dlsym,(void**)&old_dlsym);
}
*/

// or these
static int (*oldptrace)(int request, pid_t pid, caddr_t addr, int data);
static int newptrace(int request, pid_t pid, caddr_t addr, int data){
	return 0; // just return zero
/*
	// or return oldptrace with request -1
	if (request == 31) {
		request = -1;
	}
	return oldptrace(request,pid,addr,data);
*/
}


%ctor {
	MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"), (void *)newptrace, (void **)&oldptrace);
}


static APVoiceManager *s_voiceManager;
static UIColor *s_originalColor;

%hook CTMessageCell

%new
- (void)evt_alert:(id)msg{
	UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                message:[NSString stringWithFormat:@"%@",msg]
                                                delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    [alert show];
}

- (void)prepareForReuse{
	if(s_originalColor){
		self.backgroundColor = [UIColor whiteColor];
	}

	%orig;
}

/*
@{  "alignmentType":0,
	"templateData":@{
		"l":12,
		"v":"FGAegsGqTTaAB3n80shI_gAAACMAAQED"
		},
	"id":"12",
	"originId":"12",
	"data":@{
		"displayName":"everettjf",
		"sessionId":"2088002664597371",
		"bizImage":"Local_Image_CHAT.left",
		"hintName":"everettjf",
		"timeLine":#"2015-12-24 15:56:27 +0000",
		"HeadIcon":"http://tfs.alipayobjects.com/images/partner/T1IJphXc4XXXXXXXXX_160X160","action":"0","seed":"2088002664597371@145097258940385","cellSelected":"0","userType":"1","userID":"2088122631212590","v":"FGAegsGqTTaAB3n80shI_gAAACMAAQED","bizMemo":"[\xe8\xaf\xad\xe9\x9f\xb3]","fromUId":"2088002664597371","l":12,"fromLoginId":"eve***@outlook.com","bizType":"CHAT","bizRemind":"","toUId":"2088122631212590","clientMsgID":"2088002664597371@145097258940385","link":"","msgID":151224235627370001,"toLoginId":"","localId":6},"headerText":"Thursday 11:56 PM","msgType":0}

 */

- (void)collectMenu:(id)arg1{
	%orig;

	if(!s_originalColor){
		s_originalColor = self.backgroundColor;
	}

	self.backgroundColor = [UIColor greenColor];

	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.voiceObj.url;


	if(!s_voiceManager){
		[self evt_alert:@"voice manager null"];
		return;
	}
    NSDictionary *chatDataSource = self.chatDataSource;
    if(!chatDataSource){
    	return;
    }
    NSDictionary *chatData = [chatDataSource objectForKey:@"data"];
    if(!chatData){
    	return;
    }
    NSString *displayName = [chatData objectForKey:@"displayName"];
    if(! displayName || [displayName isEqualToString:@""]){
    	displayName = @"self";
    }

	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeLineString = [dateFormatter stringFromDate:[chatData objectForKey:@"timeLine"]]; 

	NSData *voiceData = [s_voiceManager.voiceCache queryVoiceDataForKey:self.voiceObj.url formatType:1];

	if(!voiceData){
		[self evt_alert:@"Can not get voice data from cache"];
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
    NSString *voiceUserDir = [voiceBaseDir stringByAppendingPathComponent:displayName];
    if(![fileManager fileExistsAtPath:voiceUserDir]){
        if(![fileManager createDirectoryAtPath:voiceUserDir withIntermediateDirectories:YES attributes:nil error:nil]){
        	[self evt_alert:@"error create dir"];
        	return;
        }
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%@(%@).wav",timeLineString,[self timeLine]];
    NSString *filePath = [voiceUserDir stringByAppendingPathComponent:fileName];
    if([voiceData writeToFile:filePath atomically:YES]){
    	NSString *msg = [NSString stringWithFormat:@"succeed saved to %@",filePath];
    	[self evt_alert:msg];
    }else{
    	[self evt_alert:@"failed to save"];
    }


}


%end

%hook APVoiceManager

+ (id)sharedManager{
	if(!s_voiceManager){
		s_voiceManager = %orig;
		return s_voiceManager;
	}
	return %orig;
}
%end


%hook FavAudioDetailViewController


%new
- (void)evt_alert:(id)msg{
	UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                message:[NSString stringWithFormat:@"%@",msg]
                                                delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    [alert show];
}

- (void)actionSheet:(id)arg1 clickedButtonAtIndex:(int)arg2{
	// Cancel Button
	if(arg2 != 1) {
		%orig;
		return;
	}

	if(!s_voiceManager){
		[self evt_alert:@"voice manager null, please play any voice"];
		return;
	}

	NSString *cloudId = self.audioPlayerView.data.link;

	NSString *displayName = self.audioPlayerView.data.cacheUserName;
    if(! displayName || [displayName isEqualToString:@""]){
    	displayName = @"self";
    }

	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeLineString = [dateFormatter stringFromDate:self.audioPlayerView.data.gmtCreate]; 

	NSData *voiceData = [s_voiceManager.voiceCache queryVoiceDataForKey:cloudId formatType:1];

	if(!voiceData){
		[self evt_alert:@"Can not get voice data from cache"];
		return;
	}

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = (id)[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSString *voiceBaseDir = [[url path] stringByAppendingPathComponent:@"favvoice"];
    if(![fileManager fileExistsAtPath:voiceBaseDir]){
        if(![fileManager createDirectoryAtPath:voiceBaseDir withIntermediateDirectories:YES attributes:nil error:nil]){
        	[self evt_alert:@"error create dir"];
        	return;
        }
    }
    NSString *voiceUserDir = [voiceBaseDir stringByAppendingPathComponent:displayName];
    if(![fileManager fileExistsAtPath:voiceUserDir]){
        if(![fileManager createDirectoryAtPath:voiceUserDir withIntermediateDirectories:YES attributes:nil error:nil]){
        	[self evt_alert:@"error create dir"];
        	return;
        }
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%@(%@).wav",timeLineString,[NSString stringWithFormat:@"%d",(int)self.audioPlayerView.length]];
    NSString *filePath = [voiceUserDir stringByAppendingPathComponent:fileName];
    if([voiceData writeToFile:filePath atomically:YES]){
    	NSString *msg = [NSString stringWithFormat:@"succeed saved to %@",filePath];
    	[self evt_alert:msg];
    }else{
    	[self evt_alert:@"failed to save"];
    }

	%orig;
}

- (void)viewDidLoad{
	%orig;

	self.view.backgroundColor = [UIColor cyanColor];
}

%end


