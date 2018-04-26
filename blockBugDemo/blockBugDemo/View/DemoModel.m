//
//  DemoModel.m
//  blockBugDemo
//
//  Created by 梁宇航 on 2018/4/26.
//  Copyright © 2018年 梁宇航. All rights reserved.
//

#import "DemoModel.h"

@implementation DemoModel

// 当将一个自定义对象保存到文件的时候就会调用该方法
// 在该方法中说明如何存储自定义对象的属性
// 也就说在该方法中说清楚存储自定义对象的哪些属性
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"调用了encodeWithCoder:方法");
    [aCoder encodeObject:self.textFieldValue forKey:@"textFieldValue"];
}

// 当从文件中读取一个对象的时候就会调用该方法
// 在该方法中说明如何读取保存在文件中的对象
// 也就是说在该方法中说清楚怎么读取文件中的对象
-(id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"调用了initWithCoder:方法");
    //注意：在构造方法中需要先初始化父类的方法
    if (self=[super init]) {
        self.textFieldValue=[aDecoder decodeObjectForKey:@"textFieldValue"];

    }
    return self;
}

@end
