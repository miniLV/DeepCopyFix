//
//  ViewController.m
//  AFNHeaderDemo
//
//  Created by 梁宇航 on 2017/12/13.
//  Copyright © 2017年 梁宇航. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "YHAFNHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI{

    //leftBtn
    UIButton *leftBtn = [[UIButton alloc]init];
    leftBtn.frame = CGRectMake(50, 200, 100, 40);
    [leftBtn setBackgroundColor:[UIColor orangeColor]];
    [leftBtn setTitle:@"普通get请求" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    //rightBtn
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.frame = CGRectMake(200, 200, 100, 40);
    [rightBtn setBackgroundColor:[UIColor lightGrayColor]];
    [rightBtn setTitle:@"抽离请求体" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
}

#pragma mark - btn click
- (void)clickLeftBtn{

    NSString *urlStr = @"https://testapi.henzfin.com/policies?limit=30&offset=30&state=pending+payment@";
    
    [YHAFNHelper get:urlStr parameter:nil success:^(id responseObject) {
        NSLog(@"success -- !,url = %@",urlStr);
    } faliure:^(id error) {
        
    }];
    
}

- (void)clickRightBtn{
    

    NSString *urlStr = @"http://testapi.henzfin.com/policies";
    
    //limit=30&offset=30&state=pending+payment
    
    NSDictionary *dict = @{
                           @"limit":@"30",
                           @"offset":@"30",
                           @"state":@"pending payment",
                           };
    
    [YHAFNHelper get:urlStr parameter:dict success:^(id responseObject) {
        
        NSLog(@"success -- !,url = %@",urlStr);
        
    } faliure:^(id error) {
        
    }];
    
    
}




@end
