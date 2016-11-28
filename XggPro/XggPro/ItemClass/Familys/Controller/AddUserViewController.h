//
//  AddUserViewController.h
//  XggPro
//
//  Created by Baird-weng on 2016/11/1.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^addresultSuccess)();

@interface AddUserViewController : UIViewController
-(void)addUserWithUid:(NSString *)uid withresultSuccess:(addresultSuccess)Successblock;
@end
