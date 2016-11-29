//
//  NetManager.h
//  TRProject
//
//  Created by tarena on 16/7/14.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "BaseNetworking.h"
#import "TRHotModel.h"
#import "TRGeDanModel.h"
#import "TRHotListModel.h"
#import "TRSingerModel.h"
#import "TRDianTaiModel.h"
#import "TRTuiJianModel.h"
#import "TRFenLeiModel.h"
#import "TRKAidModel.h"
#import "TRKTVModel.h"
#import "LJSSongIDModel.h"
@interface NetManager : BaseNetworking
+ (id)getHotWithHandler:(void(^)(TRHotModel *model, NSError *error))handler;
//歌单 Page_no -> PageNo   Handler -> handler
+ (id)getGeDanListWithPage_no:(NSInteger)page_no Handler:(void(^)(TRGeDanModel *model, NSError *error))handler;

+(id)getHotListWithType:(NSInteger)type hotList:(void(^)(TRHotListModel *hotListModel, NSError *error))hotList;
+(id)getSingerWithHandler:(void(^)(TRSingerModel *model,NSError *error))handler;

+ (id)getDianTaiWithHandler:(void(^)(TRDianTaiModel *model,NSError *error))handler;

+ (id)getTuiJianHandler:(void(^)(TRTuiJianModel *model,NSError *error))handler;

+ (id)getFenLeiWithType:(NSString *)type handler:(void(^)(TRFenLeiModel *model,NSError *error))handler;
+ (id)getKTVAidCompletionHandler:(void(^)(TRKAidModel *model, NSError *error))completionHandler;

+ (id)getKTVDataCompletionHandler:(void(^)(TRKTVModel *model, NSError *error))completionHandler;

+ (id)getSongID:(NSString *) songID Handler:(void(^)(LJSSongIDModel *model, NSError *error))handler;
@end
