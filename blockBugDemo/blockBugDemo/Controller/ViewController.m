//
//  ViewController.m
//  blockBugDemo
//
//  Created by 梁宇航 on 2018/4/26.
//  Copyright © 2018年 梁宇航. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "DemoModel.h"

@interface ViewController ()

@property (nonatomic, copy)NSArray *pushNextDatas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self baseSetting];
    
    [self setupUI];
}

- (void)baseSetting{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"rootVC";
}

#pragma mark - setupUI
- (void)setupUI{
    
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [self.view addSubview:centerBtn];
    centerBtn.center = self.view.center;
    [centerBtn addTarget:self action:@selector(p_clickBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_clickBtn{
    
    NextViewController *vc = [[NextViewController alloc]init];
    vc.rootVcDatas = self.pushNextDatas;
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc setBlock:^(NSArray *basicDatas) {
        
        self.pushNextDatas = basicDatas;
    }];
}

@end
