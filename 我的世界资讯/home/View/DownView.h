//
//  DownView.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetDataManager.h"

@protocol DownViewDelegate <NSObject>

- (void)whenCellClickPassRow:(NSInteger)row;
- (void)refreshDataWithPage:(NSInteger)page;
@end


@interface DownView : UIView
@property (nonatomic,assign)id<DownViewDelegate>delegate;
@property (nonatomic,strong) GetDataManager *myManager;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger count ;
- (void)layoutTableViewWithArr:(NSArray *)arr;
- (void)endedrefresh;
@end
