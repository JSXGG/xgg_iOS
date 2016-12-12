//
//  TableHeadView.h
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGGHeader.h"
#import "FMUserItem.h"

typedef void(^ClickOntheCellRsult)();
@interface FMTableHeadView : UIView
@property(nonatomic,strong)FMUserItem *item;
-(void)GetEventResult:(ClickOntheCellRsult)resultBlock;
@end
