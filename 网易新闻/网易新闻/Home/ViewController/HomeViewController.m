//
//  HomeViewController.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"
#import "ChannelLabel.h"
#import "HomeCollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSArray *channelArr;
@end

@implementation HomeViewController
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSArray *)channelArr{
    if (_channelArr == nil) {
        _channelArr = [ChannelModel channels];
    }
    return _channelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",[ChannelModel channels]);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createChannellab];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.FlowLayout.itemSize = self.newsCollectionView.bounds.size;
}
- (void)createChannellab{

    //获取频道标签模型数组:拿到模型数组,遍历模型数组,遍历中创建频道标签
    self.channelArr = [ChannelModel channels];
    //标签的宽和高
    CGFloat labW = 80;
    CGFloat labH = self.channelScrollView.bounds.size.height;
    //遍历频道标签模型数组,遍历中创建频道标签控件
    for (int i = 0; i < self.channelArr.count; i++) {
        ChannelLabel *label = [[ChannelLabel alloc]init];

        //布局frame
        CGFloat labX = labW * i;
        //布局frame
        label.frame = CGRectMake(labX, 0, labW, labH);
        //设置频道滚动视图的滚动范围
        self.channelScrollView.contentSize = CGSizeMake(labW * self.channelArr.count, 0);
        //获取频道标签模型,给标签赋值x
        ChannelModel *model = self.channelArr[i];
        label.tag = i;
        
//        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = model.tname;
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
        
        label.userInteractionEnabled = YES;
        
        //添加到父视图
        [self.channelScrollView addSubview:label];
        
        //把Label添加到频道数组里面
        [self.dataArr addObject:label];
    }
    
    
}

//点击频道的方法
- (void)tapClick:(UIGestureRecognizer *)tap{
    //获取选中的Label
    ChannelLabel *lab = (ChannelLabel *)tap.view;
    
    //计算选中的Label居中时,要滚动的偏移量
    CGFloat labOffsetX = lab.center.x - self.view.bounds.size.width / 2;
    
    CGFloat minOffsetX = 0;
    
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    
    if (labOffsetX < minOffsetX) {
        labOffsetX = 0;
    }else if (labOffsetX > maxOffsetX){
        labOffsetX = maxOffsetX;
    }
    
    //设置频道滚动视图的滚动
    [self.channelScrollView setContentOffset:CGPointMake(labOffsetX, 0) animated:YES];
    
    //点击频道标签居中时,collectionView也跟着联动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lab.tag inSection:0];
    [self.newsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
    //点击Label时选中的缩放比例最大,其余的保持
    //获取选中的Label的tag
    NSInteger index = lab.tag;
    for (int i = 0; i < self.dataArr.count; i++) {
        ChannelLabel *label = self.dataArr[i];
        
        if (index == i) {
            lab.scale = 1.0;
        } else {
            lab.scale = 0;
        }
    }
}

//监听底部conllectionView的滚动:实时滚动的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat W = self.view.bounds.size.width;
    CGFloat indexF = offsetX / W;
    NSInteger index = offsetX / W;
    
    CGFloat percent = indexF - index;
    
    NSInteger left = index;
    NSInteger right = left + 1;
    CGFloat rightScale = percent;
    CGFloat leftScale = 1 - rightScale;
    
    ChannelLabel *leftLab = self.dataArr[left];
    
    leftLab.scale = leftScale;
    
    if (right < self.dataArr.count) {
        ChannelLabel *rightLab = self.dataArr[right];
        rightLab.scale = rightScale;
    }
}
//监听底部conllectionView的滚动:滚动结束的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //计算滚动到第几个索引
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //根据标签去找lab
    ChannelLabel *lab = self.dataArr[index];
    CGFloat labOffsetX = lab.center.x - self.view.bounds.size.width / 2;
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    if (labOffsetX < minOffsetX) {
        labOffsetX = 0;
    }else if (labOffsetX > maxOffsetX){
        labOffsetX = maxOffsetX;
    }
    
    [self.channelScrollView setContentOffset:CGPointMake(labOffsetX, 0) animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
    ChannelModel *model = self.channelArr[indexPath.item];
    //取出模型里面的tid,拼接处新闻数据的URL
    NSString *urlStr = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    
//    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    cell.urlstr = urlStr;
    return cell;
    
}

@end
