//
//  DownView.m
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "DownView.h"
#import "DetailModel.h"
#import "DownCell.h"
#import "MJRefresh.h"
@interface DownView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DownView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20)];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"DownCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aa"];
        [self addSubview:_tableView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, 100, 16)];
        label.text = @"最新更新";
        [self addSubview:label];
        _count = 1;
        
        [self setupRefresh];
    }
    return self;
}
- (void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [_delegate refreshDataWithPage:_count];
        _count++;
        
        [self endedrefresh];
        
    }];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)

}
#pragma mark 开始进入刷新状态

- (void)endedrefresh{
    // 刷新表格
    [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView.footer endRefreshing];
}
- (void)layoutTableViewWithArr:(NSArray *)arr{
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    
    
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myManager.AllDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailModel *detail = _myManager.AllDataArr[indexPath.row];
    DownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
    cell.title.text = detail.shorttitle;
    cell.time.text = detail.pubdate;
    
    cell.backgroundColor = [UIColor clearColor];

    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_delegate whenCellClickPassRow:indexPath.row];
}
@end
