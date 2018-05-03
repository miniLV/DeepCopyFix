//
//  NextViewController.h
//  blockBugDemo
//
//  Created by 梁宇航 on 2018/4/26.
//  Copyright © 2018年 梁宇航. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MNSuccessBlock)(NSArray *basicDatas);

@interface NextViewController : UIViewController

@property (nonatomic, copy)MNSuccessBlock block;

//ViewController传进来的数据 - 要在demoVC展示
@property (nonatomic, copy)NSArray *rootVcDatas;

- (void)retunBlock:(MNSuccessBlock)block;

@end
