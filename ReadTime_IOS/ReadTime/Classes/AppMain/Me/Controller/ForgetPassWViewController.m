//
//  ForgetPassWViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ForgetPassWViewController.h"
#import "UITextField+Shake.h"

@interface ForgetPassWViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UIView *baceView;
@property (nonatomic ,strong)UITextField *phoneTextFiled;
@property (nonatomic ,strong)UITextField *pwdTextFiled;
@property (nonatomic ,strong)UIButton *yzButton;
@property(assign, nonatomic) NSInteger timeCount;
@property(weak, nonatomic) NSTimer *timer;
@property(nonatomic ,strong)NSString *code;

@end

@implementation ForgetPassWViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"找回密码"];
    [self showBackWithTitle:@"返回"];
    self.view.backgroundColor=UIColorFromHex(0xFAFAFA);//设置为灰色
    [self createTextFiled];
}
- (void)dealloc{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_timer.isValid) {
        [_timer invalidate];
        _timer=nil;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)createTextFiled{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    _baceView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, 100)];
    _baceView.layer.cornerRadius = 5.0;
    _baceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baceView];
    
    _phoneTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入11位手机号"];
    _phoneTextFiled.keyboardType=UIKeyboardTypePhonePad;
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFiled.delegate = self;
    [_baceView addSubview:_phoneTextFiled];
    
    _pwdTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入验证码"];
    _pwdTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextFiled.delegate = self;
    _pwdTextFiled.secureTextEntry = YES;
    [_baceView addSubview:_pwdTextFiled];
    
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
    
    _yzButton=[[UIButton alloc]initWithFrame:CGRectMake(_baceView.frame.size.width-100-20, 62, 100, 30)];
    [_yzButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_yzButton setTitleColor:UIToneBackgroundColor forState:UIControlStateNormal];
    _yzButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_yzButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [_baceView addSubview:_yzButton];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, _baceView.frame.size.width - 40, 1)];
    line1.backgroundColor =UIColorFromHex(0xB4B4B4);
    line1.alpha=0.3;
    [_baceView addSubview:line1];
    
    UIButton *landBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,_baceView.frame.size.height + _baceView.frame.origin.y + 30, self.view.frame.size.width - 20, 37)];
    [landBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [landBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [landBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    landBtn.backgroundColor=UIToneBackgroundColor;
    landBtn.layer.cornerRadius=3.0;
    [self.view addSubview:landBtn];

    
}
#pragma mark - 视图切换
- (void)backAction:(UIButton *)sender{
    
    [self returnViewControllerWithName:@"LoginViewController"];
}

#pragma mark - 类内使用方法
-(UITextField *)createTextFiledWithFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}
- (void)getValidCode:(UIButton*)sender{
    NSScanner *scan = [NSScanner scannerWithString:_phoneTextFiled.text];
    int val;
    BOOL PureInt = [scan scanInt:&val]&&[scan isAtEnd];
    if (!PureInt || _phoneTextFiled.text.length !=11)
    {
        [_phoneTextFiled shake];
    }
    else
    {
        sender.userInteractionEnabled = YES;
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        //获取验证码
//        _pwdTextFiled.text = _code;
    }
}
- (void)reduceTime:(NSTimer*)codeTimer{
    self.timeCount--;
    if (self.timeCount == 0) {
        [_yzButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        _yzButton.userInteractionEnabled = YES;
        [self.timer invalidate];
        self.timer=nil;
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒重新获取", self.timeCount];
        [_yzButton setTitle:str forState:UIControlStateNormal];
        _yzButton.userInteractionEnabled = NO;
        
    }

}
- (void)next:(UIButton*)button{
    [self pushViewControllerWithName:@"GetPassWordViewController"];
    if (_phoneTextFiled.text.length == 11 && _pwdTextFiled.text == _code) {
        
    }
    else{
        [_pwdTextFiled shake];
        [_phoneTextFiled shake];
    }
}
#pragma mark - 代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneTextFiled) {
        [_phoneTextFiled resignFirstResponder];
    }
    if (textField == _pwdTextFiled) {
        [_pwdTextFiled resignFirstResponder];
    }
    return YES;
}



@end
