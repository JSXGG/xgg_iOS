//
//  XggFmViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/24.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggFmViewController.h"
#import "XGGHeader.h"
#import "XggFmTableViewCell.h"
#import "FM_TableHeadView.h"
#import "AddUserViewController.h"
#import "UserdetailsViewController.h"
#import "Xggdataeditor.h"
#import "RelationShowViewController.h"
#define cellHeadView_height 85
@interface XggFmViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *TableView;
@property(nonatomic,strong)NSMutableArray *listItems;
@property(nonatomic,strong)NSMutableArray *relationShows;

@property(nonatomic,strong)userItem *mainItems;
@end
@implementation XggFmViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *TableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:TableView];
    __weak typeof(self)WeakSelf = self;
    [TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(WeakSelf.view);
    }];
    self.TableView = TableView;
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    [self.TableView setTableFooterView:[[UIView alloc]init]];
    [self.TableView registerClass:[XggFmTableViewCell class] forCellReuseIdentifier:@"XggFmTableViewCell"];
    if (!self.uid) {
        self.uid = [PublicParameters sharedManager].GetuidOfmain;
    }
    [self getfamilylist];
    [self reloadViewModel];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getfamilylist)];
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    self.TableView.mj_header = header;
    [self setRightBarItemIcon:@"navagation_more" butItemTitle:nil addTarget:self action:@selector(ClickOntheRight)];
    // Do any additional setup after loading the view.
}
-(void)ClickOntheRight{
    //如果是自己
    if ([self.uid isEqualToString:[PublicParameters sharedManager].GetuidOfmain]) {
        UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        __weak typeof(self)WeakSelf = self;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [WeakSelf enterthefunctionmodule:action.title];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"添加家人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [WeakSelf enterthefunctionmodule:action.title];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        }];
        [AlertController addAction:action1];
        [AlertController addAction:action2];
        [AlertController addAction:action3];
        [self.navigationController presentViewController:AlertController animated:YES completion:nil];
    }
    else{
        [self getRelationship];
    }
}
-(void)dealRelationData:(NSArray *)array{
    self.relationShows = [userItem mj_objectArrayWithKeyValuesArray:array];
    NSMutableArray *titles = [[NSMutableArray alloc]init];
    if (self.mainItems.isregister == 1){
        [titles addObject:@"查看关系链"];
    }
    else{
        [userItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"isregister":@"register"};
        }];
        BOOL iseditor = YES;
        for (int i = 0;i<[self.relationShows count]; i++) {
            userItem *item = self.relationShows[i];
            if (i>0&&item.isregister == 1) {
                iseditor = NO;
            }
        }
        if (iseditor){
            [titles addObject:@"编辑"];
            [titles addObject:@"添加家人"];
            [titles addObject:@"查看关系链"];
        }
        else{
            [titles addObject:@"查看关系链"];
        }
    }
    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self)WeakSelf = self;
    for (int i = 0; i<[titles count]; i++) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [WeakSelf enterthefunctionmodule:action.title];
        }];
        [AlertController addAction:action1];
    }
    UIAlertAction *action_cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertController addAction:action_cancle];
    [self.navigationController presentViewController:AlertController animated:YES completion:nil];
}

/**
 根据字段进入对应的功能模块
 @param title 字段
 */
-(void)enterthefunctionmodule:(NSString *)title{
    __weak typeof(self)WeakSelf = self;
    if ([title isEqualToString:@"编辑"]){
        Xggdataeditor *xggdataVC = [[Xggdataeditor alloc]init];
        [xggdataVC SetdataeditorWithUid:WeakSelf.uid WithBlock:^{
            [WeakSelf getfamilylist];
        }];
        XggNavigationController *navigation = [[XggNavigationController alloc]initWithRootViewController:xggdataVC];
        [WeakSelf presentViewController:navigation animated:YES completion:nil];
    }
    else if ([title isEqualToString:@"添加家人"]){
        AddUserViewController *addUser = [[AddUserViewController alloc]init];
        __weak typeof(self)WeakSelf = self;
        [addUser addUserWithUid:self.uid withresultSuccess:^{
            [WeakSelf getfamilylist];
        }];
        XggNavigationController *rootNavigation = [[XggNavigationController alloc]initWithRootViewController:addUser];
        [WeakSelf.navigationController presentViewController:rootNavigation animated:YES completion:nil];
    }
    else if ([title isEqualToString:@"查看关系链"]){
        RelationShowViewController *ShowViewVC = [[RelationShowViewController alloc]init];
        ShowViewVC.listItems = self.relationShows;
        [self.navigationController pushViewController:ShowViewVC animated:YES];
    }
    else{
        return;
    }
}
/**
 获取关系链的信息
 */
