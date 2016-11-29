//
//  CXCWebController.m
//  01BudeJie
//
//  Created by tarena on 16/9/29.
//  Copyright © 2016年 陈薛晨. All rights reserved.
//

#import "CXCWebController.h"
#import <WebKit/WebKit.h>

@interface CXCWebController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic)  WKWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation CXCWebController

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)reload:(id)sender {
    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *myWebView = [[WKWebView alloc]init];
    _webView = myWebView;
    [self.contentView addSubview:myWebView];
    //展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:self.webUrl];
    [myWebView loadRequest:request];
    //前进 后退 刷新功能
//    按钮什么情况下能点 KVO
    /**
     *  KVO: 监听属性的改变
            observe ： 观察者
            KeyPath ： 观察webView的那个属性
            options ： NSKeyValueObservingOptionNew 观察新值改变
     *  KVO注意点。一定注意移除
     */
    [myWebView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [myWebView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [myWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [myWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

//只要观察的属性改变有新值是就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    self.backItem.enabled = !self.webView.canGoBack;
    self.forwardItem.enabled = !self.webView.canGoForward;
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

- (void)dealloc{
//    KVO 注意点
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _webView.frame = self.contentView.bounds;
    
}

@end
