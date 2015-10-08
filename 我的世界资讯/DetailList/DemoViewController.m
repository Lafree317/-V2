//
//  DemoViewController.m
//  MoerTableView
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "DemoViewController.h"
#import "XBTestTableViewController.h"
#import "DetailModel.h"
#import "DemoHandle.h"

@interface DemoViewController ()
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSMutableArray *classNames;
@property (nonatomic,strong) NSMutableArray *params;
@end

@implementation DemoViewController
- (instancetype)init{
    if (self = [super initWithTagViewHeight:49]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_titleArray) {
        self.titleArray = [NSMutableArray array];

    }
    if (!_classNames) {
        self.classNames = [NSMutableArray array];
    }
    if (!_params) {
        self.params = [NSMutableArray array];
    }
    
    [self readData];
    
    [self layoutView];
}

- (void)readData{
    
    
    self.dataDic = [DemoHandle shardDemoHandl].dataDic;
    
    for (NSString *key in _dataDic) {
        [self.titleArray addObject:key];
        [self.params addObject:[_dataDic valueForKey:key]];
        [self.classNames addObject:[XBTestTableViewController class]];
    }
    

}
- (void)layoutView{
    
    
    self.title = [DemoHandle shardDemoHandl].navigationTitle;
    
    
    //设置自定义属性
    self.tagItemSize = CGSizeMake(110, 49);
    
    
    [self reloadDataWith:_titleArray andSubViewdisplayClasses:_classNames withParams:_params];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
