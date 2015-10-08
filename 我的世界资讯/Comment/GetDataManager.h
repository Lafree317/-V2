//
//  GetDataManager.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
typedef void(^myBlock)();
@interface GetDataManager : NSObject

@property (nonatomic,strong) NSMutableArray *AllDataArr;

- (void)getDataWithUrlString:(NSString *)urlString AndBlock:(myBlock)block;
@end
