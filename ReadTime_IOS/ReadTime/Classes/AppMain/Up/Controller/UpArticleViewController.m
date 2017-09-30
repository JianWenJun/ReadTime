//
//  UpArticleViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
//https://github.com/aryaxt/iOS-Rich-Text-Editor
@import Photos;
#import "UpArticleViewController.h"
#import "WPEditorConfiguration.h"
#import "WPImageMetaViewController.h"
#import "UpDataEngine.h"
#import "FileModel.h"
#import "ArticleModel.h"
@interface UpArticleViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,WPImageMetaViewControllerDelegate>

@property (nonatomic,strong)UIPopoverController* popoverController;
@property(nonatomic, strong) NSMutableDictionary *mediaAdded;

@property(nonatomic,strong)NSString* imgurl;
@end

@implementation UpArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWpEditConfig];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self setNil];
}
#pragma mark - 类内私有函数
- (void)setNil{
    self.delegate=nil;
    [self setBodyText:@""];
    [self setTitle:@""];
    if (_popoverController!=nil) {
        _popoverController=nil;
    }
    
}
//设置图片选取
- (void)selectImageType:(int)type{
    if (type==1) {
        //判断当前相机是否可用
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //不可用
            return;
        }
        UIImagePickerController* imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing=YES;
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            self.popoverController=[[UIPopoverController alloc]initWithContentViewController:imagePicker];
            [self.popoverController presentPopoverFromRect:self.view.frame
                                                    inView:self.view
                                  permittedArrowDirections:UIPopoverArrowDirectionAny
                                                  animated:YES];
        }else{
            [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
        }
    }else if(type==0){
        UIImagePickerController* imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.delegate=self;
        imagePicker.allowsEditing=YES;
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            [self.popoverController presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        } else {
            
            
            [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
            
        }
    }
}
//将原图片image添加到editview，并上传至服务器
- (void)addImageFromCamcra:(UIImage*)image{
    NSString* imageID=[[NSUUID UUID]UUIDString];
    NSString* path=[NSString stringWithFormat:@"%@/%@.jpg",NSTemporaryDirectory(),imageID];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    [imageData writeToFile:path atomically:YES];
    
    [self submitImage:imageData imageID:imageID];
    [self.editorView insertLocalImage:[[NSURL fileURLWithPath:path] absoluteString] uniqueId:imageID];
}
- (void)addAssetToContent:(NSURL *)assetURL{
    PHFetchResult* assets=[PHAsset fetchAssetsWithALAssetURLs:@[assetURL] options:nil];
    if (assets.count<1) {
        return;
    }
    PHAsset* asset=[assets firstObject];
    if (asset.mediaType==PHAssetMediaTypeImage) {
        [self addImageAssetToContent:asset];
    }

}
- (void)addImageAssetToContent:(PHAsset *)asset{
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.synchronous = NO;
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    NSString *imageID = [[NSUUID UUID] UUIDString];
    NSString *path = [NSString stringWithFormat:@"%@/%@.jpg", NSTemporaryDirectory(), imageID];
//    NSLog(@"path1:%@",path);
    [[PHImageManager defaultManager]requestImageDataForAsset:asset
                                                     options:options
                                               resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                                                   [imageData writeToFile:path atomically:YES];
                                                   dispatch_async(dispatch_get_main_queue(), ^{
//                                                       NSLog(@"path2:%@",path);
                                                       [self.editorView insertLocalImage:[[NSURL fileURLWithPath:path]absoluteString] uniqueId:imageID];
                                                       [self submitImage:imageData imageID:imageID];
                                                   });
    }];
}
//将图片上传至服务器
- (void)submitImage:(NSData*)imageData imageID:(NSString*)imageID{
    [YJProgressHUD showProgressCircleNoValue:@"提交中..." inView:self.view];
    [UpDataEngine control:self dataFilePath:imageData  fileName:imageID mimeType:@"image/jpeg" complete:^(id data, NSError *error) {
        if (!error) {
            FileModel* fileData=[FileModel mj_objectWithKeyValues:data];
            if (![fileData.url isEqualToString:@""]&&fileData.url!=nil) {
//                [self commit:fileData.url];//提交文字
                [YJProgressHUD hide];
                self.imgurl=fileData.url;
            }
        }
    }];
}
- (void)commit:(NSString*)url{
    
}
#pragma mark - view设置
- (void)initView{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 2, 44, 44)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(13, 0, 13, 34)];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back_more"] forState:UIControlStateNormal];
    UIBarButtonItem* barBtn=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=barBtn;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(publicArtAction:)];
    self.title=@"发布内容";
    self.bodyPlaceholderText=@"写点什么吧~";
    self.titlePlaceholderText=@"文章标题";
    
}
- (void)initWpEditConfig{
    WPEditorConfiguration* _wpEditConfig=[WPEditorConfiguration sharedWPEditorConfiguration];
    _wpEditConfig.localizable=kLMChinese;//中文
    _wpEditConfig.enableImageSelect=ZSSRichTextEditorImageSelectPhotoLibrary|ZSSRichTextEditorImageSelectTakePhoto;
    self.delegate=self;
    self.itemTintColor=UIToneBackgroundColor;
    
}

