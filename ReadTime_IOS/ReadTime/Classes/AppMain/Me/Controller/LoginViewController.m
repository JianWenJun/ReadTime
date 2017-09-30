//
//  LoginViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "LoginViewController.h"
#import "MeDataEngine.h"
#import "UITextField+Shake.h"
#import "UserInfo.h"
#import "SDImageCache.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton* QQBtn;
@property (nonatomic,strong)UIButton* WeiXinBtn;
@property (nonatomic,strong)UIButton* XinLangBtn;
@property (nonatomic ,strong)UIView *backView;
@property (nonatomic,strong)UITextField* phoneTf;
@property (nonatomic,strong)UITextField* passWTf;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
  
}
/**
 初始化
 */
- (void)initNav{
    [self setNavigationItemTitleViewWithTitle:@"登录"];
    [self showBackWithTitle:@"返回"];
    [self setRithtItemWithTitle:@"注册" selector:@selector(gotoRegisterView)];
}
- (void)initView{
     self.view.backgroundColor=UIColorFromHex(0xFAFAFA);//设置为灰色
    //为登陆界面添加TextfFiled
    [self createTextFileds];
    //为登陆界面添加Button
    [self createButtons];
//    //为登陆界面添加Label
    [self createLabel];
//    //为登陆界面添加横线
    [self createImageView];
    
}
#pragma mark - 创建界面
- (void)createTextFileds{
    _backView=[[UIView alloc]initWithFrame:CGRectMake(10, 75, self.view.frame.size.width-20, 100)];
    _backView.layer.cornerRadius=5.0;
    _backView.alpha=0.7;
    _backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_backView];
    
    _phoneTf=[[UITextField alloc]initWithFrame:CGRectMake(60, 10, 230, 30)];
    _phoneTf.delegate=self;
    _phoneTf.placeholder=@"手机号码";
    _phoneTf.font = [UIFont systemFontOfSize:14];
    _phoneTf.keyboardType=UIKeyboardTypePhonePad;
    _phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backView addSubview:_phoneTf];
    
    _passWTf = [[UITextField alloc]initWithFrame:CGRectMake(60, 60, 230, 30)];
    _passWTf.delegate = self;
    _passWTf.placeholder = @"密码";
    _passWTf.font = [UIFont systemFontOfSize:14];
    _passWTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWTf.secureTextEntry = YES;
    [_backView addSubview:_passWTf];
    
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 25, 25)];
    phoneImageView.image=[UIImage imageNamed:@"phone"];
    [_backView addSubview:phoneImageView];
    UIImageView *passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 25, 25)];
    passwordImageView.image= [UIImage imageNamed:@"passw"];
    [_backView addSubview:passwordImageView];
    
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, _backView.frame.size.width - 40, 1)];
    lineImageView.backgroundColor=UIColorFromHex(0xB4B4B4);
    lineImageView.alpha=0.3;
    [_backView addSubview:lineImageView];

}

- (void)createButtons{
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(5, 235, 70, 30);
    [registerButton setTitle:@"快速注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(gotoRegisterView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(10, 190, self.view.frame.size.width - 20, 37);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.layer.cornerRadius=3.0;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setBackgroundColor:UIToneBackgroundColor];
    [self.view addSubview:loginButton];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(self.view.frame.size.width - 75, 235, 60, 30);
    
    [forgetButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetButton addTarget:self action:@selector(gotoForgetPassWView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
    _QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _QQBtn.frame = CGRectMake((self.view.frame.size.width - 50)/2, 400, 50, 50);
    _QQBtn.layer.cornerRadius = 25;
    [_QQBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [_QQBtn addTarget:self action:@selector(QQBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_QQBtn];
    
    _WeiXinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _WeiXinBtn.frame = CGRectMake((self.view.frame.size.width - 50)/2 - 100, 400, 50, 50);
    _WeiXinBtn.layer.cornerRadius = 25;
    [_WeiXinBtn setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [_WeiXinBtn addTarget:self action:@selector(WeiXinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_WeiXinBtn];
    
    _XinLangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _XinLangBtn.frame = CGRectMake((self.view.frame.size.width - 50)/2 + 100, 400, 50, 50);
    _XinLangBtn.layer.cornerRadius = 25;
    [_XinLangBtn setBackgroundImage:[UIImage imageNamed:@"xinlang"] forState:UIControlStateNormal];
    [_XinLangBtn addTarget:self action:@selector(XinLangBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_XinLangBtn];
    
}
-(void)createLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 140)/2, 350, 140, 21)];
    label.text = @"第三方账号登录";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}
-(void)createImageView
{
    UIImageView *lineImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, 360, 100, 1)];
    lineImageView1.backgroundColor = [UIColor lightGrayColor];
    UIImageView *lineImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100 - 4, 360, 100, 1)];
    lineImageView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineImageView1];
    [self.view addSubview:lineImageView2];
}
#pragma mark - 视图切换

/**
 切换至注册模块
 */
- (void)gotoRegisterView{
    [self pushViewControllerWithName:@"RegisterViewController"];
}
/**
 切换至忘记密码模块
 */
- (void)gotoForgetPassWView{
    [self pushViewControllerWithName:@"ForgetPassWViewController"];
}
/**
 验证登录
 */
- (void)loginButtonClick{
    if (_phoneTf.text.length!=11) {
        [YJProgressHUD showMessage:@"请检查您的手机号码" inView:self.view];
        [_phoneTf shake];
        return;
    }
    if (_passWTf.text==nil||[_passWTf.text isEqualToString:@""]) {
         [YJProgressHUD showMessage:@"请检查您的密码输入" inView:self.view];
        [_passWTf shake];
        return;
    }
    [MeDataEngine control:self phoneNum:_phoneTf.text passW:_passWTf.text complete:^(id data, NSError *error) {
        if (!error) {
            UserInfo* user=[UserInfo mj_objectWithKeyValues:data];
            [UserConfig saveProfile:user];
            [YJProgressHUD showMsgWithoutView:@"登录成功"];
            [self dismissViewControllerAnimated:YES completion:^{
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"UserRefresh" object:nil];
            }];
        }
    }];
}

/**
 第三方登录
 */
- (void)XinLangBtnClick{
     [YJProgressHUD showMessage:@"该功能正在开发中" inView:self.view];
}
- (void)WeiXinBtnClick{
     [YJProgressHUD showMessage:@"该功能正在开发中" inView:self.view];
}
- (void)QQBtnClick{
     [YJProgressHUD showMessage:@"该功能正在开发中" inView:self.view];
}
/**
 返回
 */
- (void)backAction:(UIButton *)sender{
    if ( [_phoneTf isFirstResponder]) {
        [_phoneTf resignFirstResponder];
    }
    if ( [_passWTf isFirstResponder]) {
        [_passWTf resignFirstResponder];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _phoneTf) {
        [_phoneTf resignFirstResponder];
    }
    if (textField == _passWTf) {
        [_passWTf resignFirstResponder];
    }
    
    return YES;
}

@end

