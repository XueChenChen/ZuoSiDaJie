//
//  UIBarButtonItem+item.h
//  01BudeJie
//
//  Created by tarena on 16/9/1.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)
/**
 *  创建barButtonItem
 *
 *  @param normalImage      正常的图片
 *  @param highlightedImage 高亮的图片
 *  @param target           事件目标对象
 *  @param action           事件方法
 *
 *  @return     UIBarButtonItem*
 */
+ (UIBarButtonItem*)itemWithImage:(UIImage*)normalImage highlightedImage:(UIImage*)highlightedImage addTarget:(nullable id)target action:(SEL)action;
+ (UIBarButtonItem*)itemWithImage:(UIImage*)normalImage selectedImage:(UIImage*)selectedImage addTarget:(nullable id)target action:(SEL)action;
+ (UIBarButtonItem*)backItemWithImage:(UIImage*)normalImage highlightedImage:(UIImage*)highlightedImage addTarget:(nullable id)target action:(SEL)action;

@end
