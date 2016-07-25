//
//  HomeCollectionViewCell.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"

@interface HomeCollectionViewCell ()
@property (nonatomic, strong)NewsTableViewController *newsVC;
@end

@implementation HomeCollectionViewCell
-(void)awakeFromNib{
//    self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
//    NSLog(@"%s",__func__);
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.newsVC = [Storyboard instantiateInitialViewController];
    self.newsVC.tableView.frame = self.contentView.bounds;
    self.newsVC.tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self addSubview:self.newsVC.tableView];
}
- (void)setUrlstr:(NSString *)urlstr{
    _urlstr = urlstr;
    self.newsVC.urlstr = urlstr;
}
@end
