//
//  XggNavigationController.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/1.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggNavigationController.h"
#import "XGGHeader.h"
@interface XggNavigationController ()

@end

@implementation XggNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationBar.barTintColor = NAVIGARIONBLACKCOLOR;
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:NAVIGARIONBTITLECOLOR,NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17]};
    [self.navigationBar setTitleTextAttributes:attriBute];
    self.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        self.view.backgroundColor = XGGBLCAKGROUNDCOLOR;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTargat:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back{
    [self popViewControllerAnimated:YES];
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
