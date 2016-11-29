//
//  UIView+Frame.h
//  01BudeJie
//
//  Created by tarena on 16/8/31.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)


@property CGFloat CXC_width;
@property CGFloat CXC_heigth;
@property CGFloat CXC_x;
@property CGFloat CXC_y;
@property CGFloat CXC_centerX;
@property CGFloat CXC_centerY;


+ (instancetype)CXC_getViewFromXib;
@end
