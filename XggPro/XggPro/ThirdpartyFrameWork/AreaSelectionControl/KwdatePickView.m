//
//  KwdatePickView.m
//  KinWind
//
//  Created by Baird-weng on 16/6/23.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "KwdatePickView.h"
#import "XGGHeader.h"
@implementation KwdatePickView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        UIView *blackView = [[UIView alloc]initWithFrame:self.bounds];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            blackView.alpha = 0.5;
        }];
        [self addSubview:blackView];
        
        CGFloat Height = 250;
        UIView *WitebackgroindView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, Height)];
        WitebackgroindView.backgroundColor = [UIColor whiteColor];
        [self addSubview:WitebackgroindView];
        self.backgroundView = WitebackgroindView;
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn setTitleColor:NAVIGARIONBLACKCOLOR forState:UIControlStateNormal];
        [WitebackgroindView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.width.equalTo(@60);
            make.height.equalTo(@40);
            make.top.equalTo(WitebackgroindView);
        }];
        self.leftBtn = leftBtn;
        UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [RightBtn setTitle:@"确定" forState:UIControlStateNormal];
        RightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        RightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [RightBtn setTitleColor:NAVIGARIONBLACKCOLOR forState:UIControlStateNormal];
        [WitebackgroindView addSubview:RightBtn];
        [RightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-5));
            make.width.height.top.equalTo(leftBtn);
        }];
        self.RightBtn = RightBtn;
        CGFloat PickHeight = Height-40;
        UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, PickHeight)];
        picker.backgroundColor = [UIColor whiteColor];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.maximumDate = [NSDate date];
        [WitebackgroindView addSubview:picker];
        self.DatePicker = picker;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.frame = CGRectMake(0, ScreenHeight-Height, ScreenWidth, Height);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
