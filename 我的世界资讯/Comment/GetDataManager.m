//
//  GetDataManager.m
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "GetDataManager.h"
#import "AFNetworking.h"


@interface GetDataManager ()
@property (nonatomic,assign) BOOL first;
@end
@implementation GetDataManager
- (void)getDataWithUrlString:(NSString *)urlString AndBlock:(myBlock)block{
    /** AFNetWorking GET请求JSON */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 懒加载数组
        // 请求成功把数据模型化
        NSDictionary *dic = responseObject;
        
        NSArray *dataArr = [dic valueForKey:@"data"];
        if (!_first) {
            for (NSDictionary *dic in dataArr) {
                DetailModel *detailModel = [[DetailModel alloc] init];
                [detailModel setValuesForKeysWithDictionary:dic];
                [self.AllDataArr addObject:detailModel];
            }
        }
        NSInteger next = [[dic valueForKey:@"next"] integerValue];
        // 也可以不转成nsnumber 用isequerToNumber 比较
        if (next != 1) {
            _first = YES;
        }
        block();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"error");
    }];
}
- (NSMutableArray *)AllDataArr{
    if (!_AllDataArr) {
        self.AllDataArr = [[NSMutableArray alloc] init];
    }
    return _AllDataArr;
}

@end
