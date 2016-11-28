//
//  RelationShowViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/17.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "RelationShowViewController.h"
#import "XGGHeader.h"
#import "XggFmTableViewCell.h"
@interface RelationShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *TableView;
@end

@implementation RelationShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关系链";
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
    // Do any additional setup after loading the view.
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
