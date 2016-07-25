//
//  NewsModel.h
//  网易新闻
//
//  Created by 冯毅 on 16/7/19.
//  Copyright © 2016年 冯毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic ,copy)NSString *title;

@property (nonatomic, copy)NSString *imgsrc;

@property (nonatomic, copy)NSString *source;

@property (nonatomic, strong)NSNumber *replyCount;

@property (nonatomic, strong)NSArray *imgextra;

@property (nonatomic, assign)BOOL imgType;


+ (void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failBlock:(void(^)(NSError *error))failBlock;
@end
/*
 "T1351233117091": [
 {
 "postid": "BSG6D0AD001168BQ",
 "hasCover": false,
 "hasHead": 0,
 "replyCount": 46,
 "ltitle": "佟掌柜的新发现：小而好玩的独立游戏",
 "hasImg": 1,
 "digest": "所谓“独立游戏”，就是指在没有商业资金的影响或者不以商业发行为目的，独立完成制作的游戏。",
 "hasIcon": true,
 "docid": "BSG6D0AD001168BQ",
 "title": "佟掌柜的新发现：小而好玩的独立游戏",
 "order": 2,
 "priority": 79,
 "lmodify": "2016-07-21 10:06:00",
 "boardid": "mobile_bbs",
 "url_3w": "http://mobile.163.com/16/0721/09/BSG6D0AD001168BQ.html",
 "template": "normal1",
 "votecount": 26,
 "alias": "Mobile Web",
 "cid": "C1348649554552",
 "url": "http://3g.163.com/mobile/16/0721/09/BSG6D0AD001168BQ.html",
 "hasAD": 1,
 "source": "网易手机",
 "subtitle": "",
 "ename": "yidonghulianwang",
 "tname": "移动互联",
 "imgsrc": "http://cms-bucket.nosdn.127.net/bf4d0edbf4d745db996baf1f57e0c95420160721095147.jpeg",
 "ptime": "2016-07-21 09:44:41"
 },
 */