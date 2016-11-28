//
//  userItem.h
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XGGHeader.h"
@interface userItem : JKDBModel
//谁的家庭用户。
@property(nonatomic,assign)NSInteger Mainuid;

@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,strong)NSString *account;
@property(nonatomic,strong)NSString *acctype;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *relation;
@property(nonatomic,strong)NSString *face;
@property(nonatomic,assign)NSInteger gender;
@property(nonatomic,assign)NSInteger manageuid;
@property(nonatomic,strong)NSString *onlytoken;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,assign)NSInteger isregister;
@property(nonatomic,assign)NSInteger mtime;
@property(nonatomic,strong)NSString *usrname;
@property(nonatomic,strong)NSString *firstname;
@property(nonatomic,strong)NSString *lastname;
@property(nonatomic,strong)NSString *hometown;
@property(nonatomic,strong)NSString *livecity;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *wexin;
@property(nonatomic,strong)NSString *professional;
@property(nonatomic,strong)NSString *actualbirthday;
@property(nonatomic,strong)NSString *lunarbirthday;
@property(nonatomic,strong)NSString *introduction;
+(userItem *)getuserItemWithuid:(NSString *)uid;
@end
