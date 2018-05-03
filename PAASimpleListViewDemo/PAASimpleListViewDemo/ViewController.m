//
//  ViewController.m
//  PAASimpleListViewDemo
//
//  Created by everettjf on 2018/5/3.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "ViewController.h"
#import "PAAListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PAAListViewController *vc = [[PAAListViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:vc animated:YES];
    });
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
