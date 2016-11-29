//
//  CXCLiveCell.m
//  QuanMinTV
//
//  Created by tarena on 16/10/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CXCLiveCell.h"

@interface CXCLiveCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImagView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomview;

@end

@implementation CXCLiveCell

- (void)awakeFromNib{

    [super awakeFromNib];
//    self.nameImageView.layer.cornerRadius = self.nameImageView.CXC_width * 0.5;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameImageView.layer.cornerRadius = self.nameImageView.CXC_width * 0.5;
}


- (void)setModel:(CXCLiveDatades *)model{
    _model = model;
    
    [self.iconImagView setImageWithURL:model.thumb.cxc_URL placeholder:[UIImage imageNamed:@"disconnect_internet"]];
    [self.nameImageView setImageWithURL:model.avatar.cxc_URL placeholder:[UIImage imageNamed:@"disconnect_internet"]];
    self.titleLabel.text = model.nick;
    self.desLabel.text = model.title;
    NSInteger count = model.view.integerValue;
    if (count > 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%0.2f万", count / 10000.0];
    }else if (count > 0){
        self.playCountLabel.text = model.view;
    }else{
        self.bottomview.hidden = YES;
    }
    
}

@end
