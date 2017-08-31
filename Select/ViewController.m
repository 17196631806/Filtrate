//
//  ViewController.m
//  Select
//
//  Created by YaSha_Tom on 2017/8/29.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ViewController.h"
#import "ChooseListView.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.selfNavigation = [[MyNavigationView alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
    self.selfNavigation.titileLabel.text = @"信息管理";
    [self.selfNavigation.rightButton setTitle:@"筛选"  forState:UIControlStateNormal];
    [self.selfNavigation.rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.selfNavigation.rightButton addTarget:self action:@selector(chooseData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selfNavigation];
}

- (void)chooseData {
    self.showMask = [[ShowAnimationView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.showMask];
    ChooseListView *chooseListView = [[ChooseListView alloc]initWithFrame:CGRectMake(0, 0, 255, 667)];
    [self.showMask.showView addSubview:chooseListView];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
