//
//  XggWebViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/23.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "XGGHeader.h"
#define ToolsHeaight 44
#define ToolsbarHeight 40
typedef NS_ENUM(NSInteger, WebViewToolsType) {
    WebViewToolsTypeofnone,
    WebViewToolsTypeofback,
    WebViewToolsTypeofForward,
    WebViewToolsTypeofbackForward,
};
@interface XggWebViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property(nonatomic,weak)UIWebView *webView;
@property(nonatomic,weak)UITabBar *toolsBar;
@end
@implementation XggWebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    UIWebView *dataWebView = UIWebView.new;
    dataWebView.delegate = _progressProxy;
    [self.view addSubview:dataWebView];
    __weak typeof(self)WeakSelf = self;
    [dataWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(WeakSelf.view);
    }];
    self.webView = dataWebView;
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self reloadWebData];

    [self setLeftBarItemIcon:nil andTitle:nil addTarget:self action:@selector(ClickOntheback)];
    self.isShowTool = YES;
    // Do any additional setup after loading the view.
}

/**
   初始化工具
 */
-(void)initToolsbar{
    __weak typeof(self)WeakSelf = self;
    UITabBar *tabbar = [[UITabBar alloc]init];
    [self.view addSubview:tabbar];
    [tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(WeakSelf.view);
        make.height.equalTo(@(ToolsHeaight));
    }];
    self.toolsBar = tabbar;
    UIButton *leftBtn = UIButton.new;
    [leftBtn setImage:[UIImage imageNamed:@"webtools_left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ClickOntheback) forControlEvents:UIControlEventTouchUpInside];
    [self.toolsBar addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.width.height.equalTo(@(ToolsbarHeight));
        make.centerY.equalTo(WeakSelf.toolsBar.mas_centerY);
    }];
    
    
    UIButton *rightBtn = UIButton.new;
    [rightBtn setImage:[UIImage imageNamed:@"webtools_right"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(ClickOntheRight) forControlEvents:UIControlEventTouchUpInside];
    [self.toolsBar addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.toolsBar).offset(-30);
        make.width.height.equalTo(@(ToolsbarHeight));
        make.centerY.equalTo(WeakSelf.toolsBar.mas_centerY);
    }];
    
    
    UIButton *reloadBtn = UIButton.new;
    [reloadBtn setImage:[UIImage imageNamed:@"webtools_reload"] forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(ClickOnthereload) forControlEvents:UIControlEventTouchUpInside];
    [self.toolsBar addSubview:reloadBtn];
    [reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(ToolsbarHeight));
        make.right.equalTo(WeakSelf.view.mas_right).offset(-15);
        make.centerY.equalTo(WeakSelf.toolsBar.mas_centerY);
    }];
    
}
-(void)ClickOntheRight{
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}
-(void)ClickOntheback{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)ClickOnthereload{
    [self.webView reload];
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self reloadToolsView];
}
-(void)reloadToolsView{
    if (self.webView.canGoBack&&self.webView.canGoForward) {
        [self reloadToolsViewWithType:WebViewToolsTypeofbackForward];
    }
    else if (self.webView.canGoBack){
        [self reloadToolsViewWithType:WebViewToolsTypeofback];
    }
    else if(self.webView.canGoForward){
        [self reloadToolsViewWithType:WebViewToolsTypeofForward];
    }
    else{
        [self reloadToolsViewWithType:WebViewToolsTypeofnone];
    }
    if (self.webView.canGoBack) {
        self.fd_interactivePopDisabled = YES;
    }
    else{
        self.fd_interactivePopDisabled = NO;
    }
}

-(void)reloadToolsViewWithType:(WebViewToolsType)type{
    switch (type){
        case WebViewToolsTypeofnone:{
        
        }
            break;
        case WebViewToolsTypeofback:{
       
        }
        break;
        case WebViewToolsTypeofForward:
            
            break;
        case WebViewToolsTypeofbackForward:
            
            break;
            
        default:
            break;
    }
}
-(void)reloadWebData{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.WebURL];
    [self.webView loadRequest:request];
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
