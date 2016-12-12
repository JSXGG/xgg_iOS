//
//  addUserItem.h
//  XggPro
//
//  Created by Baird-weng on 2016/11/1.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMaddUserItem : NSObject
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)NSString *en_title;
@property(nonatomic,strong)NSString *Content;

//关系。由于使用英文，所以不能直接获取title。
@property(nonatomic,strong)NSString *relationText;

@end
