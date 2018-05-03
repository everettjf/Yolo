//
//  PAAListViewController.m
//  PAASimpleListViewDemo
//
//  Created by everettjf on 2018/5/3.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "PAAListViewController.h"

@interface PAAListViewController ()

@end

@implementation PAAListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];

    self.groups = @[
                    @{
                        @"title":@"Group One",
                        @"rows" : @[
                                    @{
                                        @"title":@"Row One",
                                        @"action":^(){
                                            NSLog(@"hello world");
                                        },
                                        },
                                    @{
                                        @"title":@"Row One",
                                        @"action":^(){
                                            NSLog(@"hello world");
                                        },
                                        },
                                   ]
                     },
                    @{
                        @"title":@"Group Two",
                        @"rows" : @[
                                @{
                                    @"title":@"Row One",
                                    @"action":^(){
                                        NSLog(@"world");
                                    },
                                    },
                                @{
                                    @"title":@"Row One",
                                    @"action":^(){
                                        NSLog(@"world");
                                    },
                                    },
                                ]
                        },
                    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *group = [self.groups objectAtIndex:section];
    NSArray *rows= [group objectForKey:@"rows"];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *group = [self.groups objectAtIndex:indexPath.section];
    NSArray *rows= [group objectForKey:@"rows"];
    NSDictionary *row = [rows objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [row objectForKey:@"title"];;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *group = [self.groups objectAtIndex:section];
    return [group objectForKey:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *group = [self.groups objectAtIndex:indexPath.section];
    NSArray *rows= [group objectForKey:@"rows"];
    NSDictionary *row = [rows objectAtIndex:indexPath.row];
    
    void (^action)(void) = [row objectForKey:@"action"];
    action();
}


@end
