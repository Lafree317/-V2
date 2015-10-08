//
//  TopView.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(NSInteger);

@protocol TopViewDelegate <NSObject>

- (void)touchImagePassTag:(NSInteger)tag;

@end


@interface TopView : UIView
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , assign) id<TopViewDelegate>delegate;


/** 移动方法 */
- (void)autoMove;
/** 保存数组搭建界面 */
- (void)layoutAndSetDataArr:(NSMutableArray *)dataArr;
/** 计时器控制方法 */
- (void)timerStart;
- (void)timerEnd;
@end
