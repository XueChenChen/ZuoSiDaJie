//
//  CXCTabBarController.m
//  01BudeJie
//
//  Created by tarena on 16/8/27.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCTabBarController.h"
#import "CXCEssenceViewController.h"
#import "CXCFriendTrendViewController.h"
#import "CXCMeViewController.h"
#import "CXCNewViewController.h"
#import "CXCPublishViewController.h"
#import "UIImage+Renderimage.h"
#import "CXCTabBar.h"
#import "CXCNavigationController.h"

@interface CXCTabBarController ()

@property(nonatomic,strong)CXCNavigationController *nav1;
@property(nonatomic,strong)CXCNavigationController *nav2;
//@property(nonatomic,strong)CXCPublishViewController *publishVC;
@property(nonatomic,strong)CXCNavigationController *nav4;
@property(nonatomic,strong)CXCNavigationController *nav5;

@end

@implementation CXCTabBarController

//修改一个对象的appearence(appearance只能在控件显示之前设置) 全局外观 两种方法 1. load 2. initialize
// 1. 只调用一次
+ (void)load{
    
    /**
     *  谁才能敲出appearance 
        1.只要遵守了UIAppearance协议，还要实现这个方法
        2.那些属性可以通过appearace 修改,只有被hon g
     */
    
//    //获取整个应用程序下的tabBarItem
//   UITabBarItem  *tabbarItem = [UITabBarItem appearance]; //开发中很少用appearace方法
    //获取那个类中的uitabbarItem
//    UITabBarItem *tabarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];//过期用下边替代
    UITabBarItem *tabbarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    //设置按钮选中标题的颜色:富文本 :描述一个文字颜色，字体，阴影，空心，图文混排；
    NSMutableDictionary *dic_attributes = [NSMutableDictionary dictionary];
    dic_attributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    [tabbarItem setTitleTextAttributes:dic_attributes forState:UIControlStateSelected];
    
    //设置字体大小尺寸,只有正常状态下才有效果
    NSMutableDictionary *dic_attributesNor = [NSMutableDictionary dictionary];
    dic_attributesNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [tabbarItem setTitleTextAttributes:dic_attributesNor forState:UIControlStateNormal];

}

/**
 // 2. 注意：可能会调用多次
 + (void)initialize{
 if (self == [CXCTabBarController class]) {
 ;//修改全局appeatance 全局外观
 }
 }
 
 - returns: void
 */

/**
 *  问题：
 1.选中的图片被渲染 -->在ios7之后默认 tabbar 上的按钮图片都被渲染 （解决：1.修改图片 2.去掉渲染{xcassets中render Image--> 设置成originImage 或者 代码修改}）
 2.选中的标题颜色被渲染， 要求（黑色 字体大）-->  //设置字体大小尺寸,只有正常状态下才有效果
 3.发布的按钮显示不出来 -->分析： 为什么人家的图片可以，我的不可以==》发布图片太大，导致显示不出来？
    1.图片太大系统帮你渲染==> 能显示但是位置不对 --》设置内边距
    解决； 不能修改图片尺寸， 效果让发布图片居中；
    1. 有没有文字图片的位置都固定，2.加好的图片比其他图片大，因此就会超出tabbar 3.不要超出，让加号图片垂直居中==》修改加号位置==》tabbar上按钮位置有系统决定，我们自己不能决定 = 》 系统的tabbarButton没有提供图片高亮状态，因此做不成实例程序效果==》加号是普通按钮，高亮状态 
        ==》自定义tabBar
        系统的tabBarButton什么时候添加到self.tabBar ,在viewWillAppear中super viewWillApear
 */

    /**
    *  修改插件 -->
    *
    *
    */

#pragma mark --生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAllChildVC];
    [self setAllTabBarItem];
    [self setTabBar];
}
#pragma mark --设置所有子控制器
- (void)setAllChildVC{
    //2.1 添加子控制器（5个）---》 划分文件项目结构
    //1.精华
    CXCEssenceViewController *essenceVC = [[CXCEssenceViewController alloc]init];
    self.nav1 = [[CXCNavigationController alloc]initWithRootViewController:essenceVC];
    [self addChildViewController:self.nav1];
    //2.新帖
    CXCNewViewController *newVC = [[CXCNewViewController alloc]init];
    self.nav2 = [[CXCNavigationController alloc]initWithRootViewController:newVC];
    [self addChildViewController:self.nav2];
//    //3.发布
//     self.publishVC = [[CXCPublishViewController alloc]init];
//    
//    [self addChildViewController:self.publishVC];
    //4.关注
    CXCFriendTrendViewController *friendTrendVC = [[CXCFriendTrendViewController alloc]init];
    self.nav4 = [[CXCNavigationController alloc]initWithRootViewController:friendTrendVC];
    [self addChildViewController:self.nav4];
    //5.我 storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([CXCMeViewController class]) bundle:nil];
    CXCMeViewController *meVC = [storyboard instantiateInitialViewController];
    self.nav5 = [[CXCNavigationController alloc]initWithRootViewController:meVC];
    [self addChildViewController:self.nav5];
}
#pragma mark --设置所有tabBarItem
- (void)setAllTabBarItem{
    
    //2.2设置tabBar上的按钮内容 --》由对应的自控制器的tabBarItem属性设置
    //1.精华
        //可以这样做
    UINavigationController *nav1 = self.childViewControllers[0];
    nav1.tabBarItem.title = @"精华";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
        //修改图片渲染(代码方式)
//    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //快速生成没有被渲染的图片--》分类：类方法
    nav1.tabBarItem.selectedImage = [UIImage imageOriginImageName:@"tabBar_essence_click_icon"];
    
    //2.新帖
    self.nav2.tabBarItem.title = @"新帖";
    self.nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    //修改图片渲染(代码方式)
    self.nav2.tabBarItem.selectedImage = [UIImage imageOriginImageName:@"tabBar_new_click_icon"];
//    //3.发布
//    self.publishVC.tabBarItem.image = [UIImage imageOriginImageName:@"tabBar_publish_icon"];
//    //设置图片内边距
//    self.publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    //修改图片渲染(代码方式)
//    self.publishVC.tabBarItem.selectedImage = [UIImage imageOriginImageName:@"tabBar_publish_click_icon"];
    //4.关注
    self.nav4.tabBarItem.title = @"关注";
    self.nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    //修改图片渲染(代码方式)
    self.nav4.tabBarItem.selectedImage = [UIImage imageOriginImageName:@"tabBar_friendTrends_click_icon"];
    //5.我
    self.nav5.tabBarItem.title = @"我";
    self.nav5.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    //修改图片渲染(代码方式)
    self.nav5.tabBarItem.selectedImage = [UIImage imageOriginImageName:@"tabBar_me_click_icon"];
}

#pragma mark --自定义tabBar
- (void)setTabBar{
    CXCTabBar *tabBar = [[CXCTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"]; //1.setTabBar 2.属性tabBar 3._tabBar
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
