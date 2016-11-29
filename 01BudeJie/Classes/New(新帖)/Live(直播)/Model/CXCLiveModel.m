//
//  CXCLiveModel.m
//  QuanMinTV
//
//  Created by tarena on 16/10/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CXCLiveModel.h"

@implementation CXCLiveModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : @"CXCLiveDatades"};
}

@end
@implementation CXCLiveRecommend

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : @"CXCLiveData"};
}

@end


@implementation CXCLiveData

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID" : @"id"};
}

@end


@implementation CXCLiveDatades

@end


