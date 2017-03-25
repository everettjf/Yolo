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

static MMTableViewCell *evt_cell;
static MMTableView *evt_view;
static WCTimeLineViewController *evt_controller;

%hook WCContentItemViewTemplateNewSight

%new
- (void)evt_alert:(id)msg{
	UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                message:[NSString stringWithFormat:@"%@",msg]
                                                delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    [alert show];
}


%new
- (WCMediaItem*)evt_mediaItemFromSight{

	id responder = self;
	while(! [responder isKindOfClass:NSClassFromString(@"WCTimeLineViewController")]){
		if([responder isKindOfClass:NSClassFromString(@"MMTableViewCell")]){
			evt_cell = responder;
		}else if([responder isKindOfClass:NSClassFromString(@"MMTableView")]){
			evt_view = responder;
		}

		responder = [responder nextResponder];
	}
	evt_controller = responder;

	if(!evt_cell || !evt_view || !evt_controller){		
		[self evt_alert:@"can not get video"];
		return nil;
	}

	NSIndexPath *indexPath = [evt_view indexPathForCell:evt_cell];
	if(!indexPath){
		[self evt_alert:@"index path nil"];
		return nil;
	}
	int itemIndex = [evt_controller calcDataItemIndex:[indexPath section]];

	WCFacade *facade = [(MMServiceCenter*)[%c(MMServiceCenter)defaultCenter] getService:[%c(WCFacade) class]];
	if(!facade){
		[self evt_alert:@"facade nil"];
		return nil;
	}

	WCDataItem *dataItem = [facade getTimelineDataItemOfIndex:itemIndex];
	if(!dataItem){
		[self evt_alert:@"data item nil"];
		return nil;
	}

	WCContentItem *contentItem = dataItem.contentObj;
	if(!contentItem){
		[self evt_alert:@"content item nil"];
		return nil;
	}

	WCMediaItem *mediaItem = contentItem.mediaList.count != 0 ? contentItem.mediaList[0] : nil;
	if(!mediaItem){
		[self evt_alert:@"media item nil"];
		return nil;
	}

	return mediaItem;
}
%new
- (void)evt_onSaveToDisk{
 	WCMediaItem *media = [self evt_mediaItemFromSight];
 	if(!media){
 		return;
 	}
	NSString *localPath = [media pathForSightData];
	[self evt_alert:localPath];

	UISaveVideoAtPathToSavedPhotosAlbum(localPath,nil,nil,nil);
}
%new
- (void)evt_onCopyURL{
 	WCMediaItem *media = [self evt_mediaItemFromSight];
 	if(!media){
 		return;
 	}

	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = media.dataUrl.url;

	[self evt_alert:pasteboard.string];
}

- (void)onLongTouch{

	[self becomeFirstResponder];

	UIMenuItem *saveToDiskMenuItem = [[UIMenuItem alloc]initWithTitle:@"Save to Disk" action:@selector(evt_onSaveToDisk)];
	UIMenuItem *copyURLMenuItem = [[UIMenuItem alloc]initWithTitle:@"Copy URL" action:@selector(evt_onCopyURL)];

	UIMenuController *menuController = [UIMenuController sharedMenuController];
	[menuController setMenuItems:@[saveToDiskMenuItem, copyURLMenuItem]];
	[menuController setTargetRect:CGRectMake(0,0,0,0) inView:self];
	[menuController setMenuVisible:YES animated:YES];
}


%end
