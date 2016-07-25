//
//  NewsTableViewController.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NewsTableViewController ()
@property (nonatomic, strong)NSArray *dataArr;
@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)setUrlstr:(NSString *)urlstr{
    NSLog(@"%@",urlstr);
    
    [NewsModel downloadWithUrlstr:urlstr successBlock:^(NSArray *arr) {
        self.dataArr = arr;
        [self.tableView reloadData];
        
    } failBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = self.dataArr[indexPath.row];
    
    NSString *Identifier;
    if (model.imgType) {
        Identifier = @"bigcell";
    }else if(model.imgextra.count == 2){
        Identifier = @"imagescell";
    }else{
        Identifier = @"basecell";
    }
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = self.dataArr[indexPath.row];

    if (model.imgType) {
        return 180;
    }else if (model.imgextra.count == 2){
        return 150;
    }else{
        return 80;
    }
}
@end
