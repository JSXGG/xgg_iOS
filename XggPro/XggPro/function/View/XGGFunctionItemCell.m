//
//  FunctionItemCell.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XGGFunctionItemCell.h"
#import "XGGHeader.h"
@interface XGGFunctionItemCell()
@property(nonatomic,weak)UIImageView *iconImageView;
@property(nonatomic,weak)UILabel *itemLabel;
@end

@implementation XGGFunctionItemCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageView = UIImageView.new;
        [self.contentView addSubview:imageView];
        __weak typeof(self)WeakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(WeakSelf);
            make.width.height.equalTo(@44);
        }];
      
        self.iconImageView = imageView;
        UILabel *titleLabel = UILabel.new;
        titleLabel.textAlignment = 0;
        titleLabel.textColor = DEFAULTTITLECOLOE;
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.centerY.equalTo(WeakSelf);
            make.right.equalTo(WeakSelf.contentView.mas_right).offset(-5);
        }];
        self.itemLabel = titleLabel;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setItem:(XGGFunctionItem *)item{
    _item = item;
    [self.iconImageView setImage:[UIImage imageNamed:item.itemIcon]];
    self.itemLabel.text = item.itemTitle;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
