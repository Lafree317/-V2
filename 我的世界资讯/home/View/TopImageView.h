//
//  TopImageView.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopImageView : UIImageView{
    id _target;// 记录方法执行者
    SEL _action;// 记录方法
}
/** 添加方法 */
- (void)addTarget:(id)target action:(SEL)action;
@end
