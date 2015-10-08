//
//  DemoHandle.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoHandle : NSObject
+ (DemoHandle *)shardDemoHandl;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSString *navigationTitle;
@end
