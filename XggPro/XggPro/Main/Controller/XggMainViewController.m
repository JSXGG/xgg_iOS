//
//  XggMainViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/22.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggMainViewController.h"
#import "XGGHeader.h"
#import "FunctionCell.h"
#import "XggWebViewController.h"
@interface XggMainViewController ()<UIWebViewDelegate>
@property(nonatomic,weak)UIWebView *dataWebView;
@property(nonatomic,strong)UILongPressGestureRecognizer *GestureRecognizer;
@end
@implementation XggMainViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _GestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(reloadWebData)];
    [self.navigationController.view addGestureRecognizer:_GestureRecognizer];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.view removeGestureRecognizer:_GestureRecognizer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *dataWebView = UIWebView.new;
    dataWebView.delegate = self;
    [self.view addSubview:dataWebView];
    __weak typeof(self)WeakSelf = self;
    [dataWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(WeakSelf.view);
    }];
    self.dataWebView = dataWebView;
    self.dataWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self reloadWebData];

    // Do any additional setup after loading the view.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = [request.URL absoluteString];
    NSArray *urlAry = [urlStr componentsSeparatedByString:@"::"];
    if ([urlAry count]==2){
        
        XggWebViewController *XggWebView = [[XggWebViewController alloc]init];
        XggWebView.WebURL = [NSURL URLWithString:urlAry[1]];
        XggWebView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:XggWebView animated:YES];
        return NO;
    }
    return YES;
}
-(void)reloadWebData{
    if (!self.WebURL) {
        self.title = @"主页";
        self.WebURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xggweb/news/toutiao.html",MYHOST]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:self.WebURL];
    [self.dataWebView loadRequest:request];
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
