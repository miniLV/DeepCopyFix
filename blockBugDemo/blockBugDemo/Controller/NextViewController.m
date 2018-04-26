//
//  NextViewController.m
//  blockBugDemo
//
//  Created by 梁宇航 on 2018/4/26.
//  Copyright © 2018年 梁宇航. All rights reserved.
//

#import "NextViewController.h"
#import "DemoCell.h"
#import "DemoModel.h"

@interface NextViewController ()

<
UITableViewDataSource,
DemoCellDelegate
>

@end

@implementation NextViewController{
    NSArray *_datas;
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseSetting];
    
    [self setupUI];
    
    [self loadDatas];
}


- (void)baseSetting{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"demoVC";
}

#pragma mark - setupUI
- (void)setupUI{
    
    CGFloat naviH = 64;
    CGFloat tabBarH = 49;
    CGFloat viewH = 667;
    CGFloat viewW = 375;
    
    //tableView
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, naviH, viewW, viewH - naviH - tabBarH);
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    
    //bottomBtn
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, viewH - tabBarH, viewW, tabBarH);
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(p_clickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - lodaDatas
- (void)loadDatas{
    
    if (_deviceDatas.count) {
        
        _datas = _deviceDatas;
    }
    else{
        //initDatas
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0 ; i < 5; i ++) {
            DemoModel *model = [[DemoModel alloc]init];
            [arrayM addObject:model];
        }
        _datas = @[arrayM];
    }
    [_tableView reloadData];
    
}

#pragma mark - controlTouch
- (void)p_clickBottomBtn{
    
    [self.view endEditing:YES];
    if (_block) {
        
        _block(_datas);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - privateDelegate
- (void)mn_endEditTextField:(UITextField *)sender{
    
    NSInteger section = sender.tag / 100;
    NSInteger row = sender.tag % 100;
    DemoModel *model = _datas[section][row];
    model.textFieldValue = sender.text;
////    kRefreshTableView(_tableView, row, section);
//    _tableView reloadRowsAtIndexPaths:@[[NSIndexPath]] withRowAnimation:<#(UITableViewRowAnimation)#>
//
}

#pragma mark - <UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemoModel *model = _datas[indexPath.section][indexPath.row];
    DemoCell *cell = [DemoCell createCellWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID" WithTableView:tableView];
    cell.indexPath = indexPath;
    cell.model = model;
    cell.mnDelegate = self;
    return cell;
}

@end
