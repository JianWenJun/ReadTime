//
//  LeftViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/3.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "LeftViewController.h"
#import "LoginViewController.h"
#import "BaseNaViewController.h"
#import "CollAndUpMainViewController.h"
#import "UserinfoSettingVC.h"
#import "AppDelegate.h"
#import "UserInfo.h"
#import "FeedBackViewControler.h"
#import "CKAlertViewController.h"
#import "UIImage+DSRoundImage.h"
#import "UIImageView+WebCache.h"
#import "CacheManager.h"
#import "SDImageCache.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UILabel* name;
@property (nonatomic,weak)UILabel* signName;
@property (nonatomic,weak)UILabel* tipLogin;
@property (nonatomic,weak)UIImageView* headImg;
@property (nonatomic,weak)UILabel* loginout;
@property (nonatomic,strong)UITableView *tableview;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    NSLog(@"viewLoad");
    [super viewDidLoad];
    [self initView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reFreshUserInfo) name:@"UserRefresh" object:nil];
}
- (void)dealloc{
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 初始化
- (void)initView{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackg"];
    [self.view addSubview:imageview];
    _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate  = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
}
#pragma mark - item点击事件
- (void)loginIn{
    AppDelegate* tempDele=RT_getDelegate;
    tempDele.LeftSlideVC.mainVC.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [tempDele.LeftSlideVC closeLeftView];
    BaseNaViewController* nLogin=[[BaseNaViewController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
    [tempDele.LeftSlideVC.mainVC presentViewController:nLogin animated:YES completion:nil];
}
- (void)logout{
    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"退出登录" message:@"您确定退出吗?" ];
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
    }];
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确定" handler:^(CKAlertAction *action) {
        [UserConfig clearProfile];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UserRefresh" object:nil];
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:NO completion:nil];
}
- (void)reFreshUserInfo{
    [self.tableview reloadData];
//    NSLog(@"刷新-----");
}
//menu菜单选中
- (void)menuSelectAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
        case 1:
        case 2:
        {
            ////先判断登录状态
            if ([UserConfig IsLogin]) {
                AppDelegate* tempDele=RT_getDelegate;
                tempDele.LeftSlideVC.mainVC.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
                [tempDele.LeftSlideVC closeLeftView];
                CollAndUpMainViewController* CAUVc=[[CollAndUpMainViewController alloc]init];
                CAUVc.selectIndex=index;
                BaseNaViewController* nCAUVc=[[BaseNaViewController alloc]initWithRootViewController:CAUVc];
                [tempDele.LeftSlideVC.mainVC presentViewController:nCAUVc animated:YES completion:nil];
            }else{
                [YJProgressHUD showMsgWithoutView:@"请先登录！！！"];
                [self loginIn];
            }
        }
            break;
        case 3:{
            if ([UserConfig IsLogin]){
                //先判断是否登录
                AppDelegate* tempDele=RT_getDelegate;
                FeedBackViewControler* FavVC=[[FeedBackViewControler alloc]initWithNibName:@"FeedBackViewControler" bundle:nil];
                BaseNaViewController* nFavVC=[[BaseNaViewController alloc]initWithRootViewController:FavVC];
                [tempDele.LeftSlideVC.mainVC presentViewController:nFavVC animated:YES completion:nil];
            }else{
                [YJProgressHUD showMsgWithoutView:@"请先登录！！！"];
                [self loginIn];
            }
        }
            break;
        case 4:{
            
            CGFloat cacheSize= [[SDImageCache sharedImageCache]getSize]/1024/1024;
            NSString* mess=[NSString stringWithFormat:@"您将清除缓存%.2fM",cacheSize];
            CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"清除缓存" message: mess];
            CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
            }];
            CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确定" handler:^(CKAlertAction *action) {
                [[SDImageCache sharedImageCache]clearMemory];
                [[SDImageCache sharedImageCache]clearDisk];
            }];
            
            [alertVC addAction:cancel];
            [alertVC addAction:sure];
            [self presentViewController:alertVC animated:NO completion:nil];
        }
            break;
        case 5:{
            if ([UserConfig IsLogin]){
                AppDelegate* tempDele=RT_getDelegate;
                UserinfoSettingVC* myinfoVC=[[UserinfoSettingVC alloc]initWithNibName:@"UserinfoSettingVC" bundle:nil];
                BaseNaViewController* nmyinfoVC=[[BaseNaViewController alloc]initWithRootViewController:myinfoVC];
                [tempDele.LeftSlideVC.mainVC presentViewController:nmyinfoVC animated:YES completion:nil];
            }else{
                [YJProgressHUD showMsgWithoutView:@"请先登录！！！"];
                [self loginIn];

            }
        }break;
        default:
            break;
    }
}
#pragma mark - 代理的实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* Identifier=@"leftMenuID";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:Identifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize:20.0f];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    if (indexPath.row==0) {
        cell.textLabel.text=@"我的收藏";
    }else if(indexPath.row==1){
         cell.textLabel.text=@"我的发布";
    }
    else if(indexPath.row==2){
        cell.textLabel.text=@"我的评论";
    }
    else if(indexPath.row==3){
        cell.textLabel.text=@"意见反馈";
    }
    else if(indexPath.row==4){
        cell.textLabel.text=@"清除缓存";
    }
    else if(indexPath.row==5){
        cell.textLabel.text=@"修改资料";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self menuSelectAtIndex:indexPath.row];
    [self colseMenu];
    
}

//设置头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 145;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray* views=[[NSBundle mainBundle]loadNibNamed:@"MenuHeaderView" owner:self options:nil];
    UIView* view=views[0];
     _headImg=[view viewWithTag:1];
    _tipLogin=[view viewWithTag:2];
    _name=[view viewWithTag:3];
    _signName=[view viewWithTag:4];
//    [_headImg setImage:<#(UIImage * _Nullable)#>];
    view.backgroundColor=[UIColor clearColor];
    [self LoginOrUn:[UserConfig IsLogin]];
    return view;
}
//设置底部
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 75;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSArray* views=[[NSBundle mainBundle]loadNibNamed:@"MenuFooterView" owner:self options:nil];
    UIView* view=views[0];
    _loginout=[view viewWithTag:1];
    if ([UserConfig IsLogin]) {
        _loginout.hidden=NO;
        _loginout.userInteractionEnabled=YES;
        UITapGestureRecognizer *logoutGestRec=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logout)];
        [_loginout addGestureRecognizer:logoutGestRec];
    }else{
        _loginout.hidden=YES;
    }
    view.backgroundColor=[UIColor clearColor];
    return view;
}
#pragma mark - 内部method
- (void)colseMenu{
    AppDelegate* tempDele=RT_getDelegate;
    [tempDele.LeftSlideVC closeLeftView];
}

- (void)LoginOrUn:(BOOL)login{
    if (login) {
        _tipLogin.hidden=YES;
        _name.hidden=NO;
        _signName.hidden=NO;
        UserInfo* user=[UserConfig myProfile];
        _signName.text=user.signature;
        _name.text=user.username;
        [_headImg setIsRound:YES withSize:CGSizeMake(65, 65)];
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[UserConfig myProfile].headUrl]];
    }else{
        _tipLogin.userInteractionEnabled=YES;
        _tipLogin.hidden=NO;
        _name.hidden=YES;
        _signName.hidden=YES;
        UIImage *image = [UIImage createRoundedRectImage:[UIImage imageNamed:@"default_head"] size:CGSizeMake(65, 65) radius:35] ;
        [_headImg setImage:image];
        UITapGestureRecognizer* loginTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginIn)];
        [_tipLogin addGestureRecognizer:loginTap];
            }
}

@end
