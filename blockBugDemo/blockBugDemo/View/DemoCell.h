//
//  DemoCell.h
//  blockBugDemo
//
//  Created by 梁宇航 on 2018/4/26.
//  Copyright © 2018年 梁宇航. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DemoModel;
@protocol DemoCellDelegate <NSObject>

- (void)endEditTextField:(UITextField *_Nullable)sender;

@end

@interface DemoCell : UITableViewCell

+ (instancetype)createCellWithStyle:(UITableViewCellStyle)style
                    reuseIdentifier:(NSString *)reuseIdentifier
                      WithTableView:(UITableView *_Nullable)tableView;

@property (nonatomic, strong) DemoModel *model;

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, weak) id <DemoCellDelegate> delegate;

@end
