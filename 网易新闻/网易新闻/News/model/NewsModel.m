//
//  NewsModel.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "NewsModel.h"
#import "NetworkTool.h"
@implementation NewsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+ (instancetype)NewsModelWithDict:(NSDictionary *)dict{
    NewsModel *model = [[NewsModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

+ (void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failBlock:(void(^)(NSError *error))failBlock{

    [[NetworkTool sharedNetworkTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *dict = responseObject;
        
        NSString *key = dict.keyEnumerator.nextObject;
        
        NSArray *arr = [dict objectForKey:key];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModel *model = [self NewsModelWithDict:dict];
            
            [arrM addObject:model];
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error  %@",error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}
@end
