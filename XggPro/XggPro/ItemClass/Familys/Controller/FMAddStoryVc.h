//
//  XggaddStoryVc.h
//  XggPro
//
//  Created by Baird-weng on 2016/11/16.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^getaddResult)();

@interface FMAddStoryVc : UIViewController
-(void)SetStoryWithUid:(NSString *)uid WithBlock:(getaddResult)result;

@end
