//
//  XBPageCell.m
//  XBScrollPageController
//
//  Created by Scarecrow on 15/9/6.
//  Copyright (c) 2015年 xiu8. All rights reserved.
//

#import "XBPageCell.h"

@implementation XBPageCell
- (void)configCellWithController:(UIViewController *)controller
{
    controller.view.frame = self.bounds;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"demoBackImage"]];
    controller.view.backgroundColor = [UIColor clearColor];

    
    [self.contentView addSubview:controller.view];
    
}
@end
