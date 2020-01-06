// See http://iphonedevwiki.net/index.php/Logos

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>

%hook FBSceneManager

- (void)_beginSynchronizationBlock{
    NSLog(@"%@ %@",@"FBSceneManager",NSStringFromSelector(_cmd));
    %orig;
}
- (void)_endSynchronizationBlock{
    NSLog(@"%@ %@",@"FBSceneManager",NSStringFromSelector(_cmd));
    %orig;
}

%end

%hook FBSynchronizedTransactionGroup

-(void)addSynchronizedTransaction:(id)arg1{
    NSLog(@"%@ %@ : arg1=%@",@"FBSynchronizedTransactionGroup",NSStringFromSelector(_cmd),arg1);
    %orig;
}

//-(void)synchronizedTransaction:(id)arg1 didCommitSynchronizedTransactions:(id)arg2
//{
//    NSLog(@"%@ %@ : arg1=%@,arg2=%@",@"FBSynchronizedTransactionGroup",NSStringFromSelector(_cmd),arg1,arg2);
//    %orig;
//}
//
//-(void)synchronizedTransactionReadyToCommit:(id)arg1{
//    NSLog(@"%@ %@ : arg1=%@",@"FBSynchronizedTransactionGroup",NSStringFromSelector(_cmd),arg1);
//    %orig;
//}

-(void)performSynchronizedCommit{
    NSLog(@"%@ %@",@"FBSynchronizedTransactionGroup",NSStringFromSelector(_cmd));
    %orig;
}

%end

%hook FBWorkspaceEventQueue

- (void)executeOrAppendEvent:(id)arg1
{
    NSLog(@"%@ %@ : arg1=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1);
    %orig;
}
-(void)executeOrPrependEvents:(id)arg1{
    NSLog(@"%@ %@ : arg1=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1);
    %orig;
}
-(void)executeOrPrependEvent:(id)arg1{
    NSLog(@"%@ %@ : arg1=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1);
    %orig;
}

-(void)executeOrInsertEvents:(id)arg1 atPosition:(NSUInteger)arg2{
    NSLog(@"%@ %@ : arg1=%@,arg2=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1,@(arg2));
    %orig;
}

%end

%hook SBIconController

- (void)iconTapped:(id)arg1
{
    NSLog(@"%@ %@ : arg1=%@",@"SBIconController",NSStringFromSelector(_cmd),arg1);
    %orig;
}
- (void)_launchFromIconView:(id)arg1
{
    NSLog(@"%@ %@ : arg1=%@",@"SBIconController",NSStringFromSelector(_cmd),arg1);
    %orig;
}

%end


%hook SBFolderController
- (void)prepareToLaunchTappedIcon:(id)arg1 completionHandler:(id)arg2
{
    NSLog(@"%@ %@ : arg1=%@,arg2=%@",@"SBFolderController",NSStringFromSelector(_cmd),arg1,arg2);
    %orig(arg1,arg2);
}
- (void)setCurrentPageIndexToListDirectlyContainingIcon:(id)arg1 animated:(BOOL)arg2 completion:(id)arg3
{
    NSLog(@"%@ %@ : arg1=%@,arg2=%@,arg3=%@",@"SBFolderController",NSStringFromSelector(_cmd),arg1,@(arg2),arg3);
}

- (BOOL)isDisplayingIcon:(id)arg1
{
    BOOL ret =  %orig;
    NSLog(@"%@ %@ : arg1=%@,return=%@",@"SBFolderController",NSStringFromSelector(_cmd),arg1,@(ret));
    return ret;
}

- (BOOL)_isAppIconForceTouchControllerPeekingOrShowing
{
    BOOL ret =  %orig;
    NSLog(@"%@ %@ : return=%@",@"SBFolderController",NSStringFromSelector(_cmd),@(ret));
    return ret;
}
%end


