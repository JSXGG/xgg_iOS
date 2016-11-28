//
//  areaSelectionView.m
//  KinWind
//
//  Created by Baird-weng on 16/6/17.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "areaSelectionView.h"
#import "areamodel.h"
#import "areaItem.h"
#import "XGGHeader.h"
@interface areaSelectionView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)NSMutableArray *componen1;
@property(nonatomic,strong)NSMutableArray *componen2;
@property(nonatomic,strong)NSMutableArray *componen3;
@property(nonatomic,strong)FMDatabase *database;

@property(nonatomic,strong)NSArray *CurrentSelct;
@end
@implementation areaSelectionView

-(void)setItemsmodel:(EdItems *)itemsmodel{
    _itemsmodel = itemsmodel;
    //刷新当前选择的地区
    [self reloadCurrentSelectlevel1];
}
-(void)reloadCurrentSelectlevel1{
    NSString *CurrentSelect = _itemsmodel.ItemContent;
    if (CurrentSelect.length>0) {
        self.CurrentSelct = [CurrentSelect componentsSeparatedByString:@" "];
        if (self.componen1.count>0){
            for (int i = 0; i<[self.componen1 count]; i++) {
                areaItem *item = self.componen1[i];
                if ([item.REGION_NAME isEqualToString:self.CurrentSelct[0]]) {
                    [self.pickerView selectRow:i inComponent:0 animated:NO];
                    self.componen2 = [self executeQuery:item.REGION_CODE];
                    if (self.CurrentSelct.count>=2){
                        [self reloadCurrentSelectlevel2];
                    }
                    if ([self isDirectcontrolledmunicipality:item.REGION_NAME]) {
                        self.componen3 = nil;
                    }
                }
            }
        }
    }
    [self reloadmodelItem];
}
-(void)reloadCurrentSelectlevel2{
    NSString *Temple = self.CurrentSelct[1];
    for (int i = 0; i<[self.componen2 count]; i++) {
        areaItem *item2 = self.componen2[i];
        if ([item2.REGION_NAME isEqualToString:Temple]){
            [self.pickerView selectRow:i inComponent:1 animated:YES];
            if (self.CurrentSelct.count>=3){
                self.componen3 = [self executeQuery:item2.REGION_CODE];
                [self reloadCurrentSelectlevel3];
            }
        }
    }
    [self reloadmodelItem];

}
-(void)reloadCurrentSelectlevel3{
    NSString *Temple = self.CurrentSelct[2];
    for (int i = 0; i<[self.componen3 count]; i++) {
        areaItem *item = self.componen3[i];
        if ([item.REGION_NAME isEqualToString:Temple]) {
            [self.pickerView selectRow:i inComponent:2 animated:YES];
        }
    }
    [self reloadmodelItem];
}
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
        UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, Height)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:pickerView];
        self.areamodel = [[areamodel alloc]init];
        [UIView animateWithDuration:0.3 animations:^{
            pickerView.frame = CGRectMake(0, ScreenHeight-Height, ScreenWidth, Height);
        }];
        if (self.database == nil) {
            NSString *paths = [[NSBundle mainBundle]pathForAuxiliaryExecutable:@"Region.sqlite"];
            self.database = [FMDatabase databaseWithPath:paths];
            [self.database open];
        }
        self.componen1 = [self executeQuery:@"0"];
        self.pickerView = pickerView;
        [self reloadSelectRow:0 inComponent:0];
        [self executeQuery:@"0"];
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:{
            return [self.componen1 count];
        }
            break;
        case 1:{
            return [self.componen2 count];
        }
            break;
        case 2:{
            return [self.componen3 count];
        }
            break;
        default:
            return 0;
            break;
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        NSString *temple = @"";
        switch (component) {
            case 0:{
                areaItem *Item = self.componen1[row];
                temple = Item.REGION_NAME;
            }
                break;
            case 1:{
                areaItem *Item = self.componen2[row];
                temple = Item.REGION_NAME;
            }
                break;
            case 2:{
                areaItem *Item = self.componen3[row];
                temple = Item.REGION_NAME;
            }
                break;
            default:
                break;
        }
        pickerLabel.textAlignment = 1;
        pickerLabel.font = [UIFont systemFontOfSize:14];
        pickerLabel.text = temple;
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self reloadSelectRow:row inComponent:component];
}
-(void)reloadSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:{
           areaItem *Item = self.componen1[row];
            self.componen2 = [self executeQuery:Item.REGION_CODE];
            if (self.componen2.count>0) {
                [self.pickerView reloadComponent:1];
                [self.pickerView selectRow:0 inComponent:1 animated:YES];
                areaItem *Item2 = self.componen2[0];
                self.componen3 = [self executeQuery:Item2.REGION_CODE];
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:YES];
            }
            
            if ([self isDirectcontrolledmunicipality:Item.REGION_NAME]) {
                self.componen3 = [[NSMutableArray alloc]init];
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:YES];
            }
        }
            break;
        case 1:{
            NSInteger index = [self.pickerView selectedRowInComponent:0];
            areaItem *Item1 = self.componen1[index];
            if ([self isDirectcontrolledmunicipality:Item1.REGION_NAME]) {
                self.componen3 = [[NSMutableArray alloc]init];
            }
            else{
                if (self.componen2.count>0&&row<=self.componen2.count-1){
                    areaItem *Item2 = self.componen2[row];
                    self.componen3 = [self executeQuery:Item2.REGION_CODE];
                    [self.pickerView reloadComponent:2];
                    if (self.componen3.count>0) {
                        [self.pickerView selectRow:0 inComponent:2 animated:YES];
                    }
                }
            }
        }
            break;
        default:
            break;
    }
    [self reloadmodelItem];
}

