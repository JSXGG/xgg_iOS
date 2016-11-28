//
//  LoginfoViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/21.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "LoginfoViewController.h"
#import "XGGHeader.h"
@interface LoginfoViewController ()
@end
@implementation LoginfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//微信登录
- (IBAction)ClickOntheLoginOfWeixin:(id)sender {
    __weak typeof(self)WeakSelf = self;
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       [WeakSelf bindAuthLoginOfType:2 WithUser:user];
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
}
- (IBAction)ClickOntheLoginOfQQ:(id)sender{
    __weak typeof(self)WeakSelf = self;
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       [WeakSelf bindAuthLoginOfType:1 WithUser:user];
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
}
//微博登录
- (IBAction)ClickOntheLoginOfWeibo:(id)sender{
    __weak typeof(self)WeakSelf = self;
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                        [WeakSelf bindAuthLoginOfType:0 WithUser:user];
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    if (state == SSDKResponseStateSuccess){
                                        
                                    }
                                    
                                }];
}
-(void)bindAuthLoginOfType:(int)TypeIndex WithUser:(SSDKUser *)user{
    NSString *type = @"";
    switch (TypeIndex) {
        case 0:{
            type = @"weibo";
        }
            break;
        case 1:{
            type = @"qq";
        }
            break;
        case 2:{
            type = @"weixin";
        }
            break;
        default:
            break;
    }
    NSString *userID = user.uid;
    if (userID.length == 0) {
        [self SetShowMessageInWindow:@"用户信息不存在"];
        return;
    }
    [self setShowLoadingInWindow:@"验证中"];
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/login",XggUrl];
    NSMutableDictionary *Params = [[NSMutableDictionary alloc]init];
    [Params setObject:[PublicParameters sharedManager].GetToken forKey:@"token"];
    [Params setObject:userID forKey:@"onlytoken"];
    [Params setObject:type forKey:@"acctype"];
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        NSString *error = [dic objectForKey:@"error"];
        if ([error isEqualToString:@"用户不存在,请注册"]) {
            [WeakSelf regisThirpartyWithSSDKUser:user withAcctype:type];
        }
        else{
            [WeakSelf processingErrorMessage:dic];
        }
        int result = [[dic objectForKey:@"result"]intValue];
        if (result == 1) {
            [WeakSelf LoginSuecssful:dic WithSSDKUser:user];
        }
    } WithFailurBlock:^(NSError *error){
        [WeakSelf networkAnomalies];
    }];
}
//注册
-(void)regisThirpartyWithSSDKUser:(SSDKUser *)user withAcctype:(NSString *)acctype{
    __weak typeof(self)WeakSelf = self;
    NSString *userID = user.uid;
    NSString *URL = [NSString stringWithFormat:@"%@/register",XggUrl];
    NSMutableDictionary *Params = [[NSMutableDictionary alloc]init];
    [Params setObject:[PublicParameters sharedManager].GetToken forKey:@"token"];
    [Params setObject:userID forKey:@"onlytoken"];
    [Params setObject:acctype forKey:@"acctype"];
    if (user.nickname) {
        [Params setObject:user.nickname forKey:@"usrname"];
    }
    if (user.gender == SSDKGenderMale) {
        [Params setObject:@"1" forKey:@"gender"];
    }
    else{
        [Params setObject:@"0" forKey:@"gender"];
    }
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        [WeakSelf processingErrorMessage:dic];
        int result = [dic[@"result"]intValue];
        if (result == 1){
            [WeakSelf LoginSuecssful:dic WithSSDKUser:user];
        }
    } WithFailurBlock:^(NSError *error){
        [WeakSelf networkAnomalies];
    }];
}
-(void)LoginSuecssful:(NSDictionary *)dataDic WithSSDKUser:(SSDKUser *)user{
    [self SetShowMessageInWindow:@"登录成功"];
    UserbaseModel *baseModel = [UserbaseModel findByPK:1];
    if (!baseModel) {
        baseModel = [[UserbaseModel alloc]init];
    }
    baseModel.uid = dataDic[@"uid"];
    baseModel.userToken = dataDic[@"usertoken"];
    baseModel.useName = user.nickname;
    baseModel.face = user.icon;
    if (user.gender == SSDKGenderMale) {
        baseModel.gender = @"1";
    }
    else{
        baseModel.gender = @"0";
    }
    [baseModel saveOrUpdate];
    [self LoginVC];
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
