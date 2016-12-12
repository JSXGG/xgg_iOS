//
//  UIViewController+extension.m
//  KinWind
//
//  Created by Baird-weng on 16/6/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "UIViewController+extension.h"
#import "UIColor+extension.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "CRToast.h"
#import "IntervaloferrorModel.h"
#import "XggTabBarController.h"
#import "LoginfoViewController.h"
#import "UserbaseModel.h"
#import "UIBarButtonItem+Extension.h"
#define delayTime 1.2f
@implementation UIViewController (extension)
//-(void)setNavigationTitle:(NSString *)String{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    //导航栏的背景
//    UIImage *Navimage = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 48)];
//    [self.navigationController.navigationBar setBackgroundImage:Navimage forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
//    self.view.backgroundColor = [HVModelClass colorWithHexString:@"f2f2f3"];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    self.title = String;
//}
//-(void)setNavigationblackColor:(UIColor *)Color{
//    //导航栏的背景
//    UIImage *Navimage = [self imageWithColor:Color size:CGSizeMake(self.view.frame.size.width, 48)];
//    [self.navigationController.navigationBar setBackgroundImage:Navimage forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
//    self.view.backgroundColor = [HVModelClass colorWithHexString:@"f2f2f3"];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//}
////自定义返回按钮。
-(void)setLeftBarItemIcon:(NSString *)String andTitle:(NSString *)Title addTarget:(id)Target action:(SEL)Btnact{
    if (Title.length>0) {
         UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
         backbutton.frame = CGRectMake(0, 20, 44, 44);
         backbutton.backgroundColor = [UIColor clearColor];
         [backbutton setImage:[UIImage imageNamed:String] forState:UIControlStateNormal];
         [backbutton setTitle:Title forState:UIControlStateNormal];
         [backbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         backbutton.titleLabel.font = [UIFont systemFontOfSize:17];
         [backbutton addTarget:Target action:Btnact forControlEvents:UIControlEventTouchUpInside];
         UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
         negativeSpacer.width = -10;
         UIBarButtonItem *LeftItem = [[UIBarButtonItem alloc]initWithCustomView:backbutton];
         self.navigationItem.leftBarButtonItems = @[negativeSpacer,LeftItem];
    }
    else{
        if (String.length>0) {
             self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTargat:Target action:Btnact image:String highImage:String];
        }
        else{
             self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTargat:Target action:Btnact image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        }
       
    }
}
//
//设置右边按钮
-(void)setRightBarItemIcon:(NSString *)String butItemTitle:(NSString *)Title addTarget:(id)Target action:(SEL)Btnact{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    if (String != nil){
        UIImage *iconImage = [UIImage imageNamed:String];
        saveBtn.frame = CGRectMake(0, 0, 60, 44);
        [saveBtn setImage:iconImage forState:UIControlStateNormal];
    }
    saveBtn.contentMode = UIViewContentModeScaleAspectFit;
    saveBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    saveBtn.titleLabel.textAlignment = 2;
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:Target action:Btnact forControlEvents:UIControlEventTouchUpInside];
    if (Title.length>0) {
        [saveBtn setTitle:Title forState:UIControlStateNormal];
        CGSize btnSize = [saveBtn sizeThatFits:CGSizeMake(65, 44)];
        saveBtn.frame = CGRectMake(0, 0, btnSize.width, 44);
    }
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,backbtn];
    if (String == nil&&Title==nil) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}
////绘制单色的图片
//-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
//    @autoreleasepool {
//        CGRect rect = CGRectMake(0, 0, size.width, size.height);
//        UIGraphicsBeginImageContext(rect.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetFillColorWithColor(context,color.CGColor);
//        CGContextFillRect(context, rect);
//        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return img;
//    }
//}
//loading。
-(void)SetShowLoadingState:(NSString *)String{
    [self setShowLoadingdismiss];
    MBProgressHUD *Mb = [self GetDefaultHUB];
    Mb.label.text = String;
}
//取消显示的提示
-(void)setShowLoadingdismiss{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD hideHUDForView:self.view.window animated:YES];

}
//正确的提示
-(void)setShowMessage:(NSString *)String{
    MBProgressHUD *Mb = [MBProgressHUD HUDForView:self.view];
    if (Mb == nil) {
        Mb = [self GetDefaultHUB];
    }
    Mb.label.text = String;
    Mb.label.numberOfLines = 0;
    Mb.mode = MBProgressHUDModeText;
    [Mb hideAnimated:YES afterDelay:delayTime];
}

