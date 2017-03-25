
@interface ICNote : NSObject
- (id)noteAsPlainText;
@end


@interface ICNoteEditorViewController : UIViewController
@property(retain, nonatomic) ICNote *note; // @synthesize note=_note;
@end

