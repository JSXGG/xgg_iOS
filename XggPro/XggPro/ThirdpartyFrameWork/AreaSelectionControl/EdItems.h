//
//  EdItems.h
//  KinWind
//
//  Created by Baird-weng on 16/6/16.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EdItems : NSObject
@property(nonatomic,strong)NSString *ItemTitle;
@property(nonatomic,strong)NSString *ItemContent;
@property(nonatomic,strong)NSString *ItemKey;
@property(nonatomic,assign)BOOL isEditor;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,assign)CGFloat titleSize;
//原来的内容,地区跟真实姓名需要用到，真实姓名可以用|分开。
@property(nonatomic,strong)NSString *originalContent;
@end
