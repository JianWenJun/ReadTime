//
//  UserinfoSettingVC.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/3.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "UserinfoSettingVC.h"
#import "UpDataEngine.h"
#import "UIImageView+WebCache.h"
#import "UIImage+DSRoundImage.h"
#import "UserInfo.h"
#import "CKAlertViewController.h"
@import MobileCoreServices;

@interface UserinfoSettingVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIGestureRecognizer* imgTap;

@end

@implementation UserinfoSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"我的资料"];
    [self showBackWithTitle:@"返回"];
    [self setRithtItemWithTitle:@"确认" selector:@selector(changeInfo)];
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initLayout{
    [self.face setIsRound:YES withSize:CGSizeMake(80, 80)];
    UserInfo* myinfo=[UserConfig myProfile];
    NSURL* faceUrl=[NSURL URLWithString:myinfo.headUrl];
    [self.face sd_setImageWithURL:faceUrl];
    self.name.text=[UserConfig getUserName];
    self.sign.text=[UserConfig myProfile].signature;
    self.face.userInteractionEnabled=YES;
    self.imgTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeFace)];
    [self.face addGestureRecognizer:_imgTap];
}
- (void)backAction:(UIButton *)sender{
    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"放弃修改" message: @"确定放弃当前修改吗？"];
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
    }];
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确定" handler:^(CKAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:NO completion:nil];
    
   
}
- (void)changeInfo{
    [UpDataEngine control:self userName:self.name.text sign:self.sign.text complete:^(id data, NSError *error) {
        if (!error) {
            [YJProgressHUD showSuccess:@"成功修改" inview:self.view];
            UserInfo* myinfo=[UserConfig myProfile];
            myinfo.username=self.name.text;
            myinfo.signature=self.sign.text;
            [UserConfig updateProfile:myinfo];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UserRefresh" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
- (void)changeFace{
    NSLog(@"头像更换");
    UIImagePickerController* imagePick=[UIImagePickerController new];
    imagePick.delegate=self;
    imagePick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePick.allowsEditing=NO;
    imagePick.mediaTypes=@[(NSString *)kUTTypeImage];
    [self presentViewController:imagePick animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image=info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
      UIImage*  image1=[UIImage createRoundedRectImage:image size:CGSizeMake(80, 80) radius:40];
        _face.image=image1;
        
    }];
}
@end
