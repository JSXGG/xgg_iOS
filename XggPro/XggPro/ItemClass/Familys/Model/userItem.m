//
//  userItem.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "userItem.h"

@implementation userItem
-(NSString *)face{
    if (_face.length==0) {
        _face = @"";
    }
    return _face;
}

-(NSString *)usrname{
    if (self.firstname.length>0&&self.lastname.length>0) {
        _usrname = [NSString stringWithFormat:@"%@%@",self.firstname,self.lastname];
    }
    if (_usrname.length==0){
       return @"匿名";
    }
    return _usrname;
}
-(NSString *)birthday{
    if (_birthday.length == 0){
        _birthday = @"未填写";
    }
    return _birthday;
}
-(NSString *)relation{
    if ([_relation isEqualToString:@"brother"]) {
        return @"兄弟";
    }
    else if ([_relation isEqualToString:@"sister"]){
        return @"姐妹";
    }
    else if ([_relation isEqualToString:@"husband"]){
        return @"丈夫";
    }
    else if ([_relation isEqualToString:@"wife"]){
        return @"妻子";
    }
    else if ([_relation isEqualToString:@"son"]){
        return @"儿子";
    }
    else if ([_relation isEqualToString:@"daughter"]){
        return @"女儿";
    }
    else if ([_relation isEqualToString:@"father"]){
        return @"父亲";
    }
    else if ([_relation isEqualToString:@"mother"]){
        return @"母亲";
    }
    else if ([_relation isEqualToString:@"self"]){
        return @"我";
    }
    else{
        return _relation;
    }
}
+(userItem *)getuserItemWithuid:(NSString *)uid{
   return  [self findFirstByCriteria:[NSString stringWithFormat:@"where uid = '%@'",uid]];
}
@end
