//
//  CXCSubTagViewController.m
//  01BudeJie
//
//  Created by tarena on 16/9/3.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCSubTagViewController.h"
#import "AFNetworking.h"
#import "CXCSubTagItemModel.h"
#import "CXCSubTagCell.h"

@interface CXCSubTagViewController ()

@property (nonatomic) NSMutableArray<CXCSubTagItemModel*> *modelList;
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@end

@implementation CXCSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //展示数据 -》 请求数据（接口文档：请求url(基本url+请求参数)）请求方式->
    [self loadDataFromNet];
    [self.tableView registerNib:[UINib nibWithNibName:@"CXCSubTagCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.title = @"推荐标签";
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor redColor];
   
    [SVProgressHUD showWithStatus:@"正在刷新中......"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - 请求数据
- (void)loadDataFromNet{
    
    //1. 创建请求回话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _manager = mgr;
    //2. 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"]      = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"]      = @"topic";
    //3. 发送请求
    
    [mgr GET:CXCOpenUrlPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.modelList = [CXCSubTagItemModel mj_objectArrayWithKeyValuesArray:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
//    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [SVProgressHUD dismiss];
//        CXCLog(@"%@",task.currentRequest.URL.absoluteString);
//        [responseObject writeToFile:@"/Users/tarena/Desktop/kk/xintie.plist" atomically:YES];
//        //字典--》模型（设计模型）
//        
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        CXCLog(@"%@",error);
//        
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.modelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    CXCSubTagItemModel *model = self.modelList[indexPath.row];
    // 自定义cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
////        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CXCSubTagCell class]) owner:nil options:nil][0];
//    }
    //重用2
    CXCSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell setItemModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray<CXCSubTagItemModel*> *)modelList {
	if(_modelList == nil) {
		_modelList = [[NSMutableArray<CXCSubTagItemModel*> alloc] init];
	}
	return _modelList;
}

@end
