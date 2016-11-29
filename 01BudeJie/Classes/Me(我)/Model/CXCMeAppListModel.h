//
//  CXCMeAppListModel.h
//  01BudeJie
//
//  Created by tarena on 16/9/26.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Tag_List,Square_List;
@interface CXCMeAppListModel : NSObject


@property (nonatomic, strong) NSArray<Tag_List *> *tag_list;

@property (nonatomic, strong) NSArray<Square_List *> *square_list;


@end

@interface Tag_List : NSObject

@property (nonatomic, copy) NSString *theme_id;

@property (nonatomic, copy) NSString *theme_name;

@end

@interface Square_List : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *android;

@property (nonatomic, copy) NSString *iphone;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *ipad;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@end

