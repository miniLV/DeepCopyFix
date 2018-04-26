//
//  NextViewController.h
//  blockBugDemo
//
//  Created by 梁宇航 on 2018/4/26.
//  Copyright © 2018年 梁宇航. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^carAddDeviceSuccess)(NSArray *basicDatas);

@interface NextViewController : UIViewController

@property (nonatomic, copy)carAddDeviceSuccess block;

//历史的设备信息列表 - 传进来修改
@property (nonatomic, copy)NSArray *deviceDatas;

- (void)retunBlock:(carAddDeviceSuccess)block;

@end
