//
//  CXCADViewController.m
//  01BudeJie
//
//  Created by tarena on 16/9/2.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCADViewController.h"
#import "CXCTabBarController.h"
#import "NetManager.h"
#import "CXCADItemModel.h"

@interface CXCADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchScreenImageView;
@property (weak, nonatomic) IBOutlet UIView *adContaintView;
@property (nonatomic)  UIImageView *adView;
@property (weak, nonatomic) IBOutlet UIButton *timeChangeButton;
@property (nonatomic,weak)NSTimer *timer;
@property (nonatomic,strong) CXCADItemModel *adItem;
@end

@implementation CXCADViewController
- (IBAction)timeChangeButtonClicked:(id)sender {
    
    //销毁广告界面,进入主框架界面
    CXCTabBarController *tabBar = [CXCTabBarController new];
    [UIApplication sharedApplication].keyWindow.rootViewController =tabBar;
    //干掉定时器
    [_timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //屏幕适配
    [self setupLaunchScreen];
    
    /**
     *  加载广告数据==》拿到活时间 ==》 服务器 ==》 查看接口文档1. 判断接口对不对 2.解析数据（在线json.cn）（w_picurl，ori_curl：跳转到广告界面 ，w,h）==》 请求数据（AFN）
     
     *  导入AFN框架：用cocodpods导入
     *  cocodpods:管理第三方库，cocodpods做的是：倒入一个框架，会把这个框架依赖的所有框架都导入
        cocodpods步骤：podfile:描述需要导入的哪些框架 touch podfile
                    2. 打开podfile 描述 open podfile
                    3. 搜索需要导入的框架描述 pod search AFN
                    4. 安装第三方框架 pod install -no-repo-update
     */
    [self loadAdData];
    [self.view bringSubviewToFront:_timeChangeButton];
    // 创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange{
    static int i = 3;
    //设置跳转按钮的文字
    
    [_timeChangeButton setTitle:[NSString stringWithFormat:@"跳转(%d)",i] forState:UIControlStateNormal];
    if (i == 0) {
        [self timeChangeButtonClicked:_timeChangeButton];
    }
    i--;
}

#pragma mark - 广告加载
- (void)loadAdData{
    /**
     *  http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
     */
    
   
    
    // 1. 请求会话
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    // 
    // 2. 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = CODE2;
    // 3. 发送请求
    [httpManager GET:CXCADUrlPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求数据--》 解析数据（携程plist）-->展示数据
        [responseObject writeToFile:@"/Users/tarena/Desktop/myTest/AD.plist" atomically:YES];
        NSDictionary *dic = [responseObject[@"ad"] lastObject];
        self.adItem = [CXCADItemModel mj_objectWithKeyValues:dic];
        
        //显示图片
        CGFloat h = CXCScreenW * _adItem.h / _adItem.w;
        self.adView.frame = CGRectMake(0, 0, CXCScreenW, h);
        [self.adView setImageWithURL:_adItem.w_picurl.cxc_url];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)setupLaunchScreen{
    if (iphone6p) {//6p
        self.LaunchScreenImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if(iphone6){//6
        self.LaunchScreenImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iphone5){//5
        self.LaunchScreenImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else{
        self.LaunchScreenImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
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

- (UIImageView *)adView {
	if(_adView == nil) {
		_adView = [[UIImageView alloc] init];
        [self.view addSubview:_adView];
        
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_adView setUserInteractionEnabled:YES];
        [_adView addGestureRecognizer:tap];
        [self.view sendSubviewToBack:_adView];
        [self.view sendSubviewToBack:_LaunchScreenImageView];
	}
	return _adView;
}

//点击广告
- (void)tap{
    //跳转 == > safari
    
//    [[UIApplication sharedApplication] openURL:self.adItem.ori_curl.cxc_url];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:self.adItem.ori_curl.cxc_url]) {
        [app openURL:self.adItem.ori_curl.cxc_url];
    }
    
    
}

@end
