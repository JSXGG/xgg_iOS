//
//  xggdataeditor.h
//  XggPro
//
//  Created by Baird-weng on 2016/11/15.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^getEditorResult)();
@interface FMXggdataeditor : UIViewController

-(void)SetdataeditorWithUid:(NSString *)uid WithBlock:(getEditorResult)result;
@end
