//
//  NetManager.m
//  TRProject
//
//  Created by tarena on 16/7/14.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "NetManager.h"

#define kHotPath @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billCategory&format=json&from=ios&kflag=2&from=ios&version=5.8.3&cuid=511e7b5ebe3cb83b66008608b586c12220e6b5aa&channel=appstore&operator=0"
#define kGedanListPaht @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=%ld&format=json&offset=0&size=100&from=ios&fields=title,song_id,author,resource_type,havehigh,is_new,has_mv_mobile,album_title,ting_uid,album_id,charge,all_rate,mv_provider&from=ios&version=5.8.3&cuid=24fc6b080e10ed8522fbb16da65619eafdf1db28&channel=appstore&operator=0"
#define kSingerPath @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=24&offset=0&area=0&sex=0&abc=&from=ios&from=ios&version=5.8.3&cuid=511e7b5ebe3cb83b66008608b586c12220e6b5aa&channel=appstore&operator=0"

#define kDianTaiPath @"http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryList&from=ios&version=5.8.3&cuid=511e7b5ebe3cb83b66008608b586c12220e6b5aa&channel=appstore&operator=0"

#define kTuiJianPath @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.scene.getSugScene&from=ios&version=5.8.3&cuid=511e7b5ebe3cb83b66008608b586c12220e6b5aa&channel=appstore&operator=0"

#define kFenLeiPath @"http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=%@&from=ios&version=5.8.3&cuid=511e7b5ebe3cb83b66008608b586c12220e6b5aa&channel=appstore&operator=0"
#define kAidPath @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.active.showList&from=ios&version=5.8.3&cuid=511e7b5ebe3cb83b66008608b586c12220e6b5aa&channel=appstore&operator=0"

#define kKTVPath @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.learn.now&from=ios&from=ios&version=5.8.3&cuid=511e7b5ebe3cb83b66008608b586c12220e6b5aa&channel=appstore&operator=0"

#define KSongIdPath @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1475164135&songid=%@&nw=2&l2p=395.1&lpb=320000&ext=MP3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=FuQ105WnGRfnAYDe2H%@FYvCkKi8tA3QhyC6fmlIiYJHY%@D&channel=24fc6b080e10ed8522fbb16da65619eafdf1db28&cuid=appstore&from=ios&version=5.9.0"

@implementation NetManager
+ (id)getHotWithHandler:(void (^)(TRHotModel *, NSError *))handler{
    return [self GET:kHotPath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !handler ?: handler([TRHotModel parse:repsonseObj], error);
    }];
}
+(id)getGeDanListWithPage_no:(NSInteger)page_no Handler:(void (^)(TRGeDanModel *, NSError *))handler{
    NSString *GeDanpath = [NSString stringWithFormat:kGeDanPath, page_no];
    return [self GET:GeDanpath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !handler ?: handler([TRGeDanModel parse:repsonseObj], error);
    }];
}

+(id)getHotListWithType:(NSInteger)type hotList:(void (^)(TRHotListModel *, NSError *))hotList{
    NSString *path = [NSString stringWithFormat:kGedanListPaht, type];
    return [self GET:path parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !hotList?:hotList([TRHotListModel parse:repsonseObj], error);
    }];
}
+(id)getSingerWithHandler:(void (^)(TRSingerModel *, NSError *))handler{
    return [self GET:kSingerPath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !handler ?: handler([TRSingerModel parse:repsonseObj],error);
    }];
}

+ (id)getDianTaiWithHandler:(void (^)(TRDianTaiModel *, NSError *))handler{
    return [self GET:kDianTaiPath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !handler ?: handler([TRDianTaiModel parse:repsonseObj],error);

    }];
}

+ (id)getTuiJianHandler:(void (^)(TRTuiJianModel *, NSError *))handler{
    return [self GET:kTuiJianPath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !handler ?: handler([TRTuiJianModel parse:repsonseObj],error);

    }];
    
}

+ (id)getFenLeiWithType:(NSString *)type handler:(void (^)(TRFenLeiModel *, NSError *))handler{
    NSString *path = [NSString stringWithFormat:kFenLeiPath, type];
    return [self GET:path parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !handler ?: handler([TRFenLeiModel parse:repsonseObj],error);

    }];
}
+ (id)getKTVAidCompletionHandler:(void (^)(TRKAidModel *, NSError *))completionHandler{
    return [self GET:kAidPath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !completionHandler ?: completionHandler([TRKAidModel parse:repsonseObj], error);
    }];
}

+ (id)getKTVDataCompletionHandler:(void (^)(TRKTVModel *, NSError *))completionHandler{
    return [self GET:kKTVPath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !completionHandler ?: completionHandler([TRKTVModel parse:repsonseObj], error);
    }];
}


+(id)getSongID:(NSString *)songID Handler:(void (^)(LJSSongIDModel *, NSError *))handler{
    NSString *path = [NSString stringWithFormat:KSongIdPath,songID,@"%2",@"%3"];
    return [self GET:path parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !handler ?: handler([LJSSongIDModel parse:repsonseObj], error);
    }];
}


@end
