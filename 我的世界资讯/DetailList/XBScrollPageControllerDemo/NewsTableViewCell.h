//
//  NewsTableViewCell.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/6.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsDate;

@end
