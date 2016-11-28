//
//  XggSpaceViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/10/22.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggFunctionViewController.h"
#import "XGGHeader.h"
#import "FunctionItemCell.h"
#import "FunctionItem.h"
#import "XggFmViewController.h"
@interface XggFunctionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *TableView;
@property(nonatomic,strong)NSMutableArray *listItems;
@end
@implementation XggFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能";
    UITableView *TableView = UITableView.new;
    [self.view addSubview:TableView];
    __weak typeof(self)WeakSelf = self;
    [TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(WeakSelf.view);
    }];
    self.TableView = TableView;
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    [self.TableView setTableFooterView:[[UIView alloc]init]];
    [self.TableView registerClass:[FunctionItemCell class] forCellReuseIdentifier:@"FunctionItemCell"];
    [self initListItems];
    // Do any additional setup after loading the view.
}
-(void)initListItems{
    if (!self.listItems) {
        self.listItems = [[NSMutableArray alloc]init];
    }
    [self.listItems removeAllObjects];
    NSArray *Titles = @[@"族谱"];
    NSArray *Icons = @[@"item_famille"];
    NSArray *ClassName = @[@"XggFmViewController"];
    for (int i = 0; i<[Titles count]; i++){
        FunctionItem *item = FunctionItem.new;
        item.itemTitle = Titles[i];
        item.itemIcon = Icons[i];
        item.className = ClassName[i];
        [self.listItems addObject:item];
    }
    [self.TableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FunctionItemCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"FunctionItemCell" forIndexPath:indexPath];
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
    FunctionItem *item = self.listItems[indexPath.row];
    if (item.className.length>0) {
        UIViewController *ViewController = [[NSClassFromString(item.className) alloc]init];
        if ([ViewController isKindOfClass:[UIViewController class]]){
            ViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ViewController animated:YES];
        }
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
