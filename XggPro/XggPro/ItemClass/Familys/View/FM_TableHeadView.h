//
//  TableHeadView.h
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGGHeader.h"
#import "userItem.h"

typedef void(^ClickOntheCellRsult)();
@interface FM_TableHeadView : UIView
@property(nonatomic,strong)userItem *item;
-(void)GetEventResult:(ClickOntheCellRsult)resultBlock;
@end
