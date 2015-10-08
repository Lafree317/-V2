//
//  DetailModel.m
//  我的世界资讯Demo
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.detail = value;
    }
}
@end
