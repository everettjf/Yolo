NS_ASSUME_NONNULL_BEGIN


@interface APChatMedia : NSObject
@property(retain, nonatomic)  NSData * data; // @synthesize data=_data;
@property(retain, nonatomic) NSString *url; // @synthesize url=_url;
@end


@interface CTMessageCell : UITableViewCell
- (void)collectMenu:(id)arg1;
- (void)evt_alert:(id)msg;
@property(retain, nonatomic) APChatMedia *voiceObj; // @synthesize voiceObj=_voiceObj;
@property(retain, nonatomic) NSDictionary *chatDataSource; // @synthesize chatDataSource=_chatDataSource;
@property(copy, nonatomic) NSString *timeLine; // @synthesize timeLine=_timeLine;

@end

@interface VoiceCache : NSObject
- (id)queryVoiceDataForKey:(id)arg1 formatType:(unsigned int)arg2;
@end

@interface APVoiceManager : NSObject
+ (id)sharedManager;
@property(retain, nonatomic) VoiceCache *voiceCache; // @synthesize voiceCache=_voiceCache;
@end


@interface MOBILECHATFAVCollectionVO : NSObject
@property(retain, nonatomic) NSString *link; // @synthesize link=_link;
@property(retain, nonatomic) NSDate *gmtCreate; // @synthesize gmtCreate=_gmtCreate;
@property(retain, nonatomic) NSString *cacheUserName; // @synthesize cacheUserName=_cacheUserName;

@end

@interface FavDetailAudioPlayerView : UIView
@property(retain, nonatomic) MOBILECHATFAVCollectionVO *data; // @synthesize data=_data;
@property(nonatomic) float length; // @synthesize length=_length;

@end

@interface FavAudioDetailViewController : UIViewController
@property(retain, nonatomic) FavDetailAudioPlayerView *audioPlayerView; // @synthesize audioPlayerView=_audioPlayerView;
- (void)actionSheet:(id)arg1 clickedButtonAtIndex:(int)arg2;
- (void)evt_alert:(id)msg;
- (void)viewDidLoad;

@end


NS_ASSUME_NONNULL_END
