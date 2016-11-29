//
//  CXCADItemModel.h
//  01BudeJie
//
//  Created by tarena on 16/9/21.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import <Foundation/Foundation.h>
//（w_picurl，ori_curl：跳转到广告界面 ，w,h）
@interface CXCADItemModel : NSObject

/**广告地址*/
@property (nonatomic) NSString *w_picurl;
/**点击广告跳转的地址*/
@property (nonatomic) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@end
