//
//  XBTableViewCell.h
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/5.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
