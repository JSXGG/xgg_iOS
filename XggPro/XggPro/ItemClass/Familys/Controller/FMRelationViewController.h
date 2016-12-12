//
//  RelationViewController.h
//  XggPro
//
//  Created by Baird-weng on 2016/11/5.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMRelationItem.h"
typedef void(^SelectrelationResult)(FMRelationItem *item);
@interface FMRelationViewController : UIViewController
-(void)GetrelationSelect:(SelectrelationResult)result;
@end