-(void)getRelationship{
    [self setShowLoadingInWindow:nil];
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/getRelationship",XggUrl];
    NSMutableDictionary *Params = [[PublicParameters sharedManager]GetPublicParameters];
    if (self.uid) {
        [Params setObject:self.uid forKey:@"uid"];
    }
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        [WeakSelf processingErrorMessage:dic];
        [WeakSelf.TableView.mj_header endRefreshing];
        int result = [dic[@"result"]intValue];
        if (result == 1){
            [WeakSelf setShowLoadingdismiss];
            [WeakSelf dealRelationData:dic[@"data"]];
        }
    } WithFailurBlock:^(NSError *error){
        [WeakSelf.TableView.mj_header endRefreshing];
        [WeakSelf networkAnomalies];
    }];
}

/**
   获取家庭用户。
 */
-(void)getfamilylist{
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/getfamilylist",XggUrl];
    NSMutableDictionary *Params = [[PublicParameters sharedManager]GetPublicParameters];
    if (self.uid) {
        [Params setObject:self.uid forKey:@"uid"];
    }
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        [WeakSelf processingErrorMessage:dic];
        [WeakSelf.TableView.mj_header endRefreshing];
        int result = [dic[@"result"]intValue];
        if (result == 1){
            [userItem deleteObjectsByCriteria:[NSString stringWithFormat:@"where Mainuid = '%@'",self.uid]];
            [userItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"isregister":@"register"};
            }];
            NSArray *data = dic[@"data"];
            for (int i = 0; i<[data count]; i++) {
                userItem *item  = [userItem mj_objectWithKeyValues:data[i]];
                item.Mainuid = [self.uid integerValue];
                [item save];
            }
            [self reloadViewModel];
        }
    } WithFailurBlock:^(NSError *error){
        [WeakSelf.TableView.mj_header endRefreshing];
        [WeakSelf networkAnomalies];
    }];
}
//刷新视图。
-(void)reloadViewModel{
    if (!self.listItems) {
        self.listItems = [[NSMutableArray alloc]init];
    }
    [self.listItems removeAllObjects];
    NSArray *listArray = [userItem findByCriteria:[NSString stringWithFormat:@"where Mainuid = '%@'",self.uid]];
    for (int i = 0; i<[listArray count]; i++) {
        userItem *item = listArray[i];
        if (item.uid == [self.uid integerValue]) {
            self.mainItems = item;
        }
        else{
            [self.listItems addObject:item];
        }
    }
    if (self.mainItems.usrname.length>0) {
        self.title = [NSString stringWithFormat:@"%@的家庭",self.mainItems.usrname];
    }
    [self.TableView reloadData];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FM_TableHeadView *TableHeadView = [[FM_TableHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, cellHeadView_height)];
    TableHeadView.item = self.mainItems;
    __weak typeof(self)WeakSelf = self;
    [TableHeadView GetEventResult:^{
        [WeakSelf pushDetailsInfoWithUid:WeakSelf.uid];
    }];
    return TableHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeadView_height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XggFmTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"XggFmTableViewCell" forIndexPath:indexPath];
    Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    Cell.item = self.listItems[indexPath.row];
    return Cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listItems count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    userItem *item = self.listItems[indexPath.row];
    if (item.uid != [self.uid intValue]){
        UIViewController *TempleVc = nil;
        for (UIViewController *VC in self.navigationController.viewControllers) {
            if ([VC isKindOfClass:[XggFmViewController class]]) {
                NSInteger uid = [[VC valueForKey:@"uid"]integerValue];
                if (uid == item.uid) {
                    TempleVc = VC;
                }
            }
        }
        if (TempleVc) {
            [self.navigationController popToViewController:TempleVc animated:YES];
        }
        else{
            XggFmViewController *FMVC = [[XggFmViewController alloc]init];
            FMVC.uid = [NSString stringWithFormat:@"%ld",(long)item.uid];
            [self.navigationController pushViewController:FMVC animated:YES];
        }
    }
}
/**
 进入个人详细信息
 @param uid 个人id。
 */
-(void)pushDetailsInfoWithUid:(NSString *)uid{
    UserdetailsViewController *UserdetailVC = [[UserdetailsViewController alloc]init];
    UserdetailVC.uid = uid;
    [self.navigationController pushViewController:UserdetailVC animated:YES];
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
