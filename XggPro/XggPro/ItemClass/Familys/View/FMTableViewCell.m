//
//  XggFmTableViewCell.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "FMTableViewCell.h"
#import "XGGHeader.h"

@interface FMTableViewCell()
@property(nonatomic,strong)UIImageView *faceImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *birthday;
@property(nonatomic,strong)UILabel *relationLabel;
@end
@implementation FMTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){        
        __weak typeof(self)WeakSelf = self;
        //关系
        UILabel *relationLabel = UILabel.new;
        relationLabel.textAlignment = 2;
        relationLabel.font = [UIFont systemFontOfSize:12];
        relationLabel.textColor = DEFAULTTITLECOLOE;
        [self.contentView addSubview:relationLabel];
        [relationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(WeakSelf.contentView.mas_right).offset(-5);
            make.centerY.equalTo(WeakSelf.contentView);
            make.width.equalTo(@100);
        }];
        self.relationLabel = relationLabel;
        //头像
        UIImageView *imageView = UIImageView.new;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(WeakSelf);
            make.width.height.equalTo(@44);
        }];
        imageView.layer.cornerRadius = 22;
        imageView.layer.masksToBounds = YES;
        self.faceImageView = imageView;
        
        
        
        //名字
        UILabel *nameLabel = UILabel.new;
        nameLabel.textAlignment = 0;
        nameLabel.textColor = DEFAULTTITLECOLOE;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.right.equalTo(WeakSelf.relationLabel.mas_left).offset(-5);
            make.top.equalTo(WeakSelf.faceImageView);
        }];
        self.nameLabel = nameLabel;
        //生日
        UILabel *birthday = UILabel.new;
        birthday.textAlignment = 0;
        birthday.font = [UIFont systemFontOfSize:12];
        birthday.textColor = DEFAULTTITLECOLOE;
        [self.contentView addSubview:birthday];
        [birthday mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.right.equalTo(WeakSelf.relationLabel.mas_left).offset(-5);
            make.bottom.equalTo(imageView);
        }];
        self.birthday = birthday;
    }
    return self;
}
-(void)setItem:(FMUserItem *)item{
    _item = item;
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:item.face] placeholderImage:XGGplaceholderImage];
    self.nameLabel.text = item.usrname;
    self.birthday.text = [NSString stringWithFormat:@"生日：%@",item.birthday];
    self.relationLabel.text = [NSString stringWithFormat:@"关系：%@",item.relation];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
