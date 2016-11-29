//
//  CXCEssenceViewController.m
//  01BudeJie
//
//  Created by tarena on 16/8/27.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCEssenceViewController.h"
#import "CXCTitleButton.h"

#import "CXCAllViewController.h"
#import "CXCVideoViewController.h"
#import "CXCVoiceViewController.h"
#import "CXCPictureViewController.h"
#import "CXCWordViewController.h"

@interface CXCEssenceViewController () <UIScrollViewDelegate>
/** 存放所有自控制器的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) CXCTitleButton *previousClickedTitleButton;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
@end

@implementation CXCEssenceViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化子控制器
    [self setupAllChildVcs];
    
    // 设置导航条
    [self setNavigationBar];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
    
    
}


//
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
////    NSLog(@"%f - %s",self.topLayoutGuide.length, __func__);
//    self.titlesView.frame = CGRectMake(0, self.topLayoutGuide.length, CXCScreenW, 35);
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"%f - %s",self.topLayoutGuide.length, __func__);
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"%f - %s",self.topLayoutGuide.length, __func__);
//}
//-(void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    NSLog(@"%f - %s",self.topLayoutGuide.length, __func__);
//}

//- (void)loadViewIfNeeded{
//    [super loadViewIfNeeded];
//     NSLog(@"%f - %s",self.topLayoutGuide.length, __func__);
//}
//
//- (void)loadView{
//    [super loadView];
//    NSLog(@"%f - %s",self.topLayoutGuide.length, __func__);
//}
//
//- (UIView *)viewIfLoaded{
//    NSLog(@"%f - %s",self.topLayoutGuide.length, __func__);
//    return  [super viewIfLoaded];
//
//}




/**
 *  初始化子控制器
 */
- (void)setupAllChildVcs
{
    [self addChildViewController:[[CXCAllViewController alloc] init]];
    [self addChildViewController:[[CXCVideoViewController alloc] init]];
    [self addChildViewController:[[CXCVoiceViewController alloc] init]];
    [self addChildViewController:[[CXCPictureViewController alloc] init]];
    [self addChildViewController:[[CXCWordViewController alloc] init]];
}

/**
 *  设置导航栏.barItem
 */
- (void)setNavigationBar{
    //left
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:self action:@selector(game:)];
    //title
    self.navigationItem.titleView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //right
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"]highlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"]  addTarget:self action:@selector(game:)];
}

/**
 *  scrollView
 */
- (void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = NO; //点击状态栏不会滚动
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.CXC_width;
    //    CGFloat scrollViewH = scrollView.CXC_heigth;
    
    //    for (NSUInteger i = 0; i < count; i++) {
    //        // 取出i位置子控制器的view
    //        UIView *childVcView = self.childViewControllers[i].view;//懒加载全部创建出来，我不想这样
    //        childVcView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
    //        [scrollView addSubview:childVcView];
    //    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

/**
 *  标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    //    NSLog(@"%f",self.topLayoutGuide.length); //viewdidload 方法里因为不需要显示东西所以为0；一般此方法只是定义对象不设对象frame
    titlesView.frame = CGRectMake(0, CXCNavMaxY, self.view.CXC_width, CXCTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
}

/**
 *  标题栏按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.CXC_width / count;
    CGFloat titleButtonH = self.titlesView.CXC_heigth;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        CXCTitleButton *titleButton = [[CXCTitleButton alloc] init];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

#pragma mark - 监听
/**
 *  点击标题按钮
 */
- (IBAction)titleButtonClick:(CXCTitleButton *)titleButton
{
    
    [self dealTitleButtonClicked:titleButton];
}

/**
 *  处理点击titleButton后的一些基本功能
 *
 *  @param titleButton 当前点击titileButoon
 */
- (void)dealTitleButtonClicked:(CXCTitleButton *)titleButton{
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CXCtitleButtonClickedNotification object:nil];
    }
    
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = [self.titlesView.subviews indexOfObject:titleButton];
    [UIView animateWithDuration:0.25 animations:^{
        //处理下划线
        //        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        //        attributes[NSFontAttributeName] = titleButton.titleLabel.font;
        //        self.titleUnderline.CXC_width = [titleButton.currentTitle sizeWithAttributes:attributes].width;
        
        self.titleUnderline.CXC_width = titleButton.titleLabel.CXC_width + CXCMargin;
        self.titleUnderline.CXC_centerX = titleButton.CXC_centerX;
        
        //滚动scrollView
        CGFloat offsetX = index * self.scrollView.CXC_width;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        
    }completion:^(BOOL finished) {
        [self addChildVCViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        //        if (i == index) { // 是标题按钮对应的子控制器
        //            scrollView.scrollsToTop = YES;
        //        } else {
        //            scrollView.scrollsToTop = NO;
        //        }
        scrollView.scrollsToTop = (i == index);
    }
    

}

/**
 *  标题下划线
 */
- (void)setupTitleUnderline
{
    // 标题按钮
    CXCTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.CXC_heigth = 2;
    titleUnderline.CXC_y = self.titlesView.CXC_heigth - titleUnderline.CXC_heigth;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    self.titleUnderline.CXC_width = firstTitleButton.titleLabel.CXC_width + CXCMargin;
    self.titleUnderline.CXC_centerX = firstTitleButton.CXC_centerX;
    [self addChildVCViewIntoScrollView:0];
}


- (void)game:(id)sender{
    CXCFun;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UIScrollViewDelegate>
/**
 *  滑动结束减速
 *
 *  @param scrollView sender
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.CXC_width;
    [self dealTitleButtonClicked:self.titlesView.subviews[index]];
    [self addChildVCViewIntoScrollView:index];
}

#pragma mark - 其他方法
- (void)addChildVCViewIntoScrollView:(NSUInteger)index{
    //添加自控制器
    UIView *childVcView = self.childViewControllers[index].view;
//    childVcView.frame = CGRectMake(index * self.scrollView.CXC_width, 0, self.scrollView.CXC_width, self.scrollView.CXC_heigth);
    childVcView.frame = CGRectMake(self.scrollView.contentOffset.x, 0, self.scrollView.CXC_width, self.scrollView.CXC_heigth);
    [self.scrollView addSubview:childVcView];

}

@end
