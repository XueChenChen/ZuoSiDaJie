//
//  CXCSettingViewController.m
//  01BudeJie
//
//  Created by tarena on 16/9/1.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCSettingViewController.h"
#import "SDImageCache.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface CXCSettingViewController ()

@end

@implementation CXCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";

    //设置最右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"jump" style:0 target:self action:@selector(jump:)];
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setCell"];
}

- (void)jump{
    UIViewController *jumpVC = [UIViewController new];
    jumpVC.view.backgroundColor = [UIColor brownColor];
    [self.navigationController pushViewController:jumpVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];
    //计算整个应用的缓存 ==> 沙盒（Cache）==》获取cache文件夹的尺寸大小

//    [SDImageCache sharedImageCache].getSize

    //获取文件夹路径
//    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];//cachPaht
//    NSString *defaultPath = [cachPath stringByAppendingPathComponent:@"default"];
    NSString *sizeStr = @"清除缓存";
    NSInteger totalSize = [self getFileSize:CachePath];
    if (totalSize > 1000 * 1000) {
        //MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    }else if (totalSize > 1000){
        //KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    }else if (totalSize > 0){
        //B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    cell.textLabel.text = sizeStr;
    return cell;
}
#pragma  mark - 代理方法点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //清空缓存
    //获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //获取cache文件夹下的所有文件，不包括子路径的子路径
    NSArray *subPaths = [manager contentsOfDirectoryAtPath:CachePath error:nil];
    
    for (NSString *subPath in subPaths) {
        //拼接路径
        NSString *filePath = [CachePath stringByAppendingPathComponent:subPath];
        [manager removeItemAtPath:filePath error:nil];
    }
    
    [self.tableView reloadData];
}


#pragma mark - 自定义方法
//模仿SDWebImage做缓存
- (NSInteger)getFileSize:(NSString *)directoryPath{
    // NSFileManager
    // attributesOfItemAtPath: 指定文件路径，就能获取文件属性
    // 把所有文件尺寸加起来
    NSInteger allSize = 0;
    //获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
   
    
    //遍历文件加下所有文件进行文件尺寸计算
    NSArray *allFiles = [fileManager subpathsAtPath:directoryPath];
    for (NSString *subPath  in allFiles) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];//绝对路径 全路径
        //判断路径
        if ([filePath containsString:@".DS"]) continue;
        
        BOOL isDirectory;
        BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        //获取文件属性  获取文件夹不对，只能获取文件尺寸，文件夹不行
        NSDictionary *attr = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        //default尺寸
        allSize += [attr fileSize];
        
    }
    
    
//    NSLog(@"%ld",allSize);
    
    return allSize;
    
}



@end
