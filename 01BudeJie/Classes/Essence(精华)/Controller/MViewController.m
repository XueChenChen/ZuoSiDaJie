//
//  MPViewController.m
//  MovieDemo
//
//  Created by zhao on 16/3/25.
//  Copyright © 2016年 Mega. All rights reserved.
//

#import "MViewController.h"
#import "XSMediaPlayer.h"
@interface MViewController ()

@property(nonatomic,retain)XSMediaPlayer *player;
@end

@implementation MViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"mp4"];
    
    _player = [[XSMediaPlayer alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
//    _player.videoURL = [NSURL fileURLWithPath:path];
    _player.videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1455782903700jy.mp4"];
    [self.view addSubview:_player];
    
    
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view.backgroundColor = [UIColor blackColor];
    }
}
// 哪些页面支持自动转屏
- (BOOL)shouldAutorotate{
    
    return YES;
}

// viewcontroller支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
// MoviePlayerViewController这个页面支持转屏方向
        return UIInterfaceOrientationMaskAllButUpsideDown;
  
}


-(void)dealloc
{
    NSLog(@"%s",__func__);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
