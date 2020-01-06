//
//  ViewController.m
//  SignPostSample
//
//  Created by everettjf on 2018/8/12.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CFTimeInterval begin = CACurrentMediaTime();
    // do something
    CFTimeInterval end = CACurrentMediaTime();
    NSLog(@"cost = %@",@(end - begin));
    
}



@end
