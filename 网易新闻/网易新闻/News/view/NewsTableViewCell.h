//
//  NewsTableViewCell.h
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
@property (nonatomic, strong)NewsModel *model;
@end
