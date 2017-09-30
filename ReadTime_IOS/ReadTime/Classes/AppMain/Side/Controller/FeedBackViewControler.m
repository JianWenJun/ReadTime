//
//  FeedBackViewControler.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "FeedBackViewControler.h"
#import "UpDataEngine.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FileModel.h"
@import MobileCoreServices;
@interface FeedBackViewControler ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSString *stringType;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString* fileName;
@property (nonatomic, strong) NSURL* filePath;
@property (nonatomic, strong) NSData* filedata;
@property (nonatomic, strong) NSString* mimeType;
@property (nonatomic, strong) NSString* dataName;

@end

@implementation FeedBackViewControler

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"意见反馈"];
    [self setRithtItemWithTitle:@"发送" selector:@selector(commitSuggestion)];
    [self showBackWithTitle:@"返回"];
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickImgToServer)];
    self.addImg.userInteractionEnabled=YES;
    [self.addImg addGestureRecognizer:tap];
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initLayout{
    _content.placeholder=@"请提出您的意见和建议";
    _content.translatesAutoresizingMaskIntoConstraints=NO;
    _stringType=@"程序方面";
}
#pragma mark - 点击事件
//选择程序错误类型
- (IBAction)chooseError:(UIButton *)sender {
    [_errorType setImage:[UIImage imageNamed:@"feedback_selected"] forState:UIControlStateNormal];
    [_founctionType setImage:[UIImage imageNamed:@"feedback_unselected"] forState:UIControlStateNormal];
    _stringType=@"程序方面";
}
//选择程序功能类型
- (IBAction)chooseFounction:(id)sender {
    [_errorType setImage:[UIImage imageNamed:@"feedback_unselected"] forState:UIControlStateNormal];
    [_founctionType setImage:[UIImage imageNamed:@"feedback_selected"] forState:UIControlStateNormal];
    _stringType=@"功能方面";
}

/**
 添加截图
 */
- (void)pickImgToServer{
    UIImagePickerController* imagePick=[UIImagePickerController new];
    imagePick.delegate=self;
    imagePick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePick.allowsEditing=NO;
    imagePick.mediaTypes=@[(NSString *)kUTTypeImage];
    [self presentViewController:imagePick animated:YES completion:nil];
}

/**
 返回
 */
- (void)backAction:(UIButton *)sender{
     [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 提交意见
 */
- (void)commitSuggestion{
    if ([_content.text isEqualToString:@""]||_content.text==nil) {
        [YJProgressHUD showMessage:@"内容不能为空" inView:self.view];
    }else{
       
        [YJProgressHUD showProgressCircleNoValue:@"提交中..." inView:self.view];
        [UpDataEngine control:self dataFilePath:self.filedata  fileName:self.fileName mimeType:@"image/jpeg" complete:^(id data, NSError *error) {
            if (!error) {
                FileModel* fileData=[FileModel mj_objectWithKeyValues:data];
                if (![fileData.url isEqualToString:@""]&&fileData.url!=nil) {
                    [self commit:fileData.url];
                }
            }
        }];
    }
}
- (void)commit:(NSString*) url{
    FeedBackModel* model=[[FeedBackModel alloc]init];
    model.content=_content.text;
    model.imgUrl=url;
    model.userID=1;
    model.type=_stringType;
    [UpDataEngine control:self feedBackModel:model complete:^(id data, NSError *error) {
        if (error) {
             [YJProgressHUD showMessage:error.localizedDescription inView:self.view];
        }else{
            [YJProgressHUD showSuccess:@"提交成功" inview:self.view];
           [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.mimeType=info[UIImagePickerControllerMediaType];
    self.filePath=[info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        self.fileName = [representation filename];
       
        NSRange range = [self.fileName rangeOfString:@"." options:NSBackwardsSearch];
        if (range.length>0)
            self.dataName=[self.fileName substringToIndex:NSMaxRange(range)-1];
        
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:self.filePath
                   resultBlock:resultblock
                  failureBlock:nil];
    _image=info[UIImagePickerControllerOriginalImage];
//    _filedata=[UIView compressImage:_image];  // 图片压缩
    _filedata= UIImageJPEGRepresentation(_image, 1);
    NSLog(@"图片原来二进制流大小：%ld",_filedata.length);
    [picker dismissViewControllerAnimated:YES completion:^{
        _addImg.image=_image;
    }];
}

@end
