//
//  ChatCell.h
//  ChatCellFrameChangeDemo
//
//  Created by everettjf on 16/6/18.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell

@property (strong,nonatomic) NSString *text;
@property (assign,nonatomic) BOOL mine;

- (void)layout;

@end
