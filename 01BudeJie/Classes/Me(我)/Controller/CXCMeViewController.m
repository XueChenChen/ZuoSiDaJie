//
//  CXCMeViewController.m
//  01BudeJie
//
//  Created by tarena on 16/8/27.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCMeViewController.h"
#import "CXCSettingViewController.h"
#import "CXCAppListCollectionCell.h"
#import "CXCMeAppListModel.h"
#import <SafariServices/SafariServices.h>
#import "CXCWebController.h"
#import "NetManager.h"

@interface CXCMeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>

@property (nonatomic) NSMutableArray<Square_List *> *appItems;

@property (nonatomic, weak)UICollectionView *collectionView;

@end

static NSString *identifier = @"appCell";
static NSInteger coNumber = 4;
static CGFloat coMargin = 1;
//static CGFloat item_w = (CXCScreenW - (coNumber - coMargin) ) / coNumber; //语法不成立
#define   item_w  ((CXCScreenW - (coNumber - coMargin) ) / coNumber)

@implementation CXCMeViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self setupFootView];
    
    [self loadData];
    
    self.tableView.sectionFooterHeight = CXCMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(CXCMargin - 25, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(self.tableView.tableHeaderView.frame));
    NSLog(@"%@",NSStringFromUIEdgeInsets( self.tableView.contentInset));
}

- (void)loadData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"square";
    dic[@"c"] = @"topic";
    
    [NetManager getNorAppMeDataFromNetWithUrlParameters:dic completionHandler:^(CXCMeAppListModel *modelClass, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试!"];
        }else{
            
            [self.appItems addObjectsFromArray:modelClass.square_list];
            
            //处理数据补items
            [self resloveData];
            
            //计算colletionView的高度
            NSInteger allCount = _appItems.count;
            NSInteger allrows = ( allCount -1 ) / coNumber + 1;
            //item_h == item_w;
            self.collectionView.CXC_heigth = allrows * item_w + allrows * (allrows - 1) * coMargin;
            //tableView的滚动范围：会自己计算你只要给他就行了
            self.tableView.tableFooterView = self.collectionView;
            
            [_collectionView reloadData];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonClicked:) name:CXCtabBarButtonClickedNotification object:nil];
        }
    }];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//   
//    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        [responseObject writeToFile:@"/Users/tarena/Desktop/myTest/me.plist" atomically:YES];
//        NSArray *modelJson = responseObject[@"square_list"];
//       _appItems = [CXCMeAppListModel mj_objectArrayWithKeyValuesArray:modelJson];
//        
//        //处理数据补items
//        [self resloveData];
//        
//        //计算colletionView的高度
//        NSInteger allCount = _appItems.count;
//        NSInteger allrows = ( allCount -1 ) / coNumber + 1;
//        //item_h == item_w;
//        self.collectionView.CXC_heigth = allrows * item_w + allrows * (allrows - 1) * coMargin;
//        //tableView的滚动范围：会自己计算你只要给他就行了
//        self.tableView.tableFooterView = self.collectionView;
//        
//        [_collectionView reloadData];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonClicked:) name:CXCtabBarButtonClickedNotification object:nil];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    
}

#pragma mark - 监听方法
- (void)tabBarButtonClicked:(NSNotification *)senderNotification{
    if (self.view.window == nil) return;
    
}

/**
 *  footView -> collectionView
 */
- (void)setupFootView{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    
//    NSInteger coNumber = 4;
//    CGFloat coMargin = 1;
//    CGFloat item_w = (CXCScreenW - (coNumber - coMargin) ) / coNumber;
    flowLayout.itemSize = CGSizeMake(item_w, item_w);
    flowLayout.minimumLineSpacing = coMargin;
    flowLayout.minimumInteritemSpacing = coMargin;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CXCScreenW, 600) collectionViewLayout:flowLayout];
    _collectionView = collectionView;
    _collectionView.scrollEnabled = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"CXCAppListCollectionCell" bundle:nil] forCellWithReuseIdentifier:identifier];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

/**
 *  设置导航栏.barItem
 */
- (void)setNavigationBar{
    //设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(settingClick:)];
    //moon
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(moonClick:)];
    
    //right
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    //title
    self.navigationItem.title = @"我的";
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection数据源代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.appItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CXCAppListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.item = self.appItems[indexPath.row];
    
    return cell;
}

#pragma mark - collectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /**
     *  展示网页
     *  1. safari openUrl:自带很多功能（进度条，刷新，前进倒退）必须跳出当前应用
     *  2. UIWebView （没有功能）当前应用打开网页，且有safari功能得自己实现，UIWebView不能实现进度条
        3. 需求；即想要在当前应用展示网页，有想要Safari功能 （iOS9）
            3.1 导入 #import <SafariServices/SafariServices.h>
     
//    CXCMeAppListModel *model = self.appItems[indexPath.row];
//    if (![model.url containsString:@"http"]) return;
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:model.url.cxc_url];
////    safariVC.delegate = self; //modally 不用代理 会自动调用dismiss
////    self.navigationController.navigationBarHidden = YES;
////    [self.navigationController pushViewController:safariVC animated:YES];
//    [self presentViewController:safariVC animated:YES completion:nil];
     
        4.WKWebView 上方UIwebView 的升级版 (iOS8) (1.可以监听进度 2.可以缓存)
     */
    CXCWebController *webVC = [CXCWebController new];
    Square_List *model = self.appItems[indexPath.row];
    if (![model.url containsString:@"http"]) return;
    webVC.webUrl = model.url.cxc_url;
    [self.navigationController pushViewController:webVC animated:YES];
    
}
#pragma mark -safari的代理方法
/*! @abstract Delegate callback called when the user taps the Done button. Upon this call, the view controller is dismissed modally. */ //苹果推荐用dismissed 也就是说presentViewController 过去
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
////    [self.navigationController popViewControllerAnimated:YES];
//
//}

#pragma mark - target
- (void)settingClick:(id)sender{
    CXCSettingViewController *settingVC = [[CXCSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
    
}

- (void)moonClick:(UIButton*)sender{
    sender.selected = !sender.selected;
}

- (void)resloveData{
   NSInteger ex = _appItems.count % coNumber;
    if (ex) {
        for (int i = 0 ; i < (coNumber - ex); i++) {
            [_appItems addObject:[Square_List new]];
        }
    }
}

- (NSMutableArray<Square_List *> *)appItems {
	if(_appItems == nil) {
		_appItems = [[NSMutableArray<Square_List *> alloc] init];
	}
	return _appItems;
}

@end
