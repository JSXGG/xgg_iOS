//
//  PublicParameters.m
//  KinWind
//
//  Created by Baird-weng on 16/6/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//
#import "PublicParameters.h"
#define appId @"app51e43e370de9c24d176f64"
#define secret @"ffe3b9c50c113d695051baffe407c000"
#define getAccessTokenURL @"http://hvapi.kinwind.com/api/v2/getAccessToken"
#import <sys/utsname.h>
@implementation PublicParameters
+ (instancetype)sharedManager{
    static PublicParameters *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [self alloc];
    });
    return manager;
}
//生成签名
-(NSString *)GenerateTheSignature:(NSDictionary *)Dictionary{
    NSMutableString *tempStr = [[NSMutableString alloc]init];
    NSArray *keys = [Dictionary allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (int i=0; i<[sortedArray count]; i++){
        NSString *keyStr = sortedArray[i];
        NSString *Value = [Dictionary objectForKey:keyStr];
        [tempStr appendString:[NSString stringWithFormat:@"%@=%@",keyStr,Value]];
    }
    [tempStr appendString:secret];
    return tempStr;
}
-(NSString *)GetToken{
     return @"D82377E8-7F4E-929F-7AD5-858EDE572814";
}
-(NSString *)GetuserToken{
    UserbaseModel *model = [UserbaseModel findByPK:1];
    return model.userToken;
}
-(NSString *)GetuidOfmain{
    UserbaseModel *model = [UserbaseModel findByPK:1];
    return model.uid;
}

/**
  获取公共参数
 */
-(NSMutableDictionary *)GetPublicParameters{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    if ([self GetuserToken]) {
        [mutableDic setObject:[self GetuserToken] forKey:@"usertoken"];
    }
    [mutableDic setObject:[self GetToken] forKey:@"token"];
    return mutableDic;
}
-(BOOL)isLogin{
    UserbaseModel *model = [UserbaseModel findByPK:1];
    if (model.userToken.length>0){
        return YES;
    }
    return NO;
}
-(NSString *)iphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])return @"iPhone Simulator";
    return platform;
}
@end
