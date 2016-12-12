//
//  birthdayTableViewCell.h
//  birthdayDemo
//
//  Created by zs on 16/12/7.
//  Copyright © 2016年 zs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadportraitImage;
@property (weak, nonatomic) IBOutlet UILabel *Fromday;/*距离天数*/

@end
