//
//  DetailModel.h
//  我的世界资讯Demo
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
/** 编码 */
@property (nonatomic,strong) NSString *aid;
/** 标题 */
@property (nonatomic,strong) NSString *title;
/** 短标题 */
@property (nonatomic,strong) NSString *shorttitle;
/** 详情 */
@property (nonatomic,strong) NSString *detail;
/** 链接 */
@property (nonatomic,strong) NSString *arcurl;
/** 图片 */
@property (nonatomic,strong) NSString *litpic;
/** 日期 */
@property (nonatomic,strong) NSString *pubdate;

@end
