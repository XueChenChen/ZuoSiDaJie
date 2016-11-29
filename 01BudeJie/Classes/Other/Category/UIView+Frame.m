//
//  UIView+Frame.m
//  01BudeJie
//
//  Created by tarena on 16/8/31.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+ (instancetype)CXC_getViewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

#pragma mark --setter方法
/**
 *  setter方法
 *
 *  @param CXC_width self.frame高度
 */
- (void)setCXC_width:(CGFloat)CXC_width{
    CGRect frame = self.frame;
    frame.size.width = CXC_width;
    self.frame = frame;
}

- (void)setCXC_heigth:(CGFloat)CXC_heigth{
    CGRect frame = self.frame;
    frame.size.height = CXC_heigth;
    self.frame = frame;
}

- (void)setCXC_x:(CGFloat)CXC_x{
    CGRect frame = self.frame;
    frame.origin.x = CXC_x;
    self.frame = frame;
}

- (void)setCXC_y:(CGFloat)CXC_y{
    CGRect frame = self.frame;
    frame.origin.y = CXC_y;
    self.frame = frame;
}

- (void)setCXC_centerX:(CGFloat)CXC_centerX{
    CGPoint center = self.center;
    center.x = CXC_centerX;
    self.center = center;
}

- (void)setCXC_centerY:(CGFloat)CXC_centerY{
    CGPoint center = self.center;
    center.x = CXC_centerY;
    self.center = center;
}
#pragma mark --getter方法
/**
 *  getter 方法
 *
 *  @return self.frame的宽度
 */
- (CGFloat)CXC_width{
    return self.frame.size.width;
}

- (CGFloat)CXC_heigth{
    return  self.frame.size.height;
}

- (CGFloat)CXC_x{
    return self.frame.origin.x;
}

- (CGFloat)CXC_y{
    return self.frame.origin.y;
}

- (CGFloat)CXC_centerX{
    return self.center.x;
}

- (CGFloat)CXC_centerY{
    return self.center.y;
}

@end
