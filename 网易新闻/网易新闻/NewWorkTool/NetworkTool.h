//
//  NetworkTool.h
//  网易新闻
//
//  Created by 冯毅 on 16/7/20.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking.h>
@interface NetworkTool : AFHTTPSessionManager

+(instancetype)sharedNetworkTool;

@end
