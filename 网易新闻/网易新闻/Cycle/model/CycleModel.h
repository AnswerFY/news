//
//  CycleModel.h
//  网易新闻
//
//  Created by 冯毅 on 16/7/21.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CycleModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *imgsrc;

+ (void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlock:(void(^)(NSError *error))failBlock;
@end
