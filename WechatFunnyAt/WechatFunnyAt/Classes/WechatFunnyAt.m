//
//  WechatFunnyAt.m
//  WechatFunnyAt
//
//  Created by everettjf on 02/08/2017.
//  Copyright © 2017 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CaptainHook.h"

/*
 -[CMessageMgr AddMsg:MsgWrap:]
 */

NSString *filterContent(NSString* content){
    if(!content)
        return nil;
    
    if([content rangeOfString:@"@"].location == NSNotFound)
        return content;
    
    NSRange range = [content rangeOfString:@">"];
    if(range.location == NSNotFound)
        return content;
    
    NSString *newContent = [content substringFromIndex:range.location + 1];
    return newContent;
}


@interface CMessageWrap
@property (nonatomic, strong) NSString* m_nsContent;
@end

CHDeclareClass(CMessageMgr)

CHMethod2(void, CMessageMgr, AddMsg, NSString*, msg, MsgWrap, CMessageWrap*, msgWrap){
    NSString* content = filterContent([msgWrap m_nsContent]);
    if(content){
        [msgWrap setM_nsContent:content];
    }
    
    CHSuper2(CMessageMgr, AddMsg, msg, MsgWrap, msgWrap);
}

CHConstructor{
    CHLoadLateClass(CMessageMgr);
    CHClassHook2(CMessageMgr, AddMsg, MsgWrap);
}

