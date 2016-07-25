//
//  ChannelModel.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel
+(instancetype)ChannelModelWithDict:(NSDictionary *)dict{
    ChannelModel *model = [[ChannelModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+ (NSArray *)channels{
    NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:NULL];
    NSArray *tlist = dict[@"tList"];
    
    NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:tlist.count];
    
    [tlist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChannelModel *model = [ChannelModel ChannelModelWithDict:obj];
        
        [tmpM addObject:model];
    }];
    
    [tmpM sortUsingComparator:^NSComparisonResult(ChannelModel *obj1, ChannelModel *obj2) {
        
        return [obj1.tid compare:obj2.tid];
        
    }];
    
    return tmpM.copy;
}
- (NSString *)description{
    
    return [NSString stringWithFormat:@"%@  %@",self.tid,self.tname];
    
}
@end
/*
 "tList": [
 {
 "template": "manual",
 "topicid": "00040BGE",
 "hasCover": false,
 "alias": "The Truth",
 "subnum": "6.8万",
 "tag": "hot",
 "recommendOrder": 0,
 "isNew": 0,
 "img": "http://img2.cache.netease.com/m/newsapp/banner/zhenhua.png",
 "isHot": 1,
 "hasIcon": true,
 "cid": "C1348654575297",
 "recommend": "0",
 "headLine": false,
 "tagDate": "2015-06-16 10:45:34.0",
 "color": "",
 "bannerOrder": 105,
 "tname": "原创",
 "ename": "zhenhua",
 "showType": "comment",
 "special": 0,
 "tid": "T1370583240249"
 },
 */