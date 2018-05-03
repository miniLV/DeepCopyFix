//
//  DemoCell.m
//  blockBugDemo
//
//  Created by 梁宇航 on 2018/4/26.
//  Copyright © 2018年 梁宇航. All rights reserved.
//

#import "DemoCell.h"
#import "DemoModel.h"
@implementation DemoCell{
    UITextField *_textField;
}

- (void)setModel:(DemoModel *)model{
    
    NSInteger tag = _indexPath.section * 100 + _indexPath.row;
    _textField.tag = tag;
    _textField.text = model.textFieldValue;
}

+ (instancetype)createCellWithStyle:(UITableViewCellStyle)style
                    reuseIdentifier:(NSString *)reuseIdentifier
                      WithTableView:(UITableView *_Nullable)tableView
{
    
    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[self alloc]initWithStyle:style
                          reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //1.创建控件
        [self p_createControls];
    }
    return self;
}


- (void)p_createControls{
    UITextField *textField = [[UITextField alloc]init];
    [self.contentView addSubview:textField];
    textField.frame = CGRectMake(0, 0, 250, 40);
    textField.backgroundColor = [UIColor orangeColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField addTarget:self action:@selector(p_endEditTextField:) forControlEvents:UIControlEventEditingDidEnd];
    _textField = textField;
}

- (void)p_endEditTextField:(UITextField *)sender{
    
    [_delegate respondsToSelector:@selector(endEditTextField:)] ?
    [_delegate endEditTextField:sender] : nil;
}

@end
