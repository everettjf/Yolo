//
//  ViewController.m
//  ChatCellFrameChangeDemo
//
//  Created by everettjf on 16/6/18.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "ViewController.h"
#import "ChatCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSUInteger _count;
    UIView *_bottomView;
    UITextField *_inputView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count = 30;
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
    [self.view addSubview:_bottomView];
    
    {
        _inputView = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-100, 40)];
        _inputView.backgroundColor = [UIColor grayColor];
        [_bottomView addSubview:_inputView];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-100,0,100, 40)];
        [button setTitle:@"Add Item" forState:UIControlStateNormal];
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
    [_tableView registerClass:[ChatCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)_addItemTapped:(id)sender{
    ++_count;
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
}

- (void)_scrollTableViewToBottom{
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//    [self _fillCell:cell indexPath:indexPath];
    
    [UIView performWithoutAnimation:^{
        [self _fillCell:cell indexPath:indexPath];
    }];
    
    return cell;
}

- (void)_fillCell:(ChatCell*)cell indexPath:(NSIndexPath*)indexPath{
    cell.text = [NSString stringWithFormat:@"%@",@(indexPath.row * indexPath.row * indexPath.row)];
    cell.mine = indexPath.row % 2 == 0;
    [cell layout];
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
    // TableView变小
//    _bottomView.frame = CGRectMake(0, self.view.bounds.size.height - 40 - offset, self.view.bounds.size.width, 40);
//    _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 40 - offset);
    
    // TableView大小不变，只向上移动
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

@end
