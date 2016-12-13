//
//  AddUserViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/1.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "FMAddUserViewController.h"
#import "XGGHeader.h"
#import "FMUserItem.h"
#import "FMaddUserInput.h"
#import "FRDLivelyButton.h"
#import "FMAdduserCell.h"
#import "FMAddUserInput.h"
#import "FMRelationViewController.h"
#import "KWareaManageVC.h"
@interface FMAddUserViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *TableView;
@property(nonatomic,strong)NSMutableArray *listItems;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)FMUserItem *MainUseritem;
@property(nonatomic,strong)addresultSuccess resultSuccess;
@end
@implementation FMAddUserViewController
-(void)addUserWithUid:(NSString *)uid withresultSuccess:(addresultSuccess)Successblock{
    self.uid = uid;
    self.resultSuccess = Successblock;
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
    self.view.backgroundColor = [UIColor whiteColor];  
    self.MainUseritem = [FMUserItem getuserItemWithuid:self.uid];
    self.title = [NSString stringWithFormat:@"添加%@的家人",self.MainUseritem.usrname];
    [self setLeftBtn];
    [self setRightBarItemIcon:nil butItemTitle:@"完成" addTarget:self action:@selector(ClickOnthefinish)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerNib:[UINib nibWithNibName:@"adduserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"adduserCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    __weak typeof(self)WeakSelf = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(WeakSelf.view);
    }];
    self.TableView = tableView;
    //关系
    self.listItems = [[NSMutableArray alloc]init];
    NSArray *Array = @[@"关系",@"姓",@"名",@"生日"];
    for (int i = 0; i<[Array count]; i++){
        FMaddUserItem *item = [[FMaddUserItem alloc]init];
        item.Title = Array[i];
        if (i == 1) {
            item.Content = [self GetrecomandfirstName:@"self"];
        }
        [self.listItems addObject:item];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.TableView reloadData];
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
//点击完成
-(void)ClickOnthefinish{
    if ([self.listItems count]==4) {
        FMaddUserItem *item1 = self.listItems[0];
        FMaddUserItem *item2 = self.listItems[1];
        FMaddUserItem *item3 = self.listItems[2];
        FMaddUserItem *item4 = self.listItems[3];
        if (item1.Content.length==0){
            [self SetShowMessageInWindow:@"请选择关系"];
            return;
        }
        else if (item2.Content.length == 0){
            [self SetShowMessageInWindow:@"请填写姓"];
            return;
        }
        else if (item3.Content.length == 0){
            [self SetShowMessageInWindow:@"请填写名"];
            return;
        }
        else if(item4.Content.length == 0){
            [self SetShowMessageInWindow:@"请填写生日"];
            return;
        }
        else{
            NSDictionary *parDic = @{@"relation":item1.relationText,
                                     @"firstname":item2.Content,
                                     @"lastname":item3.Content,
                                     @"birthday":item4.Content};
            [self addUserWithparameter:parDic];
        }
    }
    else{
        [self setShowLoadingInWindow:@"listItem错误"];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMAdduserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adduserCell" forIndexPath:indexPath];
    FMaddUserItem *item = self.listItems[indexPath.row];
    cell.TitleLabel.text = item.Title;
    cell.ContentLabel.text = item.Content;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listItems count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self)WeakSelf = self;
    if (indexPath.row == 0){
        FMRelationViewController *relationVC = [[FMRelationViewController alloc]init];
        [relationVC GetrelationSelect:^(FMRelationItem *item){
            FMaddUserItem *UserItem = WeakSelf.listItems[0];
            UserItem.Content = item.relation_ch;
            UserItem.relationText = item.relation_en;
            
            FMaddUserItem *fistnameItem = WeakSelf.listItems[1];
            fistnameItem.Content = [WeakSelf GetrecomandfirstName:item.relation_en];
            [WeakSelf.TableView reloadData];
        }];
        XggNavigationController *navigation = [[XggNavigationController alloc]initWithRootViewController:relationVC];
        [self presentViewController:navigation animated:YES completion:nil];
    }
    else if (indexPath.row == 3){
        FMaddUserItem *UserItem = WeakSelf.listItems[3];
        NSDate *recomanddate = [[NSDate date]dateBySubtractingYears:25];
        if (UserItem.Content.length>0) {
            recomanddate = [NSDate dateWithString:UserItem.Content formatString:@"yyyy-MM-dd" timeZone:[NSTimeZone systemTimeZone]];
        }
        [[KWareaManageVC alloc]KwdatePickCurrentTarget:self withDate:recomanddate withresultDate:^(NSDate *currentdate) {
            NSString *dataString = [currentdate formattedDateWithFormat:@"yyyy-MM-dd" timeZone:[NSTimeZone systemTimeZone]];
            UserItem.Content = dataString;
            [WeakSelf.TableView reloadData];
        }];
    }
    else{
        FMaddUserInput *userInput = [[FMaddUserInput alloc]init];
        userInput.item = self.listItems[indexPath.row];
        [self.navigationController pushViewController:userInput animated:YES];
    }
}
-(void)addUserWithparameter:(NSDictionary *)dic{
    [self setShowLoadingInWindow:@"正在添加"];
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/addusers",XggUrl];
    NSMutableDictionary *Params = [[PublicParameters sharedManager]GetPublicParameters];
    [Params setObject:self.uid forKey:@"foruid"];
    [Params setValuesForKeysWithDictionary:dic];
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        [WeakSelf processingErrorMessage:dic];
        int result = [dic[@"result"]intValue];
        if (result == 1){
            [WeakSelf SetShowMessageInWindow:@"添加成功"];
            if (WeakSelf.resultSuccess) {
                WeakSelf.resultSuccess();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [WeakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
        }
    } WithFailurBlock:^(NSError *error){
        [WeakSelf networkAnomalies];
    }];
}
/**
 根据关系获取推荐的姓。
 @param relation 关系
 @return 姓。
 */
-(NSString *)GetrecomandfirstName:(NSString *)relation{
    //添加妻子或者丈夫。不推荐姓。
    if ([relation isEqualToString:@"wife"]||
        [relation isEqualToString:@"husband"]) {
        return @"";
    }
    //如果是女生,添加儿子或者女二的话，需要获取丈夫的姓。
    else if ((self.MainUseritem.gender == 0)&&
             ([relation isEqualToString:@"son"]||
              [relation isEqualToString:@"daughter"])
             ){
        NSArray *listItem = [FMUserItem findByCriteria:[NSString stringWithFormat:@"where Mainuid = '%@'",self.uid]];
        for (FMUserItem *userItem in listItem){
            if ([userItem.relation isEqualToString:@"丈夫"]) {
                return userItem.firstname;
            }
        }
        return self.MainUseritem.firstname;
    }
    return self.MainUseritem.firstname;
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
