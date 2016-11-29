//
//  CXCSubTagCell.m
//  01BudeJie
//
//  Created by tarena on 16/9/22.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCSubTagCell.h"
#import "CXCSubTagItemModel.h"
@interface CXCSubTagCell  ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;


@end

@implementation CXCSubTagCell

//- (void)setFrame:(CGRect)frame{
//    
//    frame.size.height -= 10;
//    
//    [super setFrame:frame];
//}

/**
 *  头像变圆角 1 头像变圆角 2.裁剪图片(生成新的图片--> 图形上下文能够生成新的图片(锯齿                          ))
 *  处理数字
 */

- (void)setItemModel:(CXCSubTagItemModel*)model{
   
    
//    [_userImageView setImageWithURL:model.image_list.cxc_url placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [_userImageView setImageWithURL:model.image_list.cxc_url placeholder:[UIImage imageNamed:@"defaultUserIcon"] options:0 completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (!image) return;
        _userImageView.image = [image cxc_circleImage];
    }];
    
    
    _titleLabel.text = model.theme_name;
    
    NSInteger num = [model.sub_number integerValue];
    if (num > 10000) {
         _desLabel.text = [NSString stringWithFormat:@"%0.1f万人订阅",num / 1000.0];
    }else _desLabel.text = [NSString stringWithFormat:@"%@人订阅",model.sub_number];
    
   
}



//xib加载调用一次
- (void)awakeFromNib{
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    //方法一 头像圆角 。ios9苹果修复 圆角杀手
//    _userImageView.layer.cornerRadius = 30;
//    _userImageView.layer.masksToBounds = YES;
    //方法二 xib--第三个检查器-->user Defined Runtime... 加键值
}

@end
