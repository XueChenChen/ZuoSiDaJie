//
//  CXCCommentCell.h
//  01BudeJie
//
//  Created by tarena on 16/10/25.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXCData;

@interface CXCCommentCell : UITableViewCell
/** 评论模型数据 */
@property (nonatomic, strong) CXCData *comment;
@end
