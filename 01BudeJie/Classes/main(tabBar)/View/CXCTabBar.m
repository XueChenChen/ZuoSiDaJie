//
//  CXCTabBar.m
//  01BudeJie
//
//  Created by tarena on 16/8/30.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCTabBar.h"

@interface CXCTabBar  ()

/** 中间红色加号button */
@property (nonatomic, weak) UIButton *plusButton;

/** 上一个tabBarButton */
@property (nonatomic, weak) UIControl *preClickedTabBarButton;

@end

@implementation CXCTabBar
- (UIButton *)plusButton{
    if (!_plusButton) {
        UIButton *plusButton = [UIButton new];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [plusButton sizeToFit];
        _plusButton = plusButton;
        [self addSubview:_plusButton];
        
    }
    return _plusButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    NSLog(@"%@",self.subviews);
    //NSClassFromString(@"UITabBarButton") 反编译 UITabBarButton是苹果私有类
    CGFloat button_width = (self.CXC_width / (self.items.count+1));
    CGFloat button_heigth = self.CXC_heigth;
    NSInteger i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {

            if (i == 2) i++;
            
            tabBarButton.frame = CGRectMake(i*button_width, 0, button_width, button_heigth);
            i++;
            
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0 && self.preClickedTabBarButton == nil)   self.preClickedTabBarButton = tabBarButton;
            
        }

    }
        self.plusButton.center = CGPointMake(self.CXC_width*0.5, self.CXC_heigth*0.5);
}

#pragma mark - 点击事件
- (void)tabBarButtonClicked:(UIControl *)sender{
    if (self.preClickedTabBarButton == sender) {
        //如果重复点击tabBarButton，刷新--（通知刷新）
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CXCtabBarButtonClickedNotification object:self];

    }
    self.preClickedTabBarButton = sender;
   
}

@end
