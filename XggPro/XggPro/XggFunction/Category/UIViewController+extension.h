//
//  UIViewController+extension.h
//  KinWind
//
//  Created by Baird-weng on 16/6/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (extension)
-(void)SetShowLoadingState:(NSString *)String;
-(void)setShowLoadingdismiss;
-(void)setShowMessage:(NSString *)String;

-(void)setShowLoadingInWindow:(NSString *)String;
-(void)SetShowMessageInWindow:(NSString *)String;

//-(void)setNavigationTitle:(NSString *)String;
//-(void)setNavigationblackColor:(UIColor *)Color;
-(void)setLeftBarItemIcon:(NSString *)String andTitle:(NSString *)Title addTarget:(id)Target action:(SEL)Btnact;
-(void)setRightBarItemIcon:(NSString *)String butItemTitle:(NSString *)Title addTarget:(id)Target action:(SEL)Btnact;
-(void)LoginOutVC;
-(void)LoginVC;
//-(void)processingErrorMessage:(id)data;
-(void)networkAnomalies;
////显示提示。
//-(void)showAlertViewofString:(NSString *)AlertText;
////进入登录页面
//-(void)PushLoginViewController;
////自定义转场动画。
//-(void)customAnimationNavigation:(UIViewController *)Vc;
-(void)processingErrorMessage:(id)data;
@end
