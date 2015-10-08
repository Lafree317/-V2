//
//  ViewController.m
//  我的世界资讯Demo
//
//  Created by huchunyuan on 15/10/2.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "ViewController.h"
#import "DetailModel.h"

#import "GetDataManager.h"
#import "WebViewController.h"
#import "TopView.h"
#import "MidView.h"
#import "DownView.h"
#import "DemoViewController.h"
#import "DemoHandle.h"
#import "AFNetworking.h"




@interface ViewController ()<TopViewDelegate,MidViewDelegate,DownViewDelegate>
@property (nonatomic,strong) GetDataManager *topManager;
@property (nonatomic,strong) GetDataManager *downManager;
@property (nonatomic,strong) NSMutableDictionary *midDataDic;
@property (nonatomic,strong) TopView *topView;
@property (nonatomic,strong) MidView *midView;
@property (nonatomic,strong) DownView *downTableView;

@end

@implementation ViewController

// 当视图将要加载时请求网络
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 顶部请求数据
        NSString *topUrlStr = @"http://zhushouapi.gamedog.cn/index.php?a=lists&flag=f%2Cp%2Cl&m=Article&page=1&typeid=724";
        self.topManager = [[GetDataManager alloc] init];
        [self.topManager getDataWithUrlString:topUrlStr AndBlock:^{
            [_topView layoutAndSetDataArr:_topManager.AllDataArr];
            
        }];
        
        // 底部
        self.downManager = [[GetDataManager alloc] init];
        [self.downManager getDataWithUrlString:@"http://zhushouapi.gamedog.cn/index.php?a=lists&m=Article&page=1&pageSize=10&typeid=724" AndBlock:^{
            _downTableView.myManager = _downManager;
            [_downTableView.tableView reloadData];
        }];
    });
    [_topView timerStart];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 搭建主视图界面
    [self layoutSelfView];
    
    // 搭建顶部ScrollView
    [self layoutTopScrollView];
    
    // 搭建中间CollectionView
    [self layoutMidCollectionView];
    
    // 底部TableView
    [self layoutDownTableView];

}
- (void)layoutSelfView{
    
    
    
    /** 关闭scrollView偏移量 **/
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 取消navigation的自动留白
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"viewBackImage"]];
    self.navigationItem.title = @"首页";
    
    
    
   
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_topView timerEnd];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 顶部ScrollView方法
- (void)layoutTopScrollView{
    // 创建控件
    self.topManager = [[GetDataManager alloc] init];
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(5, 5+64, self.view.frame.size.width - 10, self.view.frame.size.height/4)];
    self.topView.delegate = self;
    [self.view addSubview:_topView];
    

}
- (void)touchImagePassTag:(NSInteger)tag{
    DetailModel *detail = _topManager.AllDataArr[tag];
    [self pushWebViewWithAid:detail.aid AndTitle:detail.shorttitle];
    
}
#pragma mark - 中间Collection
// 搭建中间CollectionView
- (void)layoutMidCollectionView{
    // 导图本地Plist
    [self midDataRead];

    self.midView = [[MidView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_topView.frame)+5, self.view.frame.size.width - 10, self.view.frame.size.height/4 + 20)];
    _midView.delegate = self;
    [_midView layoutButtonWithDataArr:[_midDataDic allKeys]];
    [self.view addSubview:_midView];
    
}
// 中部View读取数据
- (void)midDataRead{
    NSString *fileData = [[NSBundle mainBundle] pathForResource:@"ContentList" ofType:@"plist"];
    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:fileData];
    
    self.midDataDic = [NSMutableDictionary dictionary];
    
    for (NSString *key in dataDic) {
        NSArray *array = [dataDic valueForKey:key];
        [_midDataDic setValue:array forKey:key];
    }
    
}
// 中部点击时间回调方法
- (void)whenButtonClickPassKey:(NSString *)key{
    // 因为菜单界面必须在viewDidLoad时赋值,所以通过一个单利类赋值
    NSDictionary *dic = [_midDataDic valueForKey:key];
    [DemoHandle shardDemoHandl].dataDic = dic;
    [DemoHandle shardDemoHandl].navigationTitle = key;
    DemoViewController *demoVC = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:demoVC animated:YES];
}
#pragma mark - 底部TableView
// 搭建控件
- (void)layoutDownTableView{
    self.downTableView = [[DownView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_midView.frame)+5, self.view.frame.size.width - 10, self.view.frame.size.height - CGRectGetMaxY(_midView.frame)+5 - 15)];
    
    _downTableView.delegate = self;
    [self.view addSubview:_downTableView];
}
/** 根据页数刷新数据 */
- (void)refreshDataWithPage:(NSInteger)page{
//    NSString *downUrlStr = @"http://zhushouapi.gamedog.cn/index.php?a=lists&m=Article&page=1&pageSize=10&typeid=724";

    NSString *str = [NSString stringWithFormat:@"page=%ld&typeid=724",page];
    NSString *urlstr =@"http://zhushouapi.gamedog.cn/index.php?a=lists&flag=f%2Cp%2Cl&m=Article&";
    NSString *url = [urlstr stringByAppendingString:str];
    [_downManager getDataWithUrlString:url AndBlock:^{
        [_downTableView endedrefresh];
    }];
}
// 底部button回调方法
- (void)whenCellClickPassRow:(NSInteger)row{
    DetailModel *detail = _downManager.AllDataArr[row];
    [self pushWebViewWithAid:detail.aid AndTitle:detail.shorttitle];
}

- (void)pushWebViewWithAid:(NSString *)Aid AndTitle:(NSString *)title{
    WebViewController *wevVC = [[WebViewController alloc] init];
    wevVC.navigationTitle = title;
    wevVC.urlStr = [NSString stringWithFormat:@"http://zhushouapi.gamedog.cn/index.php?m=Article&a=show&pageSize=10&aid=%@",Aid];
    [self.navigationController pushViewController:wevVC animated:YES];
}
@end