-(void)setShowLoadingInWindow:(NSString *)String{
    MBProgressHUD *Mb = [self GetDefaultHUBInWindow];
    Mb.label.text = String;
}
-(void)SetShowMessageInWindow:(NSString *)String{
    MBProgressHUD *Mb = [MBProgressHUD HUDForView:self.view.window];
    if (Mb == nil) {
        Mb = [self GetDefaultHUBInWindow];
    }
    if (String.length>0) {
        Mb.label.text = String;
        Mb.label.numberOfLines = 0;
        Mb.mode = MBProgressHUDModeText;
        [Mb hideAnimated:YES afterDelay:delayTime];
    }
    else{
        [Mb hideAnimated:YES];
    }
}

-(MBProgressHUD *)GetDefaultHUB{
    MBProgressHUD *Mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    Mb.bezelView.color = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    Mb.contentColor = [UIColor whiteColor];
    Mb.label.font = [UIFont systemFontOfSize:14];
    Mb.animationType = MBProgressHUDAnimationZoomIn;
    Mb.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    return Mb;
}
-(MBProgressHUD *)GetDefaultHUBInWindow{
    MBProgressHUD *Mb = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    Mb.bezelView.color = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    Mb.contentColor = [UIColor whiteColor];
    Mb.label.font = [UIFont systemFontOfSize:14];
    Mb.animationType = MBProgressHUDAnimationZoomIn;
    Mb.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    return Mb;
}

-(void)LoginOutVC{
    //清空登录信息。
    UserbaseModel *model = [UserbaseModel findByPK:1];
    model.pwd = @"";
    model.userToken = @"";
    [model saveOrUpdate];
    LoginfoViewController *LoginfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"LoginfoViewController"];
    [self.view removeFromSuperview];
    AppDelegate *Delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    Delegate.window.rootViewController = LoginfoVC;
}
-(void)LoginVC{
    IntervaloferrorModel *model = [IntervaloferrorModel findByPK:1];
    model.iscanperform = YES;
    [model saveOrUpdate];
    [self.view removeFromSuperview];
    AppDelegate *Delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    XggTabBarController *XggTabbarVc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"XggTabBarController"];
    Delegate.window.rootViewController = XggTabbarVc;
}

-(void)processingErrorMessage:(id)data{
    NSString *error = [data objectForKey:@"error"];
    if (error.length>0){
        AppDelegate *Delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        BOOL iscanperform = NO;
        if ([Delegate.window.rootViewController isKindOfClass:[XggTabBarController class]]) {
            iscanperform = YES;
        }
        if ([error isEqualToString:@"usertokenInvalid"]&&iscanperform){
            [self setShowLoadingdismiss];
            UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"您的账号在其它设备登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                [self LoginOutVC];
            }];
            [AlertController addAction:Action];
            [self.navigationController presentViewController:AlertController animated:YES completion:^{
            }];
        }
        else{
            //判断是window还是view。
            MBProgressHUD *Mb = [MBProgressHUD HUDForView:self.view.window];
            if (Mb) {
                [self SetShowMessageInWindow:error];
            }
            else{
                [self setShowMessage:error];
            }
        }
    }
}
-(void)networkAnomalies{
    [self setShowLoadingdismiss];
    IntervaloferrorModel *model = [IntervaloferrorModel findByPK:1];
    if (model==nil) {
        model = [[IntervaloferrorModel alloc]init];
        model.pk = 1;
        model.iscanperform = YES;
        model.networkErrorlastTime = [[NSDate date]timeIntervalSince1970];
        [model saveOrUpdate];
    }
    double currentTime = [[NSDate date]timeIntervalSince1970];
    if (currentTime-model.networkErrorlastTime>5){
        [self setShowLoadingdismiss];
        model.networkErrorlastTime = [[NSDate date]timeIntervalSince1970];
        [model saveOrUpdate];
        [self setNavagationToastState:@"网络异常"];
    }
}
//导航栏动画提示
-(void)setNavagationToastState:(NSString *)String{
    [self setShowLoadingdismiss];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    [CRToastManager dismissNotification:YES];
    option[kCRToastTextKey]=String;
    option[kCRToastTextAlignmentKey]= @(NSTextAlignmentLeft);
    option[kCRToastFontKey] = [UIFont systemFontOfSize:15];
    option[kCRToastBackgroundColorKey] = [UIColor colorWithHexString:@"FD8522"];
    option[kCRToastNotificationTypeKey] = @(CRToastTypeNavigationBar);
    option[kCRToastTimeIntervalKey] = @(1);
    option[kCRToastAnimationInDirectionKey] = @(0);
    option[kCRToastAnimationOutDirectionKey] = @(0);
    option[kCRToastImageKey] = [UIImage imageNamed:@"alert_icon.png"];
    option[kCRToastNotificationPresentationTypeKey] = @(CRToastPresentationTypeCover);
    [CRToastManager showNotificationWithOptions:option completionBlock:^{
    }];
}

-(void)showAlertViewofString:(NSString *)AlertText{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:AlertText message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"记住了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
@end
