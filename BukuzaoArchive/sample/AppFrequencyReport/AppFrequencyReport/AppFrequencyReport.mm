#line 1 "/Users/everettjf/github/bukuzao/sample/AppFrequencyReport/AppFrequencyReport/AppFrequencyReport.xm"


#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class FBSceneManager; @class SBFolderController; @class FBSynchronizedTransactionGroup; @class FBWorkspaceEventQueue; @class SBIconController; 
static void (*_logos_orig$_ungrouped$FBSceneManager$_beginSynchronizationBlock)(_LOGOS_SELF_TYPE_NORMAL FBSceneManager* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$FBSceneManager$_beginSynchronizationBlock(_LOGOS_SELF_TYPE_NORMAL FBSceneManager* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$FBSceneManager$_endSynchronizationBlock)(_LOGOS_SELF_TYPE_NORMAL FBSceneManager* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$FBSceneManager$_endSynchronizationBlock(_LOGOS_SELF_TYPE_NORMAL FBSceneManager* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$FBSynchronizedTransactionGroup$addSynchronizedTransaction$)(_LOGOS_SELF_TYPE_NORMAL FBSynchronizedTransactionGroup* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$FBSynchronizedTransactionGroup$addSynchronizedTransaction$(_LOGOS_SELF_TYPE_NORMAL FBSynchronizedTransactionGroup* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$FBSynchronizedTransactionGroup$performSynchronizedCommit)(_LOGOS_SELF_TYPE_NORMAL FBSynchronizedTransactionGroup* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$FBSynchronizedTransactionGroup$performSynchronizedCommit(_LOGOS_SELF_TYPE_NORMAL FBSynchronizedTransactionGroup* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrAppendEvent$)(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrAppendEvent$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvents$)(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvents$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvent$)(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvent$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrInsertEvents$atPosition$)(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id, NSUInteger); static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrInsertEvents$atPosition$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST, SEL, id, NSUInteger); static void (*_logos_orig$_ungrouped$SBIconController$iconTapped$)(_LOGOS_SELF_TYPE_NORMAL SBIconController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBIconController$iconTapped$(_LOGOS_SELF_TYPE_NORMAL SBIconController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$SBIconController$_launchFromIconView$)(_LOGOS_SELF_TYPE_NORMAL SBIconController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBIconController$_launchFromIconView$(_LOGOS_SELF_TYPE_NORMAL SBIconController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$SBFolderController$prepareToLaunchTappedIcon$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$SBFolderController$prepareToLaunchTappedIcon$completionHandler$(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$SBFolderController$setCurrentPageIndexToListDirectlyContainingIcon$animated$completion$)(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL, id, BOOL, id); static void _logos_method$_ungrouped$SBFolderController$setCurrentPageIndexToListDirectlyContainingIcon$animated$completion$(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL, id, BOOL, id); static BOOL (*_logos_orig$_ungrouped$SBFolderController$isDisplayingIcon$)(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL, id); static BOOL _logos_method$_ungrouped$SBFolderController$isDisplayingIcon$(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$_ungrouped$SBFolderController$_isAppIconForceTouchControllerPeekingOrShowing)(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$SBFolderController$_isAppIconForceTouchControllerPeekingOrShowing(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST, SEL); 

#line 9 "/Users/everettjf/github/bukuzao/sample/AppFrequencyReport/AppFrequencyReport/AppFrequencyReport.xm"


static void _logos_method$_ungrouped$FBSceneManager$_beginSynchronizationBlock(_LOGOS_SELF_TYPE_NORMAL FBSceneManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"%@ %@",@"FBSceneManager",NSStringFromSelector(_cmd));
    _logos_orig$_ungrouped$FBSceneManager$_beginSynchronizationBlock(self, _cmd);
}
static void _logos_method$_ungrouped$FBSceneManager$_endSynchronizationBlock(_LOGOS_SELF_TYPE_NORMAL FBSceneManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"%@ %@",@"FBSceneManager",NSStringFromSelector(_cmd));
    _logos_orig$_ungrouped$FBSceneManager$_endSynchronizationBlock(self, _cmd);
}





static void _logos_method$_ungrouped$FBSynchronizedTransactionGroup$addSynchronizedTransaction$(_LOGOS_SELF_TYPE_NORMAL FBSynchronizedTransactionGroup* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    NSLog(@"%@ %@ : arg1=%@",@"FBSynchronizedTransactionGroup",NSStringFromSelector(_cmd),arg1);
    _logos_orig$_ungrouped$FBSynchronizedTransactionGroup$addSynchronizedTransaction$(self, _cmd, arg1);
}












static void _logos_method$_ungrouped$FBSynchronizedTransactionGroup$performSynchronizedCommit(_LOGOS_SELF_TYPE_NORMAL FBSynchronizedTransactionGroup* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"%@ %@",@"FBSynchronizedTransactionGroup",NSStringFromSelector(_cmd));
    _logos_orig$_ungrouped$FBSynchronizedTransactionGroup$performSynchronizedCommit(self, _cmd);
}






static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrAppendEvent$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"%@ %@ : arg1=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1);
    _logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrAppendEvent$(self, _cmd, arg1);
}
static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvents$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    NSLog(@"%@ %@ : arg1=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1);
    _logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvents$(self, _cmd, arg1);
}
static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvent$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    NSLog(@"%@ %@ : arg1=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1);
    _logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvent$(self, _cmd, arg1);
}

static void _logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrInsertEvents$atPosition$(_LOGOS_SELF_TYPE_NORMAL FBWorkspaceEventQueue* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, NSUInteger arg2){
    NSLog(@"%@ %@ : arg1=%@,arg2=%@",@"FBWorkspaceEventQueue",NSStringFromSelector(_cmd),arg1,@(arg2));
    _logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrInsertEvents$atPosition$(self, _cmd, arg1, arg2);
}






static void _logos_method$_ungrouped$SBIconController$iconTapped$(_LOGOS_SELF_TYPE_NORMAL SBIconController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"%@ %@ : arg1=%@",@"SBIconController",NSStringFromSelector(_cmd),arg1);
    _logos_orig$_ungrouped$SBIconController$iconTapped$(self, _cmd, arg1);
}

static void _logos_method$_ungrouped$SBIconController$_launchFromIconView$(_LOGOS_SELF_TYPE_NORMAL SBIconController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"%@ %@ : arg1=%@",@"SBIconController",NSStringFromSelector(_cmd),arg1);
    _logos_orig$_ungrouped$SBIconController$_launchFromIconView$(self, _cmd, arg1);
}






static void _logos_method$_ungrouped$SBFolderController$prepareToLaunchTappedIcon$completionHandler$(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    NSLog(@"%@ %@ : arg1=%@,arg2=%@",@"SBFolderController",NSStringFromSelector(_cmd),arg1,arg2);
    _logos_orig$_ungrouped$SBFolderController$prepareToLaunchTappedIcon$completionHandler$(self, _cmd, arg1,arg2);
}

static void _logos_method$_ungrouped$SBFolderController$setCurrentPageIndexToListDirectlyContainingIcon$animated$completion$(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, BOOL arg2, id arg3) {
    NSLog(@"%@ %@ : arg1=%@,arg2=%@,arg3=%@",@"SBFolderController",NSStringFromSelector(_cmd),arg1,@(arg2),arg3);
}


static BOOL _logos_method$_ungrouped$SBFolderController$isDisplayingIcon$(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    BOOL ret =  _logos_orig$_ungrouped$SBFolderController$isDisplayingIcon$(self, _cmd, arg1);
    NSLog(@"%@ %@ : arg1=%@,return=%@",@"SBFolderController",NSStringFromSelector(_cmd),arg1,@(ret));
    return ret;
}


static BOOL _logos_method$_ungrouped$SBFolderController$_isAppIconForceTouchControllerPeekingOrShowing(_LOGOS_SELF_TYPE_NORMAL SBFolderController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    BOOL ret =  _logos_orig$_ungrouped$SBFolderController$_isAppIconForceTouchControllerPeekingOrShowing(self, _cmd);
    NSLog(@"%@ %@ : return=%@",@"SBFolderController",NSStringFromSelector(_cmd),@(ret));
    return ret;
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$FBSceneManager = objc_getClass("FBSceneManager"); MSHookMessageEx(_logos_class$_ungrouped$FBSceneManager, @selector(_beginSynchronizationBlock), (IMP)&_logos_method$_ungrouped$FBSceneManager$_beginSynchronizationBlock, (IMP*)&_logos_orig$_ungrouped$FBSceneManager$_beginSynchronizationBlock);MSHookMessageEx(_logos_class$_ungrouped$FBSceneManager, @selector(_endSynchronizationBlock), (IMP)&_logos_method$_ungrouped$FBSceneManager$_endSynchronizationBlock, (IMP*)&_logos_orig$_ungrouped$FBSceneManager$_endSynchronizationBlock);Class _logos_class$_ungrouped$FBSynchronizedTransactionGroup = objc_getClass("FBSynchronizedTransactionGroup"); MSHookMessageEx(_logos_class$_ungrouped$FBSynchronizedTransactionGroup, @selector(addSynchronizedTransaction:), (IMP)&_logos_method$_ungrouped$FBSynchronizedTransactionGroup$addSynchronizedTransaction$, (IMP*)&_logos_orig$_ungrouped$FBSynchronizedTransactionGroup$addSynchronizedTransaction$);MSHookMessageEx(_logos_class$_ungrouped$FBSynchronizedTransactionGroup, @selector(performSynchronizedCommit), (IMP)&_logos_method$_ungrouped$FBSynchronizedTransactionGroup$performSynchronizedCommit, (IMP*)&_logos_orig$_ungrouped$FBSynchronizedTransactionGroup$performSynchronizedCommit);Class _logos_class$_ungrouped$FBWorkspaceEventQueue = objc_getClass("FBWorkspaceEventQueue"); MSHookMessageEx(_logos_class$_ungrouped$FBWorkspaceEventQueue, @selector(executeOrAppendEvent:), (IMP)&_logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrAppendEvent$, (IMP*)&_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrAppendEvent$);MSHookMessageEx(_logos_class$_ungrouped$FBWorkspaceEventQueue, @selector(executeOrPrependEvents:), (IMP)&_logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvents$, (IMP*)&_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvents$);MSHookMessageEx(_logos_class$_ungrouped$FBWorkspaceEventQueue, @selector(executeOrPrependEvent:), (IMP)&_logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvent$, (IMP*)&_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrPrependEvent$);MSHookMessageEx(_logos_class$_ungrouped$FBWorkspaceEventQueue, @selector(executeOrInsertEvents:atPosition:), (IMP)&_logos_method$_ungrouped$FBWorkspaceEventQueue$executeOrInsertEvents$atPosition$, (IMP*)&_logos_orig$_ungrouped$FBWorkspaceEventQueue$executeOrInsertEvents$atPosition$);Class _logos_class$_ungrouped$SBIconController = objc_getClass("SBIconController"); MSHookMessageEx(_logos_class$_ungrouped$SBIconController, @selector(iconTapped:), (IMP)&_logos_method$_ungrouped$SBIconController$iconTapped$, (IMP*)&_logos_orig$_ungrouped$SBIconController$iconTapped$);MSHookMessageEx(_logos_class$_ungrouped$SBIconController, @selector(_launchFromIconView:), (IMP)&_logos_method$_ungrouped$SBIconController$_launchFromIconView$, (IMP*)&_logos_orig$_ungrouped$SBIconController$_launchFromIconView$);Class _logos_class$_ungrouped$SBFolderController = objc_getClass("SBFolderController"); MSHookMessageEx(_logos_class$_ungrouped$SBFolderController, @selector(prepareToLaunchTappedIcon:completionHandler:), (IMP)&_logos_method$_ungrouped$SBFolderController$prepareToLaunchTappedIcon$completionHandler$, (IMP*)&_logos_orig$_ungrouped$SBFolderController$prepareToLaunchTappedIcon$completionHandler$);MSHookMessageEx(_logos_class$_ungrouped$SBFolderController, @selector(setCurrentPageIndexToListDirectlyContainingIcon:animated:completion:), (IMP)&_logos_method$_ungrouped$SBFolderController$setCurrentPageIndexToListDirectlyContainingIcon$animated$completion$, (IMP*)&_logos_orig$_ungrouped$SBFolderController$setCurrentPageIndexToListDirectlyContainingIcon$animated$completion$);MSHookMessageEx(_logos_class$_ungrouped$SBFolderController, @selector(isDisplayingIcon:), (IMP)&_logos_method$_ungrouped$SBFolderController$isDisplayingIcon$, (IMP*)&_logos_orig$_ungrouped$SBFolderController$isDisplayingIcon$);MSHookMessageEx(_logos_class$_ungrouped$SBFolderController, @selector(_isAppIconForceTouchControllerPeekingOrShowing), (IMP)&_logos_method$_ungrouped$SBFolderController$_isAppIconForceTouchControllerPeekingOrShowing, (IMP*)&_logos_orig$_ungrouped$SBFolderController$_isAppIconForceTouchControllerPeekingOrShowing);} }
#line 113 "/Users/everettjf/github/bukuzao/sample/AppFrequencyReport/AppFrequencyReport/AppFrequencyReport.xm"
