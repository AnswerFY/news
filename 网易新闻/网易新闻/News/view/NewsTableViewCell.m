//
//  NewsTableViewCell.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface NewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsrcImageViews;

@end
 
@implementation NewsTableViewCell

- (void)setModel:(NewsModel *)model{
    _model = model;
    [self.imgsrcImage sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.titleLabel.text = model.title;
    self.sourceLabel.text = model.source;
    self.replyLabel.text = [NSString stringWithFormat:@"%@",model.replyCount];
    
    for (int i = 0; i < model.imgextra.count; i ++) {
    
        UIImageView *img = self.imgsrcImageViews[i];
        
        NSDictionary *dict = model.imgextra[i];
        
        NSString *imgsrc = [dict objectForKey:@"imgsrc"];
        
        [img sd_setImageWithURL:[NSURL URLWithString:imgsrc]];
    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
