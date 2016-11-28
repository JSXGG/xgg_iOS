//
//  XggSettingViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/22.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggSettingViewController.h"
#import "XGGHeader.h"
@interface XggSettingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *UserFaceImageView;
@property (weak, nonatomic) IBOutlet UILabel *NicNameLabel;

@end

@implementation XggSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    UserbaseModel *model = [UserbaseModel findByPK:1];
    [self.UserFaceImageView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:XGGplaceholderImage];
    self.NicNameLabel.text = model.useName;
    // Do any additional setup after loading the view.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1){
        UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"确定退出?" message:nil preferredStyle:UIAlertControllerStyleAlert];
      
        UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        __weak typeof(self)WeakSelf = self;
        UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
            [WeakSelf setShowLoadingInWindow:@"正在注销"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [WeakSelf setShowLoadingdismiss];
                [WeakSelf LoginOutVC];
            });
        }];
        [AlertController addAction:action_1];
        [AlertController addAction:action_2];
        [self.navigationController presentViewController:AlertController animated:YES completion:nil];
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
