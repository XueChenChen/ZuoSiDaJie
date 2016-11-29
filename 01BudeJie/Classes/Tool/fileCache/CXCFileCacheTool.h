//
//  CXCFileCacheTool.h
//  01BudeJie
//
//  Created by tarena on 16/9/30.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCFileCacheTool : NSObject
/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹路径
 *
 *  @return 返回文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;


/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
