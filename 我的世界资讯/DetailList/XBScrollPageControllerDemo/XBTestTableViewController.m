//
//  XBTestTableViewController.m
//  XBScrollPageControllerDemo
//
//  Created by Scarecrow on 15/9/8.
//  Copyright (c) 2015年 xiu8. All rights reserved.
//

#import "XBTestTableViewController.h"
#import "XBConst.h"
#import "GetDataManager.h"
#import "DetailModel.h"
#import "UIImageView+WebCache.h"
#import "XBTableViewCell.h"
#import "WebViewController.h"
#import "DemoHandle.h"
#import "NewsTableViewCell.h"
#import "MJRefresh.h"

@interface XBTestTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) GetDataManager *manager;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger dataCount;
@property (nonatomic,assign) BOOL isUnNormol;
@property (nonatomic,strong) NSString *request;

@end

@implementation XBTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"aa"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bb"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.manager = [[GetDataManager alloc] init];
    self.count = 1;
    if ([[DemoHandle shardDemoHandl].navigationTitle isEqualToString:@"指令教程"]|| [[DemoHandle shardDemoHandl].navigationTitle isEqualToString:@"实用材料"]) {
        _isUnNormol = YES;
    }else{
        _isUnNormol = NO;
    }
    [self footerRereshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (_dataCount == _manager.AllDataArr.count) {
            [self.tableView.footer noticeNoMoreData];
        }
        
        
        
        _dataCount = _manager.AllDataArr.count;
        
        
        [self footerRereshing];
    }];
}

#pragma mark 开始进入刷新状态
- (void)footerRereshing
{

    if (_isUnNormol) {
        NSString *requestFront = @"http://zhushouapi.gamedog.cn/index.php?a=lists&";
        NSString *requestBack = [NSString  stringWithFormat:@"arcenumid=%@&m=Article&page=%ld",_XBParam,_count];
        self.request = [requestFront stringByAppendingString:requestBack];
    }else{
        NSString *requestFront = @"http://zhushouapi.gamedog.cn/index.php?a=lists&m=Article&";
        NSString *requestBack = [NSString  stringWithFormat:@"page=%ld&pageSize=10&typeid=%@",_count,_XBParam];
        self.request = [requestFront stringByAppendingString:requestBack];
    }
    [self.manager getDataWithUrlString:_request AndBlock:^{
        [self.tableView reloadData];
        _count++;
    }];
    [self endedrefresh];
}
- (void)endedrefresh{
    // 刷新表格
    [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView.footer endRefreshing];
}



- (void)setXBParam:(NSString *)XBParam
{
    _XBParam = XBParam;
    XBLog(@"XBTestTableViewController received param === %@",XBParam);
}
- (void)dealloc
{
    XBLog(@"XBTestTableViewController delloc");

}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _manager.AllDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

     if ([[DemoHandle shardDemoHandl].navigationTitle isEqualToString:@"新闻资讯"]|| [[DemoHandle shardDemoHandl].navigationTitle isEqualToString:@"攻略大全"] ||  _isUnNormol) {
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bb" forIndexPath:indexPath];
        DetailModel *detail = _manager.AllDataArr[indexPath.row];
        cell.newsTitle.text = detail.shorttitle;
        cell.newsDate.text = detail.pubdate;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        return cell;
    }else{
        XBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
        DetailModel *detail = _manager.AllDataArr[indexPath.row];
        [cell.leftImage sd_setImageWithURL:[NSURL URLWithString:detail.litpic] placeholderImage:[UIImage imageNamed:@"suolong"]];
        cell.titleLabel.text = detail.shorttitle;
        cell.dateLabel.text = detail.pubdate;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        return cell;
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailModel *detail = _manager.AllDataArr[indexPath.row];
    WebViewController *wevVC = [[WebViewController alloc] init];
    wevVC.navigationTitle = detail.shorttitle;
    wevVC.urlStr = [NSString stringWithFormat:@"http://zhushouapi.gamedog.cn/index.php?m=Article&a=show&pageSize=10&aid=%@",detail.aid];
    [self.navigationController pushViewController:wevVC animated:YES];
}


@end
