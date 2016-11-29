//
//  XMGCommentHeaderView.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/17.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "XMGCommentHeaderView.h"

@interface XMGCommentHeaderView()
/** 内部的label */
@property (nonatomic, weak) UILabel *label;
@end

@implementation XMGCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = XMGCommonBgColor;
        
        // label
        UILabel *label = [[UILabel alloc] init];
        label.x = XMGCommonSmallMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textColor = XMGGrayColor(120);
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    self.label.text = text;
}
@end
