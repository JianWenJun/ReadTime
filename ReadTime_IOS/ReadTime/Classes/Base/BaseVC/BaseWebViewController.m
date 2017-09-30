//
//  BaseWebViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseWebViewController.h"
#import <WebKit/WebKit.h>
@interface BaseWebViewController ()<UIWebViewDelegate,WKNavigationDelegate>

@property (assign,nonatomic)NSUInteger loadCount;
@property (strong,nonatomic)UIProgressView* progressView;
@property (strong,nonatomic)UIWebView* webView;
@property (strong,nonatomic)WKWebView* WKWebView;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self configUI];
    [self configBackItem];
    [self configMenuItem];
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - get
- (UIProgressView*)progressView{
    if (!_progressView) {
        UIProgressView* progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        progressView.tintColor=UIToneBackgroundColor;
        progressView.trackTintColor=[UIColor whiteColor];
        [self.view addSubview:progressView];
        self.progressView=progressView;
    }
    return _progressView;
}
#pragma mark - UI 创建
- (void)configUI{
    self.progressView.hidden=NO;
    if (IOS8x) {
        WKWebView* wKWebView=[[WKWebView alloc]initWithFrame:self.view.bounds];
        wKWebView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;;
        wKWebView.backgroundColor=ViewBackgroundColor;
        wKWebView.navigationDelegate=self;
        /*! 解决iOS9.2以上黑边问题 */
        wKWebView.opaque = NO;
        /*! 关闭多点触控 */
        wKWebView.multipleTouchEnabled = YES;
        [self.view insertSubview:wKWebView belowSubview:_progressView];
        [wKWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        self.WKWebView=wKWebView;
    }else{
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        /*! 适应屏幕 */
        webView.scalesPageToFit = YES;
        /*! 解决iOS9.2以上黑边问题 */
        webView.opaque = NO;
        /*! 关闭多点触控 */
        webView.multipleTouchEnabled = YES;
        /*! 加载网页中的电话号码，单击可以拨打 */
        webView.dataDetectorTypes = YES;
        
        [self.view insertSubview:webView belowSubview:_progressView];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
        [webView loadRequest:request];
        self.webView = webView;
    }
}
- (void)configBackItem{
    [self setLeftItemWithIcon:[UIImage imageNamed:@"back_more_nor"] title:@"" selector:@selector(backBtnAction)];
}

- (void)configMenuItem{
//    [self set]
}

/**
返回按钮点击
 */
- (void)backBtnAction{
    if (IOS8x) {
        if (self.WKWebView.canGoBack) {
            [self.WKWebView goBack];
            if (self.navigationItem.leftBarButtonItems.count==1) {
                [self configCloseItem];
            }
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if (self.webView.canGoBack) {
            [self.webView goBack];
            if (self.navigationItem.leftBarButtonItems.count == 1) {
                [self configCloseItem];
            }
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
/**
 导航栏关闭
 */
- (void)configCloseItem{
    
}

#pragma mark - WKNavigationDelegate代理实现方法

/**
 页面开始加载时调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    RT_SharedApplication.networkActivityIndicatorVisible=YES;
}

/**
 当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
/**
 当页面加载完成时调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (webView.title.length>0) {
        [self setNavigationItemTitleViewWithTitle:webView.title];
    }
}

/**
 加载页面失败时调用
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}
/*! 页面跳转的代理方法有三种，分为（收到跳转与决定是否跳转两种）*/
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"])
    {
//        BA_OpenUrl(navigationAction.request.URL);
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
#pragma mark - UIWebViewDelegate代理的实现方法
- (void)setLoadCount:(NSUInteger)loadCount{
    _loadCount=loadCount;
    if (loadCount == 0)
    {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }
    else
    {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95)
        {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.loadCount++;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.loadCount--;
    RT_SharedApplication.networkActivityIndicatorVisible=NO;
    [self setNavigationItemTitleViewWithTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.loadCount --;
}

#pragma mark -  进度条监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object==self.WKWebView&&[keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress=[[change objectForKey:NSKeyValueChangeNewKey]doubleValue];
        if (newProgress==1) {
            self.progressView.hidden=YES;
            [self.progressView setProgress:0 animated:NO];
        }else{
            self.progressView.hidden=NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }
}
- (void)dealloc
{
    if (IOS8x)
    {
        [self.WKWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

@end
