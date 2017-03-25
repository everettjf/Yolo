@interface WCContentItem : NSObject
@property(retain, nonatomic) NSMutableArray *mediaList; // @synthesize mediaList;
@end

@interface WCDataItem : NSObject 
@property(retain, nonatomic) WCContentItem *contentObj; // @synthesize contentObj;
@end

@interface WCUrl : NSObject
@property(retain, nonatomic) NSString *url; // @synthesize url;
@end

@interface WCMediaItem : NSObject
@property(retain, nonatomic) WCUrl *dataUrl; // @synthesize dataUrl;
- (id)pathForSightData;

@end

@interface WCContentItemViewTemplateNewSight : UIView
- (WCMediaItem*)evt_mediaItemFromSight;
- (void)evt_onSaveToDisk;
- (void)evt_onCopyURL;
- (void)evt_alert:(id)msg;

@end


@interface MMServiceCenter : NSObject
+ (id)defaultCenter;
- (id)getService:(Class)arg1;
@end


@interface WCFacade : NSObject
- (id)getTimelineDataItemOfIndex:(int)arg1;

@end

@interface WCTimeLineViewController : NSObject
- (int)calcDataItemIndex:(int)arg1;
@end

@interface MMTableViewCell : UITableViewCell
@end


@interface MMTableView : UITableView
@end
