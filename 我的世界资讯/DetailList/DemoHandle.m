//
//  DemoHandle.m
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "DemoHandle.h"

@implementation DemoHandle
+ (DemoHandle *)shardDemoHandl{
    static DemoHandle *audioManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioManager = [[DemoHandle alloc] init];
    });
    return audioManager;
}

@end
