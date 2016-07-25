//
//  CycleModel.m
//  网易新闻
//
//  Created by 冯毅 on 16/7/21.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import "CycleModel.h"
#import "NetworkTool.h"
@implementation CycleModel

+ (instancetype)CycleModelWithDict:(NSDictionary *)dict{
    CycleModel *model = [[CycleModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+ (void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlock:(void(^)(NSError *error))failBlock{
    [[NetworkTool sharedNetworkTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //取出key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //数组
        NSArray *arr = [responseObject objectForKey:key];
        //可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        //遍历arr
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //模型
            CycleModel *model = [CycleModel CycleModelWithDict:obj];
            
            [arrM addObject:model];
            
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
    
    
}


@end
