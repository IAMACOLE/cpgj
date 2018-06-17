//
//  MCH5ViewController.m
//  SchoolMakeUp
//
//  Created by goulela on 16/9/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCH5ViewController.h"
#import "MCTabbarController.h"
//#import <JavaScriptCore/JavaScriptCore.h>

@interface MCH5ViewController ()<UIWebViewDelegate>{
    NSInteger _isFirstShow;
//    JSContext *_context;
    BOOL ishiddHUD;
}
@end

@implementation MCH5ViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    
    ishiddHUD = YES;
    
    
    [self basicSetting];
}


#pragma mark - 系统代理

#pragma mark - 点击事件

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting{
    self.titleString = self.titleStr;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self loadWebView];
    
    
}
#pragma mark 加载首页webView
-(void)loadWebView{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, MCScreenHeight - 64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
   
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    
    [webView loadRequest:request];
    
    webView.delegate = self;
    [self.view addSubview:webView];
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (ishiddHUD) {
        [MCView BSMBProgressHUD_bufferAndTextWithView:self.view andText:@"正在为您加载\n请耐心等候..."];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{  // h5 加载完毕
//    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    self.titleString = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    ishiddHUD = NO;//为解决客服多次连接而设置的控制开关
    [self hiddenBSMBProgressHUD];
    
//    _context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue){
//        context.exception = exceptionValue;
//        NSLog(@"%@", exceptionValue);
//    };

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{  // h5 加载失败
    [self hiddenBSMBProgressHUD];
   
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hiddenBSMBProgressHUD];
}

-(void)hiddenBSMBProgressHUD{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            [MCView BSMBProgressHUD_hideWith:self.view];
        }
    }
}




@end
