//
//  ViewController.m
//  ModFuncInitApp
//
//  Created by everettjf on 2016/12/5.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "ViewController.h"



const char* getallinitinfo();

@interface ViewController ()

@end

@implementation ViewController

+ (void)load{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"allinitinfo = %s",getallinitinfo());
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
