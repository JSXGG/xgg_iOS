//
//  areaSelectionView.h
//  KinWind
//
//  Created by Baird-weng on 16/6/17.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "areamodel.h"
#import "EdItems.h"
@interface areaSelectionView : UIView
@property(nonatomic,strong)areamodel *areamodel;
@property(nonatomic,weak)UIPickerView *pickerView;
@property(nonatomic,strong)EdItems *itemsmodel;

@end
