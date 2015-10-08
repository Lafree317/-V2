//
//  TopImageView.m
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "TopImageView.h"

@implementation TopImageView

/** 添加方法 */
- (void)addTarget:(id)target action:(SEL)action{
    // 记录传入的方法和方法执行者
    _target = target;
    _action = action;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 让方法执行者 执行方法
    [_target performSelector:_action withObject:self];
}

@end
