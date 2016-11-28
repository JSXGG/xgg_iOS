//
//  RelationViewController.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/5.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "RelationViewController.h"
#import "adduserCell.h"
#import "relationItem.h"
#import "XGGHeader.h"
#import "FRDLivelyButton.h"
@interface RelationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *TableView;
@property(nonatomic,strong)NSMutableArray *listItems;
@property(nonatomic,strong)SelectrelationResult relationResult;
@end

@implementation RelationViewController
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
-(void)GetrelationSelect:(SelectrelationResult)result{
    self.relationResult = result;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBtn];
    self.title = @"关系";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    NSArray *relatin_ch = @[@"父亲",@"母亲",@"兄弟",@"姐妹",@"丈夫",@"妻子",@"儿子",@"女儿"];
    NSArray *relatin_en = @[@"father",@"mother",@"brother",@"sister",@"husband",@"wife",@"son",@"daughter"];
    for (int i = 0; i<[relatin_ch count]; i++){
        relationItem *item = [[relationItem alloc]init];
        item.relation_ch = relatin_ch[i];
        item.relation_en = relatin_en[i];
        [self.listItems addObject:item];
    }
    // Do any additional setup after loading the view.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    adduserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adduserCell" forIndexPath:indexPath];
    relationItem *item = self.listItems[indexPath.row];
    cell.TitleLabel.text = item.relation_ch;
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
    relationItem *item = self.listItems[indexPath.row];
    if (self.relationResult) {
        self.relationResult(item);
    }
    [self ClickOntheback];
}
-(void)ClickOntheback{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
