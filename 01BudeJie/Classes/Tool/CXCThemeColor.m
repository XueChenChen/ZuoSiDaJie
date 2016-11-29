//
//  NSObject+CXCThemeColor.m
//  01BudeJie
//
//  Created by tarena on 2016/10/31.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "NSObject+CXCThemeColor.h"

@implementation NSObject (CXCThemeColor)
static NSString *_skinColor;

+ (void)initialize{
    _skinColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeColor"];
    if (_skinColor == nil) {
        _skinColor = @"white";
    }
}

+ (void)setNavBarBackImageWithThemeName:(NSString *)themeName{
    _skinColor = themeName;
    
    [[NSUserDefaults standardUserDefaults] setObject:_skinColor forKey:@"themeColor"];
    
}
@end