-(BOOL)isDirectcontrolledmunicipality:(NSString *)String{
    if ([String isEqualToString:@"北京市"]||[String isEqualToString:@"上海市"]||[String isEqualToString:@"天津市"]||[String isEqualToString:@"重庆市"]){
        return YES;
    }
    return NO;
}
-(NSMutableArray *)executeQuery:(NSString *)key{
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM REGION WHERE PARENT_CODE = '%@'",key];
    FMResultSet *re = [self.database executeQuery:SQL];
    NSMutableArray *TempleArray = [[NSMutableArray alloc]init];
    while ([re next]) {
        areaItem *model = [areaItem mj_objectWithKeyValues:[re resultDictionary]];
        [TempleArray addObject:model];
    }
    return TempleArray;
}
-(void)ClickOntheTap{
    self.hidden = YES;
}
-(void)reloadmodelItem{    
    NSMutableString *mutableString = [[NSMutableString alloc]init];
    NSMutableString *mutableString2 = [[NSMutableString alloc]init];
    NSInteger index1 = [self.pickerView selectedRowInComponent:0];
    self.areamodel.provinceItem = self.componen1[index1];
    [mutableString appendString:[NSString stringWithFormat:@"0|%@",self.areamodel.provinceItem.REGION_ID]];
    [mutableString2 appendString:[NSString stringWithFormat:@"%@",self.areamodel.provinceItem.REGION_NAME]];
    if (self.componen2.count>0){
        NSInteger index2 = [self.pickerView selectedRowInComponent:1];
        self.areamodel.cityItem = self.componen2[index2];
        [mutableString appendString:[NSString stringWithFormat:@"|%@",self.areamodel.cityItem.REGION_ID]];
        [mutableString2 appendString:[NSString stringWithFormat:@" %@",self.areamodel.cityItem.REGION_NAME]];

    }
    if (self.componen3.count>0) {
        NSInteger index3 = [self.pickerView selectedRowInComponent:2];
        self.areamodel.areaItem = self.componen3[index3];
        [mutableString appendString:[NSString stringWithFormat:@"|%@",self.areamodel.areaItem.REGION_ID]];
        [mutableString2 appendString:[NSString stringWithFormat:@" %@",self.areamodel.areaItem.REGION_NAME]];
    }
    self.itemsmodel.originalContent = mutableString;
    self.itemsmodel.ItemContent = mutableString2;
}
@end
