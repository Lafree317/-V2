//
//  TopView.m
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "TopView.h"
#import "TopImageView.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"

@interface TopView ()<UIScrollViewDelegate>
@property (nonatomic , assign) CGSize scrollSize;
@property (nonatomic , assign) NSInteger count;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIPageControl *pageControl;
@end


@implementation TopView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        // 记录属性
        _scrollSize.height = self.frame.size.height-10;
        _scrollSize.width = self.frame.size.width-10;
        
        // 创建scrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 5, _scrollSize.width, _scrollSize.height)];
        // 设置属性
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
        self.scrollView.bouncesZoom = NO;
        self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        
        [self addSubview:_scrollView];
        
    }
    return self;
}


/** 保存数组搭建界面 */
- (void)layoutAndSetDataArr:(NSMutableArray *)dataArr{
    self.dataArray = [NSMutableArray arrayWithArray:dataArr];
    
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    
    self.scrollView.contentSize = CGSizeMake(_scrollSize.width * _dataArray.count, _scrollSize.height);
    /** 搭建内容界面 */
    [self layoutContent];
    
   

}
/** 搭建内容界面 */
- (void)layoutContent{
    for (int i = 0; i < _dataArray.count; i++) {
        
        // 创建图片
        TopImageView *imageView = [[TopImageView alloc] initWithFrame:CGRectMake(i * _scrollSize.width,0, _scrollSize.width, _scrollSize.height)];
        imageView.tag = 200+i;
        DetailModel *detail = _dataArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:detail.litpic] placeholderImage:[UIImage imageNamed:@"lufei"]];
        imageView.userInteractionEnabled = YES;
        // 给imageView添加方法
        [imageView addTarget:self action:@selector(imageTouch:)];
        
        [self.scrollView addSubview:imageView];
        
    }
    
    // 底部View
    UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(5, self.frame.size.height-25, _scrollSize.width, 20)];
    view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    [self addSubview:view];
    
    // 标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _scrollSize.width-60, 20)];
    _titleLabel.text = [_dataArray[_count] shorttitle];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowOffset = CGSizeMake(1, 1);
    _titleLabel.shadowColor = [UIColor grayColor];
    [view addSubview:_titleLabel];

    
    
    
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(view.frame.size.width - 100, 0, 100, 20)];
    _pageControl.numberOfPages = _dataArray.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_pageControl];
}
/** 图片点击方法 */
- (void)imageTouch:(TopImageView *)image{
    
    [_delegate touchImagePassTag:image.tag-200];
    
}

- (void)pageControlAction:(UIPageControl *)pageControl{
    _scrollView.contentOffset = CGPointMake(_scrollSize.width * pageControl.currentPage, 0);
    
}


- (void)timerStart{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(topImageMove) userInfo:nil repeats:YES];
}
- (void)timerEnd{
    [_timer invalidate];
}
// scrollView内的移动方法
- (void)topImageMove{
    [self autoMove];

}
/** 移动方法 */
- (void)autoMove{
    _count = self.scrollView.contentOffset.x/_scrollSize.width;
    if(_count < _dataArray.count - 1){
        _count ++ ;
    }else{
        _count = 0;
        self.scrollView.contentOffset = CGPointZero;
    }
    _titleLabel.text = [_dataArray[_count] shorttitle];
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(_count * _scrollSize.width, 0);
    }];
}
// 当最下层scrollview检测到拖动时 停止time方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self timerEnd];

}
// 当scrollview结束拖拽
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self timerStart];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = self.scrollView.contentOffset.x/_scrollSize.width;
    _titleLabel.text = [_dataArray[_pageControl.currentPage] shorttitle];
}


@end
