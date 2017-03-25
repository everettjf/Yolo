@interface MailboxPickerController : UITableViewController
@end

@interface NSConcreteNotification : NSNotification
@end

@interface MessageMegaMall : NSObject
- (void)markMessagesAsViewed:(id)arg1;
- (id)copyAllMessages;
@end

@interface MFMessageInfo : NSObject
@property (nonatomic) BOOL read;
@end

@interface MFLibraryMessage : NSObject
- (id)senders;
- (id)copyMessageInfo;
@end
