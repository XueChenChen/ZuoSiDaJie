//
//  CXCNewViewController.m
//  01BudeJie
//
//  Created by tarena on 16/8/27.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCNewViewController.h"
#import "CXCSubTagViewController.h"
@interface CXCNewViewController ()

@end

@implementation CXCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
}

/**
 *  设置导航栏.barItem
 */
- (void)setNavigationBar{
    //left
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(tagItemClick:)];
    //title
    self.navigationItem.titleView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}



- (void)tagItemClick:(id)sender{
    //进入推荐标签界面
    CXCSubTagViewController *subTagVC = [[CXCSubTagViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:subTagVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
