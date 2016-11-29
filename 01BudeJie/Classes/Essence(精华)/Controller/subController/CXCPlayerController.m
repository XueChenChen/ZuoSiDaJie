//
//  CXCPlayerController.m
//  QuanMinTV
//
//  Created by tarena on 16/10/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CXCPlayerController.h"
@import AVFoundation;

@interface CXCPlayerController ()

@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerLayer *playerLayer;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *fullButton;

@end

@implementation CXCPlayerController

#pragma mark - SEL
- (IBAction)gestureViewClicked:(id)sender{
    self.fullButton.selected ?: [self backButtonClicked:nil];
}

- (IBAction)backButtonClicked:(id)sender {
    self.fullButton.selected ? [self fullButtonClicked:self.fullButton] : [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)fullButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self setInterfaceOrientation:(sender.selected == YES) ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait ];
}

/**
 *  横屏和竖屏选择
 */

- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - 生命
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureViewClicked:)]];

    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.imageView.layer addSublayer:_playerLayer];

    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   
    _playerLayer.frame = CGRectMake(0, 0, self.view.width, self.view.width * 9 / 16.0);
}


- (void)setPlayerUrl:(NSURL *)playerUrl{
    _playerUrl = playerUrl;
    if (_player == nil) {
        _player = [AVPlayer playerWithURL:playerUrl];
        [_player play];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player pause];
    _player = nil;
}


@end
