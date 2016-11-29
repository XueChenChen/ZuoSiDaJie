//
//  CXCMeAppListModel.m
//  01BudeJie
//
//  Created by tarena on 16/9/26.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCMeAppListModel.h"

@implementation CXCMeAppListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"tag_list":@"Tag_List",
             @"square_list":@"Square_List"};
}



@end
@implementation Tag_List

@end


@implementation Square_List

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


