//
//  KWareaManageVC.m
//  KinWind
//
//  Created by Baird-weng on 16/6/17.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "KWareaManageVC.h"
#import "areaSelectionView.h"
#import "KwdatePickView.h"
#import "XGGHeader.h"
@interface KWareaManageVC ()
@property(nonatomic,weak)areaSelectionView *areaView;
@property(nonatomic,weak)KwdatePickView *datapickerView;
@property(nonatomic,strong)result resultblock;

@property(nonatomic,strong)resultdate resultdate;
@end
@implementation KWareaManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    
    
    // Do any additional setup after loading the view.
}
-(void)SetEdItems:(EdItems *)Items withResultBlock:(result)block{
    
}
-(void)AreaManage:(id)Target withEdItems:(EdItems *)Items withResultBlock:(result)block{
    
    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.view];
    [Target addChildViewController:self];
    
    areaSelectionView *View = [[areaSelectionView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:View];
    self.areaView = View;
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickOntheTapformSelectionView)];
    [self.view  addGestureRecognizer:Tap];
    self.resultblock = block;
    self.areaView.itemsmodel = Items;
}
-(void)KwdatePickCurrentTarget:(id)Target withDate:(NSDate *)date withresultDate:(resultdate)result{    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.view];
    [Target addChildViewController:self];
    self.resultdate = result;
    
    
    KwdatePickView *View = [[KwdatePickView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:View];
    self.datapickerView = View;
    [self.datapickerView.DatePicker setDate:date animated:YES];
    [self.datapickerView.leftBtn addTarget:self action:@selector(ClickOntheTapformKwdatePickView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.datapickerView.RightBtn addTarget:self action:@selector(ClickOntheEnter) forControlEvents:UIControlEventTouchUpInside];

    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickOntheTapformKwdatePickView)];
    [self.view  addGestureRecognizer:Tap];
}
-(void)ClickOntheTapformSelectionView{
    self.resultblock(self.areaView.itemsmodel);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.areaView.pickerView.frame;
        rect.origin.y = ScreenHeight;
        self.areaView.pickerView.frame = rect;
    }completion:^(BOOL finished) {
        [self.presentedViewController removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}
-(void)ClickOntheTapformKwdatePickView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.datapickerView.backgroundView.frame;
        rect.origin.y = ScreenHeight;
       self.datapickerView.backgroundView.frame = rect;
    }completion:^(BOOL finished) {
        [self.presentedViewController removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}
-(void)ClickOntheEnter{
    [self ClickOntheTapformKwdatePickView];
    if (self.resultdate) {
        self.resultdate(self.datapickerView.DatePicker.date);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
