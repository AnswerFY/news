//
//  CycleCollectionViewCell.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/21.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface CycleCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc;
@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation CycleCollectionViewCell
- (void)setModel:(CycleModel *)model{
    _model = model;
    
    [self.imgsrc sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    
    self.title.text = model.title;
    
}

@end
