//
//  CXCNavigationController.m
//  01BudeJie
//
//  Created by tarena on 16/9/1.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCNavigationController.h"

@interface CXCNavigationController ()<UIGestureRecognizerDelegate>

@end



@implementation CXCNavigationController

+(void)load{
    
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    //设置标题
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [nav setTitleTextAttributes:dic];

    [nav setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//    [nav setTintColor:[UIColor blackColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*<UIScreenEdgePanGestureRecognizer: 0x7fab3143a6c0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fab31438b10>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fab3143a3e0>)>>*/
    //设为nil会造成跟控制器滑动进入假死状态
//    self.interactivePopGestureRecognizer.delegate = nil;
//        self.interactivePopGestureRecognizer.delegate = self;
    
    //为什么导航控制器的手势不是全屏滑动
 
//    UIScreenEdgePanGestureRecognizer *edgepan = self.interactivePopGestureRecognizer;
//    edgepan.edges = UIRectEdgeAll;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    //非根控制器才能触发手势
    pan.delegate = self;
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

#pragma mark - 手势代理
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
    //自定义手势失效--》（1.可能手势被清空了 2.可能代理手势做了一些事，导致手势失效）
     viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highlightedImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(backClicked)];
    viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backClicked{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
