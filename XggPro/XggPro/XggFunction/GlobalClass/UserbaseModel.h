//
//  UserbaseModel.h
//  KinWind
//
//  Created by Baird-weng on 16/6/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBHelper.h"
@interface UserbaseModel : JKDBModel
@property(nonatomic,strong)NSString *userToken;
@property(nonatomic,strong)NSString *TimeOut;//超时时间
@property(nonatomic,strong)NSString *useName;
@property(nonatomic,strong)NSString *pwd;
@property(nonatomic,strong)NSString *face;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *gender;
@end
