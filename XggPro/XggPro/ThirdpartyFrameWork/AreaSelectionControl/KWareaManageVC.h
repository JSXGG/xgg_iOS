//
//  KWareaManageVC.h
//  KinWind
//
//  Created by Baird-weng on 16/6/17.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EdItems.h"
#import "areamodel.h"
@interface KWareaManageVC : UIViewController
typedef void (^result)(EdItems *newItems);
typedef void (^resultdate)(NSDate *currentdate);

-(void)AreaManage:(id)Target withEdItems:(EdItems *)Items withResultBlock:(result)block;


-(void)KwdatePickCurrentTarget:(id)Target withDate:(NSDate *)date withresultDate:(resultdate)result;

@property(nonatomic,strong)EdItems *Items;
@end
