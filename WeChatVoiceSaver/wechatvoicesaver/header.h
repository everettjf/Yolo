NS_ASSUME_NONNULL_BEGIN


@interface FavAudioInfo : NSObject

@property(retain, nonatomic) NSString *m_nsAudioID; // @synthesize m_nsAudioID;
@property(retain, nonatomic) NSString *m_nsAudioPath; // @synthesize m_nsAudioPath;
@property(nonatomic) unsigned long m_uiAudioDuration; // @synthesize m_uiAudioDuration;
@property(nonatomic) unsigned long m_uiAudioFormat; // @synthesize m_uiAudioFormat;
@property(nonatomic) unsigned long m_uiAudioID; // @synthesize m_uiAudioID;

@end


@interface FavAudioPlayerController : UIView
{
    FavAudioInfo *m_audioInfo;
}
- (void)evt_alert:(id)msg;

@end

NS_ASSUME_NONNULL_END



