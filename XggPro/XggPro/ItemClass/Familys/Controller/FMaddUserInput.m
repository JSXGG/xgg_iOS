//
//  addUserInput.m
//  XggPro
//
//  Created by Baird-weng on 2016/11/1.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "FMaddUserInput.h"
#import "XGGHeader.h"
@interface FMaddUserInput ()
@property(nonatomic,weak)UITextField *TextField;
@end

@implementation FMaddUserInput
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.TextField becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.item.Title;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 44)];
    UITextField *textField = UITextField.new;
    textField.backgroundColor = [UIColor whiteColor];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.3].CGColor;
    textField.layer.borderWidth = 0.5f;
    [textField setLeftView:leftView];
    [self.view addSubview:textField];
    self.TextField = textField;
    if (self.item.Content.length>0) {
        self.TextField.text = self.item.Content;
    }
    __weak typeof(self)WeakSelf = self;
    [textField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@69);
        make.left.right.equalTo(WeakSelf.view);
        make.height.equalTo(@44);
    }];
    [self setRightBarItemIcon:nil butItemTitle:@"完成" addTarget:self action:@selector(ClickOnthefinish)];
    // Do any additional setup after loading the view.
}
-(void)ClickOnthefinish{
    self.item.Content = self.TextField.text;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.TextField resignFirstResponder];
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
