//
//  birthdayTableViewCell.m
//  birthdayDemo
//
//  Created by zs on 16/12/7.
//  Copyright © 2016年 zs. All rights reserved.
//

#import "birthdayTableViewCell.h"

@implementation birthdayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.HeadportraitImage.layer.masksToBounds=YES;
    self.HeadportraitImage.layer.cornerRadius=8;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
