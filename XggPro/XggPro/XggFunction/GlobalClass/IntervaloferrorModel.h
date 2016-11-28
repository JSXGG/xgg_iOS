//
//  IntervaloferrorModel.h
//  KinWind
//
//  Created by Baird-weng on 16/6/14.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "JKDBModel.h"

@interface IntervaloferrorModel : JKDBModel
//是否要显示设备以及被踢。
@property(nonatomic,assign)BOOL iscanperform;

//上次显示网络异常的时间。间隔不能超过10s。
@property(nonatomic,assign)double networkErrorlastTime;
@end
