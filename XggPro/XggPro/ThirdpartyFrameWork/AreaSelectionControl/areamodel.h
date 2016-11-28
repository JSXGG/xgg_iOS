//
//  areamodel.h
//  KinWind
//
//  Created by Baird-weng on 16/6/17.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "areaItem.h"
@interface areamodel : NSObject
@property(nonatomic,strong)areaItem *provinceItem;
@property(nonatomic,strong)areaItem *cityItem;
@property(nonatomic,strong)areaItem *areaItem;
@end
