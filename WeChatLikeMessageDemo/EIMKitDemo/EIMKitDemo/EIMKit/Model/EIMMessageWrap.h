//
//  EIMMessageWrap.h
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,EIMMessageType){
    EIMMessageTypeText = 0,
    EIMMessageTypeImage = 1,
};

@interface EIMMessageWrap : NSObject

@property (assign,nonatomic) EIMMessageType type;
@property (assign,nonatomic) BOOL mine;

@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *text;

+(EIMMessageWrap*)createImage:(BOOL)mine image:(NSString*)image;
+(EIMMessageWrap*)createText:(BOOL)mine text:(NSString*)text;

@end
