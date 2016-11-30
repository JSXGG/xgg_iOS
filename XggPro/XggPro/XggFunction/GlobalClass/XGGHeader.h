//
//  XGGHeader.h
//  XggPro
//
//  Created by Baird-weng on 2016/10/22.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#ifndef XGGHeader_h
#define XGGHeader_h



#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define SandBoxpath(Name)[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",Name]]

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"

#define sinaWeiboAppkey @"4147359171"
#define sinaWeiboSecret @"87933130f63bac009298fcea8fab03fb"
#define mobAppkey  @"18d9aefee0196" //appkey 61f324b5095078e8dee7879162d2657a
#define WechatAppkey @"wx10f6159570b590fb"
#define WechatSecret @"ae664c3b2c8d64db73bda28130f8f205"
#define MyredirectUri @"https://github.com/bairdweng"
#define QQAppID @"1105810090" //16进制 41E6A077
#define QQappSecret @"lRgWi9XP8wfNyzTZ"
#define XggUrl @"http://xggserve.com/xgg"
#define XGGplaceholderImage [UIImage imageNamed:@"defaultface"]
#import "WeiboSDK.h"
#import "XggNetworking.h"
#import "PublicParameters.h"
#import "DateTools.h"
#import "IQKeyboardManager.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIViewController+extension.h"
#import "UIColor+extension.h"
#import "UserbaseModel.h"
#import "XggNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "KwPicturestochooseManage.h"
//颜色
#define DEFAULTTITLECOLOE  [UIColor colorWithHexString:@"454648"]
#define DEFAULCONTENTCOLOR [UIColor colorWithHexString:@"a2a2a3"]
#define NAVIGARIONBLACKCOLOR [UIColor colorWithHexString:@"233244"]
#define NAVIGARIONBTITLECOLOR [UIColor whiteColor]
#define XGGBLCAKGROUNDCOLOR [UIColor colorWithHexString:@"f2f2f3"]
#define XGGLINEBLCAKGROUNDCOLOR [UIColor colorWithHexString:@"e3e3e3"]
#define MYHOST @"http://xggserve.com"
#endif /* XGGHeader_h */
