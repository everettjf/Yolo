//
//  ViewController.m
//  bukuzao
//
//  Created by everettjf on 2018/8/5.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "ViewController.h"
#import "Tokamak.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


    CFTimeInterval launchCostSince1stLoad = [TKKLaunchTime currentAbsoluteTime] - [TKKLaunchTime appLaunchBeginAbsoluteTime];
    NSLog(@"app launch cost since 1st load : %@ s",@(launchCostSince1stLoad));
    
    NSTimeInterval currentSystemTime = [TKKLaunchTime currentSystemTime];
    NSTimeInterval processCreateSystemTime = [TKKLaunchTime processCreateTime];
    NSLog(@"app launch cost since process create : %@ s",@(currentSystemTime - processCreateSystemTime));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
