//
//  GetPassWordViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/3.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "GetPassWordViewController.h"

@interface GetPassWordViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UITextField *pwdTextFiled;

@end

@implementation GetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"重置密码"];
    [self showBackWithTitle:@"返回"];
    self.view.backgroundColor=UIColorFromHex(0xFAFAFA);//设置为灰色
    [self createTextFiled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)backAction:(UIButton *)sender{
    
    [self returnViewControllerWithName:@"ForgetPassWViewController"];
}
- (void)createTextFiled
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请设置新密码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, 50)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5.0;
    [self.view addSubview:_backView];
    
    _pwdTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
    _pwdTextFiled.delegate = self;
    _pwdTextFiled.placeholder = @"8到16位的数字或字母";
    _pwdTextFiled.font = [UIFont systemFontOfSize:14];
    _pwdTextFiled.secureTextEntry = YES;
    _pwdTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backView addSubview:_pwdTextFiled];
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"密码";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    
    UIButton *landBtn= [[UIButton alloc]initWithFrame:CGRectMake(10, _backView.frame.size.height + _backView.frame.origin.y + 30, self.view.frame.size.width - 20, 37)];
    [landBtn setTitle:@"完成" forState:UIControlStateNormal];
    [landBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [landBtn addTarget:self action:@selector(landClick) forControlEvents:UIControlEventTouchUpInside];
    landBtn.backgroundColor=UIToneBackgroundColor;
    landBtn.layer.cornerRadius=3.0f;
    
    [_backView addSubview:phonelabel];
    [self.view addSubview:landBtn];
}

- (void)landClick{
    
}

@end
