//
//  ViewController.m
//  PrintfRedirectDemo
//
//  Created by everettjf on 2020/3/3.
//  Copyright © 2020 dsfdsafd. All rights reserved.
//

#import "ViewController.h"
#import "redirect_stdout.h"

static UITextView *sTextView = nil;

static void current_output(const char* buff, int len) {
    NSString *text = [sTextView text];
    text = [text stringByAppendingFormat:@"%s",buff];
    [sTextView setText:text];
}

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sTextView = self.textView;
    
    set_redirect_output(current_output);
        
    printf("hello\n");
    printf("hello\n");
    printf("hello\n");
    printf("hello\n");

}


@end
