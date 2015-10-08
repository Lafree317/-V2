//
//  MidView.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MidViewDelegate <NSObject>

- (void)whenButtonClickPassKey:(NSString *)key;

@end


@interface MidView : UIView
@property (nonatomic,assign) id<MidViewDelegate>delegate;
- (void)layoutButtonWithDataArr:(NSArray *)arr;
@end
