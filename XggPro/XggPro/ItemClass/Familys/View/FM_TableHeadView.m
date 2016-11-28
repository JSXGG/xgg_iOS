//
//  TableHeadView.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "FM_TableHeadView.h"
@interface FM_TableHeadView()
@property(nonatomic,strong)UIImageView *faceImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *birthday;
@property(nonatomic,strong)ClickOntheCellRsult resultBlock;

@end
@implementation FM_TableHeadView
-(void)GetEventResult:(ClickOntheCellRsult)resultBlock{
    self.resultBlock = resultBlock;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
        self.backgroundColor = XGGBLCAKGROUNDCOLOR;;
        
        UIView *backgroundView = UIView.new;
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backgroundView];
        
        CGFloat headView_height = self.frame.size.height-20;
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(@10);
            make.left.right.equalTo(@0);
            make.height.equalTo(@(headView_height));
        }];
        
        UIImageView *imageView = UIImageView.new;
        [backgroundView addSubview:imageView];
        __weak typeof(self)WeakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(backgroundView);
            make.width.height.equalTo(@50);
        }];
        imageView.layer.cornerRadius = 25;
        imageView.layer.masksToBounds = YES;
        self.faceImageView = imageView;
        UILabel *nameLabel = UILabel.new;
        nameLabel.textAlignment = 0;
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.textColor = DEFAULTTITLECOLOE;
        [backgroundView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.right.equalTo(WeakSelf.mas_right).offset(-5);
            make.top.equalTo(WeakSelf.faceImageView);
        }];
        self.nameLabel = nameLabel;
        
        UILabel *birthday = UILabel.new;
        birthday.textAlignment = 0;
        birthday.font = [UIFont systemFontOfSize:12];
        birthday.textColor = DEFAULTTITLECOLOE;
        [backgroundView addSubview:birthday];
        [birthday mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.right.equalTo(WeakSelf.mas_right).offset(-5);
            make.bottom.equalTo(imageView);
        }];
        self.birthday = birthday;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickOntheTap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
//个人。
-(void)ClickOntheTap{
    if (self.resultBlock) {
        self.resultBlock();
    }
}
-(void)setItem:(userItem *)item{
    _item = item;
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:item.face] placeholderImage:XGGplaceholderImage];
    if (item.usrname.length>0) {
        self.nameLabel.text = item.usrname;
    }
    if (item.birthday.length>0) {
        self.birthday.text = [NSString stringWithFormat:@"生日:%@",item.birthday];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
