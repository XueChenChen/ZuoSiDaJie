//
//  NSString+CXCURL.m
//  01BudeJie
//
//  Created by tarena on 16/9/21.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "NSString+CXCURL.h"

@implementation NSString (CXCURL)

- (NSURL *)cxc_url{
    return [NSURL URLWithString:self];
}

@end
