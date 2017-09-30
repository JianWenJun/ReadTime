//
//  RegisterViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RegisterViewController.h"
#import "MeDataEngine.h"
#import "UITextField+Shake.h"
#import "AlertUtil.h"
@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UIView *baceView;
@property (nonatomic,strong)UITextField* phoneTextFiled;//电话号码
@property (nonatomic,strong)UITextField* codeTextFiled;//验证码
@property (nonatomic,strong)UITextField* pwTextFiled;//密码
@property (nonatomic ,strong)UIButton *yzButton;

@property(assign, nonatomic) NSInteger timeCount;//重新获取时间
@property(strong, nonatomic) NSTimer *timer;
@property(nonatomic ,strong)NSString *code;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"注册"];
    [self showBackWithTitle:@"返回"];
    self.view.backgroundColor=UIColorFromHex(0xFAFAFA);//设置为灰色
    [self createTextFiled];

}

/**
 构建视图
 */
- (void)createTextFiled{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请完成您的注册信息";
    label.textColor=[UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    _baceView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, 150)];
    _baceView.layer.cornerRadius = 5.0;
    _baceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baceView];
    _phoneTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入11位手机号"];
    _phoneTextFiled.keyboardType=UIKeyboardTypePhonePad;
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFiled.delegate = self;
    [_baceView addSubview:_phoneTextFiled];
    _codeTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入6位验证码"];
    _codeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTextFiled.delegate = self;
    [_baceView addSubview:_codeTextFiled];
    _pwTextFiled=[self createTextFiledWithFrame:CGRectMake(100, 110, 200, 30) font:[UIFont systemFontOfSize:14 ] placeholder:@"请输入密码"];
    _pwTextFiled.secureTextEntry = YES;
    _pwTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwTextFiled.delegate = self;
    [_baceView addSubview:_pwTextFiled];
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:phonelabel];
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    codelabel.text=@"验证码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=NSTextAlignmentLeft;
    codelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:codelabel];
    UILabel *pwlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 112, 50, 25)];
    pwlabel.text=@"密码";
    pwlabel.textColor=[UIColor blackColor];
    pwlabel.textAlignment=NSTextAlignmentLeft;
    pwlabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:pwlabel];
    _yzButton=[[UIButton alloc]initWithFrame:CGRectMake(_baceView.frame.size.width-100-20, 62, 100, 30)];
    [_yzButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_yzButton setTitleColor:UIToneBackgroundColor forState:UIControlStateNormal];
    _yzButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_yzButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [_baceView addSubview:_yzButton];
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, _baceView.frame.size.width - 40, 1)];
    line1.backgroundColor = UIColorFromHex(0xB4B4B4);
    line1.alpha=0.3;
    [_baceView addSubview:line1];
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, _baceView.frame.size.width - 40, 1)];
    line2.backgroundColor = UIColorFromHex(0xB4B4B4);
    line2.alpha=0.3;
    [_baceView addSubview:line2];
    UIButton *landBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,_baceView.frame.size.height + _baceView.frame.origin.y +50, self.view.frame.size.width - 20, 37)];
    [landBtn setTitle:@"注册" forState:UIControlStateNormal];
    [landBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [landBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    landBtn.backgroundColor=UIToneBackgroundColor;
    landBtn.layer.cornerRadius=3.0;
    [self.view addSubview:landBtn];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)dealloc{
//  NSLog(@"%@",@"dealloc");
}
- (void)viewDidDisappear:(BOOL)animated{
    [_timer invalidate];
    _timer=nil;
}
#pragma mark - 视图切换
- (void)backAction:(UIButton *)sender{    
    [self returnViewControllerWithName:@"LoginViewController"];
}

/**
 获取验证码
 */
- (void)getValidCode:(UIButton*) sender{
    NSScanner* scan=[NSScanner scannerWithString:_phoneTextFiled.text];
    int val;
    BOOL pureInt=[scan scanInt:&val]&&[scan isAtEnd];
    if (!pureInt||_phoneTextFiled.text.length!=11) {
        [_phoneTextFiled shake];
        [YJProgressHUD showMessage:@"电话号码有误" inView:self.view];
    }else{
         sender.userInteractionEnabled = YES;
         self.timeCount = 60;
         self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        [MeDataEngine control:self phoneNum:_phoneTextFiled.text typeID:1 complete:^(id data, NSError *error) {
            if (error) {
                [YJProgressHUD showMessage:error.localizedDescription inView:self.view];
            }
        }];
    }
}
- (void)reduceTime:(NSTimer*)codeTimer{
    
    self.timeCount--;
    UIButton* info=codeTimer.userInfo;
    if (self.timeCount==0) {
        [info setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [info setTitleColor:UIToneBackgroundColor forState:UIControlStateNormal];
        
        info.enabled=YES;
        info.userInteractionEnabled=YES;
        [self.timer invalidate];
        self.timer=nil;
    }
    else{
        NSString* str=[NSString stringWithFormat:@"%lu秒重新获取",self.timeCount];
        [info setTitle:str forState:UIControlStateNormal];
        info.userInteractionEnabled = NO;
//        NSLog(@"%@",str);
    }
}
- (void)registerUser{
    if(_phoneTextFiled.text.length != 11){
        [_phoneTextFiled shake];
        [YJProgressHUD showMessage:@"请检查您的手机号" inView:self.view];
        return;
    }
    if (_codeTextFiled.text.length!=6) {
        [_codeTextFiled shake];
        [YJProgressHUD showMessage:@"请检查您的验证码" inView:self.view];
        return;
    }
    if (_pwTextFiled.text==nil||[_pwTextFiled.text isEqualToString:@""]) {
        [_pwTextFiled shake];
        [YJProgressHUD showMessage:@"请先设置您的密码" inView:self.view];
        return;
    }[MeDataEngine control:self phoneNum:_phoneTextFiled.text code:_codeTextFiled.text passW:_pwTextFiled.text typeID:1 complete:^(id data, NSError *error) {
        if (!error) {
            [YJProgressHUD showMsgWithoutView:@"注册成功,请登录"];
            [self returnViewControllerWithName:@"LoginViewController"];            
        }
    }];
}
#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _phoneTextFiled) {
        [_phoneTextFiled resignFirstResponder];
    }
    if (textField == _codeTextFiled) {
        [_codeTextFiled resignFirstResponder];
    }
    
    return YES;
}
#pragma mark - 类内部方法
-(UITextField *)createTextFiledWithFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}
@end
