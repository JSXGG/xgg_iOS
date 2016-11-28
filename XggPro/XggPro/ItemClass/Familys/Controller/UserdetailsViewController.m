//
//  UserdetailsViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "UserdetailsViewController.h"
#import "Xggdataeditor.h"
#import "XggaddStoryVc.h"
#import "XGGHeader.h"
@interface UserdetailsViewController (){
    UIWebView *_datawebView;
}
@end

@implementation UserdetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人简介";
    self.view.backgroundColor = [UIColor whiteColor];
    _datawebView = [[UIWebView alloc]init];
    _datawebView.opaque = NO;
    _datawebView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_datawebView];
    [_datawebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self setRightBarItemIcon:@"navigationbar_add" butItemTitle:nil addTarget:self action:@selector(ClickOntheRight)];
    [self relaodWebView];
    // Do any additional setup after loading the view.
}
-(void)relaodWebView{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xggweb/userbiography/ubgpage.html?uid=%@",MYHOST,self.uid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_datawebView loadRequest:request];
}
-(void)ClickOntheRight{
    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self)WeakSelf = self;
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"添加故事" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        XggaddStoryVc *xggdataVC = [[XggaddStoryVc alloc]init];
        [xggdataVC SetStoryWithUid:WeakSelf.uid WithBlock:^{
            [WeakSelf relaodWebView];
        }];
        XggNavigationController *navigation = [[XggNavigationController alloc]initWithRootViewController:xggdataVC];
        [WeakSelf presentViewController:navigation animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
    }];
    [AlertController addAction:action2];
    [AlertController addAction:action3];
    [self.navigationController presentViewController:AlertController animated:YES completion:nil];
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
