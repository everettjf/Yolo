//
//  EIMMessageViewController.m
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "EIMMessageViewController.h"
#import "EIMMultiSelectTableViewCell.h"
#import "EIMMessageNodeData.h"
#import "EIMTextMessageNodeView.h"
#import "EIMImageMessageNodeView.h"
#import "EIMMessageManager.h"
#import "EIMUtility.h"

@interface EIMMessageViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *_bottomView;
    UITextField *_inputView;
    
    NSMutableArray<EIMMessageNodeData*> *_messageNodeData;
    NSMutableArray<Class> *_messageNodeClass;
}

@end

@implementation EIMMessageViewController

- (void)_initMessageNodeClass{
    _messageNodeClass = [NSMutableArray new];
    [_messageNodeClass addObject:EIMTextMessageNodeView.class];
    [_messageNodeClass addObject:EIMImageMessageNodeView.class];
}

- (void)_initMessageNodeData{
    _messageNodeData = [NSMutableArray new];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initMessageNodeClass];
    [self _initMessageNodeData];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
    [self.view addSubview:_bottomView];
    
    {
        _inputView = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-100, 40)];
        _inputView.backgroundColor = [UIColor grayColor];
        [_bottomView addSubview:_inputView];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-100,0,100, 40)];
        [button setTitle:@"Send" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_addItemTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 40)
                                             style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[EIMMultiSelectTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self initHistroyMessageNodeData];
}

- (void)_addItemTapped:(id)sender{
    static int i =0 ,j = 0;
    
    EIMMessageWrap *msg;
    if(++i % 2==0)
        msg = [EIMMessageWrap createText:++j %2==0 text:@"Helloooooooooooooooooooooooooooooooooooooooooo"];
    else
        msg = [EIMMessageWrap createImage:++j % 2 ==0 image:@"image"];
    
    [self addMessageNode:msg];
    
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
}

- (void)_scrollTableViewToBottom{
    if(!_messageNodeData)return;
    if(_messageNodeData.count==0)return;
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageNodeData.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageNodeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EIMMultiSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    EIMMessageNodeData *node = [_messageNodeData objectAtIndex:indexPath.row];
    [cell.contentView addSubview:node.view];
    
//    [UIView performWithoutAnimation:^{
//    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EIMMessageNodeData *node = [_messageNodeData objectAtIndex:indexPath.row];
    return node.cellHeight;
}



- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self _setBottomOffset:height];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
    
    [self _scrollTableViewToBottom];
}

- (void)keyboardWillHide:(NSNotification*)notification{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self _setBottomOffset:0];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
    
    [self _scrollTableViewToBottom];
}

- (void)_setBottomOffset:(CGFloat)offset{
    _bottomView.frame = CGRectMake(0, self.view.bounds.size.height - 40 - offset, self.view.bounds.size.width, 40);
    _tableView.frame = CGRectMake(0, -offset, self.view.bounds.size.width, self.view.bounds.size.height - 40);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_inputView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)preCreateMessageContentNode:(EIMMessageNodeData*)nodeData{
    if(nodeData.view)
        return;
    
    for (Class cls in _messageNodeClass) {
        if(![cls canCreateMessageNodeViewInstanceWithMessageWrap:nodeData.messageWrap])
            continue;
        
        nodeData.view = [[cls alloc]initWithMessageWrap:nodeData.messageWrap];
    }
    
    if(!nodeData.view){
        //Default to Text
        nodeData.view = [[EIMTextMessageNodeView alloc]initWithMessageWrap:nodeData.messageWrap];
    }
    
    nodeData.cellHeight = nodeData.view.bounds.size.height;
}

- (void)addMessageNode:(EIMMessageWrap*)messageWrap{
    EIMMessageNodeData *node = [EIMMessageNodeData new];
    node.messageWrap = messageWrap;
    
    [self preCreateMessageContentNode:node];
    
    [_messageNodeData addObject:node];
}

- (void)initHistroyMessageNodeData{
    // Read from db
    NSArray<EIMMessageWrap*> *arr = [[EIMMessageManager manager]getMessageArray];
    for (EIMMessageWrap *msg in arr) {
        [self addMessageNode:msg];
    }
    
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
}

@end
