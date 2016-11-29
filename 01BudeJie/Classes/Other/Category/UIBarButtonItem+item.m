//
//  UIBarButtonItem+item.m
//  01BudeJie
//
//  Created by tarena on 16/9/1.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+ (UIBarButtonItem*)itemWithImage:(UIImage*)normalImage highlightedImage:(UIImage*)highlightedImage addTarget:(nullable id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [UIColor redColor];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //问题：把uibutton包装成UIBarButtonItem,导致按钮区域扩大--》uibutton问题？--》UIbarButtonItem问题？--》用uiviewe包装成uibarButtonItem
    UIView *containtView = [[UIView alloc]initWithFrame:btn.bounds];
    [containtView addSubview:btn];
    return [[UIBarButtonItem alloc]initWithCustomView:containtView];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [UIColor redColor];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //问题：把uibutton包装成UIBarButtonItem,导致按钮区域扩大--》uibutton问题？--》UIbarButtonItem问题？--》用uiviewe包装成uibarButtonItem
    UIView *containtView = [[UIView alloc]initWithFrame:btn.bounds];
    [containtView addSubview:btn];
    return [[UIBarButtonItem alloc]initWithCustomView:containtView];
}

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)normalImage highlightedImage:(UIImage*)highlightedImage addTarget:(id)target action:(SEL)action{
    //设置自定义返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setImage:normalImage forState:UIControlStateNormal];
    [backButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    UIView *containtView = [[UIView alloc]initWithFrame:backButton.bounds];
    [containtView addSubview:backButton];
    return [[UIBarButtonItem alloc]initWithCustomView:containtView];
}
@end
