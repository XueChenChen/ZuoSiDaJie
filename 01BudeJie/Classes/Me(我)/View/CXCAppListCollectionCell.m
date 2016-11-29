//
//  CXCAppListCollectionCell.m
//  01BudeJie
//
//  Created by tarena on 16/9/24.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCAppListCollectionCell.h"
#import "CXCMeAppListModel.h"

@interface CXCAppListCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CXCAppListCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(Square_List *)item{
    _item = item;
    
    [_iconImageView setImageWithURL:item.icon.cxc_url];
    _nameLabel.text = item.name;
    
}

@end
