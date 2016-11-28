//
//  KwdatePickView.h
//  KinWind
//
//  Created by Baird-weng on 16/6/23.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KwdatePickView : UIView
@property(nonatomic,weak)UIView *backgroundView;
@property(nonatomic,weak)UIDatePicker *DatePicker;
@property(nonatomic,weak)UIButton *leftBtn;
@property(nonatomic,weak)UIButton *RightBtn;
@end
