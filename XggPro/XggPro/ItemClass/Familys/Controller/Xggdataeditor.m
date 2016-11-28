//
//  xggdataeditor.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/15.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "Xggdataeditor.h"
#import "FRDLivelyButton.h"
#import "userItem.h"
#import "XGGHeader.h"
#import "addUserItem.h"
#import "adduserCell.h"
#import "addUserInput.h"
#import "adduserfaceCell.h"
#import "KWareaManageVC.h"
@interface Xggdataeditor ()<UITableViewDelegate,UITableViewDataSource>{
    getEditorResult _EditorResult;
}
@property(nonatomic,strong)userItem *userItem;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSMutableArray *listItems;
@property(nonatomic,weak)UITableView *dataTableView;
@property(nonatomic,strong)UIImage *TempleImage;
@end

@implementation Xggdataeditor
-(void)SetdataeditorWithUid:(NSString *)uid WithBlock:(getEditorResult)result{
    self.uid = uid;
    _EditorResult = result;
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料编辑";
    [self setLeftBtn];
    [self setRightBarItemIcon:nil butItemTitle:@"保存" addTarget:self action:@selector(ClickOntheSave)];
    self.TempleImage = nil;
    __weak typeof(self)WeakSelf = self;
    UITableView *TableView = UITableView.new;
    [TableView registerNib:[UINib nibWithNibName:@"adduserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"adduserCell"];
    [TableView registerNib:[UINib nibWithNibName:@"adduserfaceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"adduserfaceCell"];

    TableView.delegate = self;
    TableView.dataSource = self;
    [self.view addSubview:TableView];
    [TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(WeakSelf.view);
    }];
    self.dataTableView = TableView;
    [self getdetailedinfo];
    [self initViewModel];
    // Do any additional setup after loading the view.
}
-(void)initViewModel{
    NSArray *titleArray = @[@"头像",@"姓",@"名",@"昵称",@"生日",@"真实生日",@"农历生日",@"电话",@"微信",@"祖籍",@"现居住地",@"职业",@"个人简介"];
    NSArray *ziduanArray = @[@"face",@"firstname",
                             @"lastname",@"usrname",@"birthday",@"actualbirthday",@"lunarbirthday",@"mobile",@"wexin",@"hometown",@"livecity",@"professional",@"introduction"];

    self.listItems = [[NSMutableArray alloc]init];
    for (int i = 0; i<[titleArray count]; i++) {
        addUserItem *userItem = [[addUserItem alloc]init];
        userItem.Title = titleArray[i];
        userItem.en_title = ziduanArray[i];
        [self.listItems addObject:userItem];
    }
    [self.dataTableView reloadData];
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
/**
 获取家庭用户。
 */
-(void)getdetailedinfo{
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/getdetailedinfo",XggUrl];
    NSMutableDictionary *Params = [[PublicParameters sharedManager]GetPublicParameters];
    if (self.uid) {
        [Params setObject:self.uid forKey:@"uid"];
    }
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        [WeakSelf processingErrorMessage:dic];
        NSDictionary *baseinfo = dic[@"baseinfo"];
        [WeakSelf reloadViewWithDic:baseinfo];
    } WithFailurBlock:^(NSError *error){
        [WeakSelf networkAnomalies];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        adduserfaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adduserfaceCell" forIndexPath:indexPath];
        addUserItem *item = self.listItems[indexPath.row];
        cell.titleLabel.text =item.Title;
        if (self.TempleImage) {
            cell.faceimageView.image = self.TempleImage;
        }
        else{
            [cell.faceimageView sd_setImageWithURL:[NSURL URLWithString:item.Content] placeholderImage:XGGplaceholderImage];
        }
        cell.faceimageView.layer.cornerRadius = 44/2;
        cell.faceimageView.layer.masksToBounds = YES;
        return cell;
    }
    adduserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adduserCell" forIndexPath:indexPath];
    addUserItem *item = self.listItems[indexPath.row];
    cell.TitleLabel.text = item.Title;
    cell.ContentLabel.text = item.Content;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 64;
    }
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listItems count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self KWClickOntheFaceimageView];
    }
    else{
        __weak typeof(self)WeakSelf = self;
        addUserItem *UserItem = self.listItems[indexPath.row];
        if (indexPath.row==4||indexPath.row == 5||indexPath.row ==6){
            NSDate *recomanddate = [[NSDate date]dateBySubtractingYears:25];
            if (UserItem.Content.length>0) {
                recomanddate = [NSDate dateWithString:UserItem.Content formatString:@"yyyy-MM-dd" timeZone:[NSTimeZone systemTimeZone]];
            }
            [[KWareaManageVC alloc]KwdatePickCurrentTarget:self withDate:recomanddate withresultDate:^(NSDate *currentdate) {
                NSString *dataString = [currentdate formattedDateWithFormat:@"yyyy-MM-dd" timeZone:[NSTimeZone systemTimeZone]];
                UserItem.Content = dataString;
                [WeakSelf.dataTableView reloadData];
            }];
        }
        else{
            addUserInput *userInput = [[addUserInput alloc]init];
            userInput.item = UserItem;
            [self.navigationController pushViewController:userInput animated:YES];
        }
    }

}
-(void)reloadViewWithDic:(NSDictionary *)dic{
    for (addUserItem *userItem in self.listItems){
        NSString *itemContent = dic[userItem.en_title];
        userItem.Content = itemContent;
    }
    [self.dataTableView reloadData];
}
-(void)ClickOntheSave{
    [self setShowLoadingInWindow:@"保存中"];
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/editorinfo",XggUrl];
    NSMutableDictionary *Params = [[PublicParameters sharedManager]GetPublicParameters];
    if (self.uid){
        [Params setObject:self.uid forKey:@"uid"];
    }
    for (addUserItem *userItem in self.listItems){
        [Params setObject:userItem.Content forKey:userItem.en_title];
    }
    [[XggNetworking sharedManager]requestWithMethod:POST WithPath:URL WithParams:Params WithSuccessBlock:^(NSDictionary *dic){
        [WeakSelf processingErrorMessage:dic];
        NSString *result = dic[@"result"];
        if ([result intValue] == 1){
            if (!WeakSelf.TempleImage) {
                [WeakSelf UpdataFinish];
            }
            else{
                [WeakSelf updatetheavatar];
            }
        }
    } WithFailurBlock:^(NSError *error){
        [WeakSelf networkAnomalies];
    }];
}
//点击头像。
-(void)KWClickOntheFaceimageView{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"修改个人头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self)WeakSelf = self;
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [[KwPicturestochooseManage sharedManager]PickerControllerSourceTypeCamera:KWimageTypeSingle withTarget:self withEditor:YES withresult:^(NSArray<Kwpicturemodel *> *picArray){
            Kwpicturemodel *model = picArray[0];
            UIImage *faceimage = [self scaleToSize:model.photo size:CGSizeMake(240, 240)];
            WeakSelf.TempleImage = faceimage;
            [WeakSelf.dataTableView reloadData];
        } withError:^(NSDictionary *dic) {
            [WeakSelf setShowMessage:dic[@"error"]];
        }];
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [[KwPicturestochooseManage sharedManager]PickerControllerSourceTypePhotoLibrary:KWimageTypeSingle withTarget:self withEditor:YES withresult:^(NSArray<Kwpicturemodel *> *picArray){
            if ([picArray count]>0) {
                Kwpicturemodel *model = picArray[0];
                UIImage *faceimage = [self scaleToSize:model.photo size:CGSizeMake(240, 240)];
                WeakSelf.TempleImage = faceimage;
                [WeakSelf.dataTableView reloadData];
            }
        }];
    }];
    UIAlertAction *Action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:Action1];
    [alertVC addAction:Action2];
    [alertVC addAction:Action3];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)updatetheavatar{
    __weak typeof(self)WeakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/updatetheavatar",XggUrl];
    NSMutableDictionary *Params = [[PublicParameters sharedManager]GetPublicParameters];
    [Params setObject:self.uid forKey:@"uid"];
    NSData *ImageData = UIImageJPEGRepresentation(self.TempleImage, 1);
    [[XggNetworking sharedManager]POST:URL parameters:Params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:ImageData name:@"img" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [WeakSelf processingErrorMessage:responseObject];
        NSString *result = responseObject[@"result"];
        if ([result intValue] == 1){
            [WeakSelf UpdataFinish];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [WeakSelf networkAnomalies];

    }];
}
-(void)UpdataFinish{
    [self SetShowMessageInWindow:@"修改成功"];
    if (_EditorResult) {
        _EditorResult();
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    });
}
-(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
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
