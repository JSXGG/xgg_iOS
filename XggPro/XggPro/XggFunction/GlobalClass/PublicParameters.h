//
//  PublicParameters.h
//  KinWind
//
//  Created by Baird-weng on 16/6/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBHelper.h"
#import "UserbaseModel.h"
@interface PublicParameters : NSObject
+(instancetype)sharedManager;
/**
 *  获取token，登录注册的时候需要使用。
 *
 *  @return token
 */
-(NSString *)GetToken;
/**
 *  获取公共参数，请求所有的Api都需要带上这两个参数。userToken必须是登录之后才能有效。
 *
 *  @return userToken token
 */
-(NSMutableDictionary *)GetAccessTopublicparameters;
//设备型号
-(NSString *)iphoneType;
//判断是否已经登录
-(BOOL)isLogin;
/**
 获取公共参数
 */
-(NSMutableDictionary *)GetPublicParameters;

/**
   获取登录用户的uid;
 */
-(NSString *)GetuidOfmain;

@end
