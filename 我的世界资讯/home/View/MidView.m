//
//  MidView.m
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "MidView.h"

@interface MidView ()
@property (nonatomic,assign) CGSize viewSize;
@end

@implementation MidView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        self.viewSize = self.frame.size;
        
    }
    return self;
}
- (void)layoutButtonWithDataArr:(NSArray *)arr{
    CGFloat buttonWidth = (_viewSize.width - 25)/4;
    CGFloat buttonHight = (_viewSize.height - 15)/2;
    NSInteger num1 = 0;
    NSInteger num2 = 0;
    for (int i = 0; i < 8; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i < 4) {
            bt.frame = CGRectMake(5+num1*(buttonWidth+5), 5, buttonWidth, buttonHight);
            num1++;
        }else{
            bt.frame = CGRectMake(5+num2*(buttonWidth+5), 10+buttonHight, buttonWidth, buttonHight);
            num2++;
        }
        [bt setTitle:arr[i] forState:UIControlStateNormal];
        bt.tag = 900+i;
        [bt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bt0%d",i+1]] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt];
    }
    
}

- (void)btClick:(UIButton *)bt{
    [_delegate whenButtonClickPassKey:bt.titleLabel.text];
}

@end
