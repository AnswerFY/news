//
//  NewsTableViewController.h
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController
//接收从HomeCollectionViewCell传来的数据
@property (nonatomic, copy)NSString *urlstr;
@end