#pragma mark - WPEditorViewControllerDelegate

- (void)editorDidBeginEditing:(WPEditorViewController *)editorController{
//    NSLog(@"开始编辑----“);
}
- (void)editorDidEndEditing:(WPEditorViewController *)editorController{
 //    NSLog(@"结束编辑----“);
}
- (void)editorDidFinishLoadingDOM:(WPEditorViewController *)editorController{
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
    //    NSString *htmlParam = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //      [self setTitleText:@""];
    //    [self setBodyText:htmlParam];
    [self startEditing];
}
- (BOOL)editorShouldDisplaySourceView:(WPEditorViewController *)editorController{
    [self.editorView pauseAllVideos];
    return YES;
}
- (void)editorDidPressMedia:(int)type{
    [self selectImageType:type];
}

- (void)editorTitleDidChange:(WPEditorViewController *)editorController{
    
}

- (void)editorTextDidChange:(WPEditorViewController *)editorController{
    
}
- (void)editorViewController:(WPEditorViewController *)editorViewController fieldCreated:(WPEditorField *)field{
//    NSLog(@"Editor field created: %@", field.nodeId);
}

- (void)editorViewController:(WPEditorViewController *)editorViewController
                 imageTapped:(NSString *)imageId
                         url:(NSURL *)url
                   imageMeta:(WPImageMeta *)imageMeta{
    if (imageId.length==0) {
        [self showImageDetailsForImageMeta:imageMeta];
    }else{
        [self showPromptForImageWithID:imageId];
    }
}
- (void)editorViewController:(WPEditorViewController *)editorViewController
               imageReplaced:(NSString *)imageId{
    [self.mediaAdded removeObjectForKey:imageId];
}
#pragma mark - WPImageMetaViewControllerDelegate
- (void)imageMetaViewController:(WPImageMetaViewController *)controller didFinshEditingImageMeta:(WPImageMeta *)imageMeta{
    [self.editorView updateCurrentImageMeta:imageMeta];
}
- (void)showImageDetailsForImageMeta:(WPImageMeta*)imageMeta{
    WPImageMetaViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WPImageMetaViewController"];
    controller.imageMeta = imageMeta;
    controller.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}
- (void)showPromptForImageWithID:(NSString*)imageID{
    
}
#pragma mark - 点击事件
- (void)editTouchedUpInside{
    
}
//回退
- (void)backAction:(UIButton*)sender{
    [self.view endEditing:YES];
    //添加是否存草稿
    [self dismissViewControllerAnimated:YES completion:^{
        [self setNil];
    }];
}
//发表
- (void)publicArtAction:(id)sender{
    [self.view endEditing:YES];
    ArticleModel* artModel=[ArticleModel new];
    artModel.imgUrl=self.imgurl;
    artModel.userID=[UserConfig getUserID];
    artModel.userName=[UserConfig getUserName];
    artModel.artTitle=self.titleText;
    artModel.artContent=self.bodyText;
    [UpDataEngine control:self artModel:artModel complete:^(id data, NSError *error) {
        if (!error) {
            [YJProgressHUD showMsgWithoutView:@"上传成功，等待审核"];
            [self dismissViewControllerAnimated:YES completion:^{
                [self setNil];
            }];
        }
    }];
//    NSLog(@"标题:%@",self.titleText);
//    NSLog(@"内容:%@",self.bodyText);
//    NSLog(@"图片:%@",self.editorView.getCoverImage);
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        NSURL* asserURL=info[UIImagePickerControllerReferenceURL];
        if (!asserURL) {
            UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
            [self addImageFromCamcra:image];
        }
        
        else{
            [self addAssetToContent:asserURL];
        }
        
    }];
}

@end
