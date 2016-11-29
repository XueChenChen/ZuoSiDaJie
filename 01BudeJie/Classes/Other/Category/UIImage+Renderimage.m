//
//  UIImage+Renderimage.m
//  01BudeJie
//
//  Created by tarena on 16/8/29.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "UIImage+Renderimage.h"

@implementation UIImage (Renderimage)

+ (instancetype)imageOriginImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (instancetype)cxc_circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);//第三参数 ：比例因素：当前点与像素比例（非retain1:1 retain高清屏1:2 plus设备1：3） 0自适应
    //2.2 描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //2.3 设置裁剪区域
    [path addClip];
    //2.4 画图片
    [self drawAtPoint:CGPointZero];
    //2.5 取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //2.6 关闭上下文
    UIGraphicsEndImageContext();
    return  image;
}

@end
