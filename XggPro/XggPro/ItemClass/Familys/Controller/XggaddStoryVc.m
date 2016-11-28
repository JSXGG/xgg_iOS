//
//  XggaddStoryVc.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/16.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggaddStoryVc.h"
#import "FRDLivelyButton.h"
#import "XGGHeader.h"
@interface XggaddStoryVc (){
    NSString *_uid;
    getaddResult _result;
}
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@end

@implementation XggaddStoryVc
-(void)SetStoryWithUid:(NSString *)uid WithBlock:(getaddResult)result{
    _uid = uid;
    _result = result;
}
-(void)setLeftBtn{
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [button setOptions:@{ kFRDLivelyButtonLineWidth: @(1.5f),
                          kFRDLivelyButtonHighlightScale:@(1.5),
                          kFRDLivelyButtonHighlightedColor:[UIColor orangeColor],
                          kFRDLivelyButtonColor: [UIColor whiteColor]
                          }];
    [button setStyle:kFRDLivelyButtonStyleClose animated:NO];
    [button addTarget:self action:@selector(ClickOntheback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtn];
    self.view.backgroundColor = XGGBLCAKGROUNDCOLOR;
    self.title = @"故事编辑";
    [self setRightBarItemIcon:nil butItemTitle:@"保存" addTarget:self action:@selector(ClickOntheSave)];
    // Do any additional setup after loading the view from its nib.
}
-(void)ClickOntheSave{
    [self.TextView resignFirstResponder];
    if (self.TextView.text.length==0){
        [self setShowMessage:@"请输入文字"];
        return;
    }
    [self setShowLoadingInWindow:@"保存中"];
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/addthestory",XggUrl];
    NSMutableDictionary *Params = [[PublicParameters sharedManager]GetPublicParameters];
    [Params setObject:_uid forKey:@"otheruid"];
    [Params setObject:self.TextView.text forKey:@"content"];
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        [WeakSelf processingErrorMessage:dic];
        int result = [dic[@"result"]intValue];
        if (result == 1){
            if (_result) {
                _result();
            }
            [WeakSelf SetShowMessageInWindow:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [WeakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
        }
    } WithFailurBlock:^(NSError *error){
        [WeakSelf networkAnomalies];
    }];
    
    
}
-(void)ClickOntheback{
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"确定返回？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:Action1];
    [alertController addAction:Action2];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
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
