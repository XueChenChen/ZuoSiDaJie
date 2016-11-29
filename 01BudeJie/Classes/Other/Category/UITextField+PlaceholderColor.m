//
//  UITextField+PlaceholderColor.m
//  01BudeJie
//
//  Created by tarena on 16/9/24.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"
#import <objc/message.h>

@implementation UITextField (PlaceholderColor)

@dynamic placeholderColor;

+ (void)load{
    
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
     Method setCXC_PlaceholderMethod = class_getInstanceMethod(self, @selector(setCXC_Placeholder:));
    method_exchangeImplementations(setPlaceholderMethod, setCXC_PlaceholderMethod);
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    //给成员属性赋值，runtime给系统的类添加成员属性
    //添加成员变量
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //此方法有bug
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor{
//    return nil;
    return objc_getAssociatedObject(self, @"placeholderLabel");
}

- (void)setCXC_Placeholder:(NSString *)placeholder{
    
//    self.placeholder = placeholder;
    //runtime交换方法后 方法变了用下边这个
    [self setCXC_Placeholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
    
}


@end
