//
//  DetailViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/27.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "DetailViewController.h"
#import "ContentWKWebViewCell.h"
#import "DetailAuthorCell.h"
#import "CommentCell.h"
#import "RTWebView.h"
#import "User.h"
#import "NewObject.h"
#import "Collect.h"
#import "Article.h"
#import "ImgBea.h"
#import "Comment.h"
#import "ListComment.h"
#import "SlideArticle.h"
#import "ListUser.h"
#import "ListArticle.h"
#import "ListImgArt.h"
#import "ListSlideArticle.h"
#import "SingleArtileOrImgDataEngine.h"
#import "CommmentAndCollectDataEngine.h"
#import "UITableView+FDTemplateLayoutCell.h" 
#import "UserConfig.h"

#import <UShareUI/UShareUI.h>



static NSString* DetailAuthorCellIdentifier=@"DetailAuthorCell";
static NSString* ContentWKWebViewCellIdentifier=@"ContentWKWebViewCell";
static NSString* CommentCellIdentifier=@"CommentCell";

@interface DetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,
RTWebViewDelegate>

@property (nonatomic,copy)NSString* objectID;//当前文章的ObjectID
@property (copy, nonatomic)NSString* collectObjectId;
@property (nonatomic,assign)BOOL isZti;
@property (nonatomic,assign)BOOL isCollect;//当前用户是否收藏了当前文章
@property (nonatomic,assign)NSInteger count;//该文章收藏数量
@property (nonatomic,strong)User* user;
@property (nonatomic, assign) CGFloat webViewHeight;

@property (nonatomic,strong)RTBaseDataEngine* dataEngine;
@property (nonatomic,strong)RTBaseDataEngine* collandCommentDataEngine;
//文章系列
@property (nonatomic, strong) Article *artDetails;
@property (nonatomic, strong) NSMutableArray *artDetailComments;
//美图系列
@property (nonatomic, strong) ImgBea *imgDetails;
@property (nonatomic, strong) NSMutableArray *imgDetailComments;
//轮播图系列
@property (nonatomic, strong) SlideArticle* slideArtDetails;
@property (nonatomic, strong) NSMutableArray *slideDetailComments;

//软键盘size
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic,assign) BOOL isReboundTop;
@property (nonatomic,assign) CGPoint readingOffest;

@end

@implementation DetailViewController{
    BOOL _isFinshDisplayH5;
    ContentWKWebViewCell* _WKWebViewCell;
}
- (instancetype)initWithObjectId:(NSString*)objectID typeID:(NSInteger)typeID{
    return  [self initWithObjectId:objectID typeID:typeID isZti:NO];
}
- (instancetype)initWithObjectId:(NSString *)objectID typeID:(NSInteger)typeID isZti:(BOOL)isZti{
    if (self) {
        if (typeID==1) {
            _artDetailComments=[NSMutableArray new];
        }else if(typeID==2){
            _imgDetailComments=[NSMutableArray new];
        }else if (typeID==3){
            _slideDetailComments=[NSMutableArray new];
        }
        self.objectID=objectID;
        self.typeID=typeID;
        self.isZti=isZti;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isFinshDisplayH5=NO;
    [self setNavigationItemTitleViewWithTitle:@"详情"];
    [self showBackWithTitle:@"返回"];
    [self setRithtItemWithTitle:@"评论" selector:@selector(gotoComment)];
    [YJProgressHUD showProgress:@"加载中..." inView:self.view];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.commentTextF.delegate=self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailAuthorCell" bundle:nil] forCellReuseIdentifier:DetailAuthorCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil]forCellReuseIdentifier:CommentCellIdentifier];
    [self.tableView registerClass:[ContentWKWebViewCell class] forCellReuseIdentifier:ContentWKWebViewCellIdentifier];
    self.tableView.estimatedRowHeight = 250;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = UIColorFromHex(0xC8C7CC);
    //加载数据
    if (self.typeID==1) {
        [self loadArtData];
    }else if (self.typeID==2){
        [self loadImgData];
    }else if (self.typeID==3){
        [self loadLartData];
    }
    _isCollect=NO;
    if ([UserConfig IsLogin]) {
        [self loadFavState];
    }
    [self loadComments];
    //键盘处理
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upCollectNum) name:@"CollectNum" object:nil];
}
- (void)dealloc
{
//    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击事件
//更新收藏图标
- (void)updateFavButtonWithIsCollect:(BOOL)isCollected{
    if (isCollected) {
        [self.favBtn setImage:[UIImage imageNamed:@"icon_faved_normal"] forState:UIControlStateNormal];
    }else{
        [self.favBtn setImage:[UIImage imageNamed:@"icon_fav_normal"] forState:UIControlStateNormal];
    }
}

//收藏
- (IBAction)doFavTitle:(id)sender {
    if ([UserConfig IsLogin]) {
        if (!_isCollect) {
            //添加收藏collectDes:(NSString*)collectDes
            NSString* collectDes=@"";
            if (_typeID==1) {
                collectDes=_artDetails.articleHeader;
            }else if(_typeID==2){
                collectDes=_imgDetails.imgDes;
            }else if (_typeID==3){
                collectDes=_slideArtDetails.imgTitle;
            }
            [CommmentAndCollectDataEngine control:self objectIDinCollect:_objectID userID:[UserConfig getUserID] artType:_typeID collectDes:collectDes complete:^(id data, NSError *error) {
            if (!error) {
                _count=_count+1;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CollectNum" object:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                     [self updateFavButtonWithIsCollect:YES];
                    _isCollect=YES;
                });
                NewObject* ob=[NewObject mj_objectWithKeyValues:data];
                self.collectObjectId=ob.objectId;
               [YJProgressHUD showSuccess:@"收藏成功" inview:self.view];
                    }}];
        }else{
            //取消收藏
            [CommmentAndCollectDataEngine control:self objectIDinCollectCancel:self.collectObjectId  complete:^(id data, NSError *error) {
                if (!error) {
                     _count=_count-1;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"CollectNum" object:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self updateFavButtonWithIsCollect:NO];
                        _isCollect=NO;
                        [YJProgressHUD showSuccess:@"取消成功" inview:self.view];
                    });
                }
            }];
        }
    }else{
        [YJProgressHUD showMessage:@"请先登录" inView:self.view];
    }
}
//分享
- (IBAction)doShare:(id)sender {
    NSLog(@"分享");
    __weak typeof(self)WeakSelf=self;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [WeakSelf shareWebPageToPlatformType:platformType];
    }];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:@"http://upload-images.jianshu.io/upload_images/576025-461c2cbc32d83356.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error {
    
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n",(int)error.code];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
        // result = [NSString stringWithFormat:@"分享失败"];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    
    [alert show];
}
- (void)backAction:(UIButton *)sender{
    if (self.isZti) {
        [self  returnViewControllerWithName:@"TopicMainViewController"];
        return;
    }
    if (self.typeID==1||self.typeID==3) {
         [self  returnViewControllerWithName:@"HomeViewController"];
    }
    if (self.typeID==2) {
        [self  returnViewControllerWithName:@"BeaImgViewController"];
    }
}
- (void)gotoComment{
    if (self.isReboundTop ==NO) {
        self.readingOffest=self.tableView.contentOffset;
        NSIndexPath*lastSectionIndexpath=[NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView scrollToRowAtIndexPath:lastSectionIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    self.isReboundTop=!self.isReboundTop;
}
- (void)sendComment:(NSString*)content{
    
    [CommmentAndCollectDataEngine control:self objectIDinComment:self.objectID userName:[UserConfig getUserName] userID:[UserConfig getUserID] commentContent:content complete:^(id data, NSError *error) {
        if (!error) {
            self.commentTextF.text=@"";
            [YJProgressHUD showSuccess:@"评论成功" inview:self.view];
            NewObject* newO=[NewObject mj_objectWithKeyValues:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                Comment* com=[[Comment alloc]init];
                com.userName=[UserConfig getUserName];
                com.commentContent=content;
                com.desID=self.objectID;
                com.createdAt=newO.createdAt;
                if (self.typeID==1) {
                    [_artDetailComments addObject:com];
                }else if (self.typeID==2){
                     [_imgDetailComments addObject:com];
                }else if (self.typeID==3){
                    [_slideDetailComments addObject:com];
                }
                //刷新
                NSIndexSet* section2=[[NSIndexSet alloc]initWithIndex:1];
                [self.tableView reloadSections:section2 withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    }];
}
#pragma mark - 类部私有类
- (UIView*)headerViewWithSectionTitle:(NSString*)title{
    UIView* headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32)];
    headerView.backgroundColor=UIColorFromHex(0xf9f9f9);
    
    UIView* topLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    topLineView.backgroundColor=UIColorFromHex(0xC8C7CC);
    [headerView addSubview:topLineView];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 31,SCREEN_WIDTH, 0.5)];
    bottomLineView.backgroundColor = UIColorFromHex(0xC8C7CC);
    [headerView addSubview:bottomLineView];
  
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 100, 16)];
    titleLabel.center = CGPointMake(titleLabel.center.x, headerView.center.y);
    titleLabel.tag = 8;
    titleLabel.textColor = UIColorFromHex(0x6a6a6a);
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = title;
    [headerView addSubview:titleLabel];
    
    return headerView;
}
//加载文章数据
- (void)loadArtData{
    _dataEngine=[SingleArtileOrImgDataEngine control:self objectID:_objectID type:1 complete:^(id data, NSError *error) {
        if (!error) {
            ListArticle* listArt=[ListArticle mj_objectWithKeyValues:data];
            if (listArt.results.count>0) {
                _artDetails=listArt.results[0];
                [self loadUser:_artDetails.userID];
            }else{
                [YJProgressHUD showMessage:@"打开错误,请反馈问题" inView:self.view];
            }
        }
    }];
}
//加载图片详情
- (void)loadImgData{
    _dataEngine=[SingleArtileOrImgDataEngine control:self objectID:_objectID type:2 complete:^(id data, NSError *error) {
        if (!error) {
            NSLog(@"imgdata:%@",data);
            ListImgArt* listImg=[ListImgArt mj_objectWithKeyValues:data];
            if (listImg.results.count>0) {
                _imgDetails=listImg.results[0];
                [self loadUser:_imgDetails.userID];
            }else{
                [YJProgressHUD showMessage:@"打开错误,请反馈问题" inView:self.view];
            }
        }
    }];
}
//加载轮播图详情
- (void)loadLartData{
    _dataEngine=[SingleArtileOrImgDataEngine control:self objectID:_objectID type:3 complete:^(id data, NSError *error) {
        if (!error) {
            ListSlideArticle* listLArt=[ListSlideArticle mj_objectWithKeyValues:data];
            if (listLArt.results.count>0) {
                _slideArtDetails=listLArt.results[0];
                [self loadUser:_slideArtDetails.userID];
            }else{
                [YJProgressHUD showMessage:@"打开错误,请反馈问题" inView:self.view];
            }
        }
    }];
}
//加载文章评论
- (void)loadComments{
    _collandCommentDataEngine=[CommmentAndCollectDataEngine control:self objectIDinComment:self.objectID complete:^(id data, NSError *error) {
        if (!error) {
            ListComment* lcomments=[ListComment mj_objectWithKeyValues:data];
            if (self.typeID==1) {
                _artDetailComments=[lcomments.results mutableCopy];
            }else if(self.typeID==2){
                _imgDetailComments=[lcomments.results mutableCopy];
            }else if(self.typeID==3){
                _slideDetailComments=[lcomments.results mutableCopy];
            }
            NSIndexSet* section2=[[NSIndexSet alloc]initWithIndex:1];
            [self.tableView reloadSections:section2 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}
//加载文章发表用户信息
- (void)loadUser:(NSInteger)userID{
    [SingleArtileOrImgDataEngine control:self userID:userID complete:^(id data, NSError *error) {
        if (!error) {
            ListUser* luser=[ListUser mj_objectWithKeyValues:data];
            _user=luser.results[0];
            NSIndexSet* firstSection=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableView reloadSections:firstSection withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    [CommmentAndCollectDataEngine control:self objectIDinCollect:_objectID complete:^(id data, NSError *error) {
        if (!error) {
            Collect* collect=[Collect mj_objectWithKeyValues:data];
            _count=collect.count;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CollectNum" object:nil];
        }
    }];
}
- (void)loadFavState{
    [CommmentAndCollectDataEngine control:self objectIDinCollect:_objectID userID:[UserConfig getUserID] complete:^(id data, NSError *error) {
        if (!error) {
            Collect* collect=[Collect mj_objectWithKeyValues:data];
            BOOL isCOl=NO;
            if (collect.count!=0) {
                CollectOne* collone=collect.results[0];
                self.collectObjectId=collone.objectId;
                isCOl=YES;
                _isCollect=YES;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateFavButtonWithIsCollect:isCOl];
            });
        }
    }];
}
//处理html
- (NSString*)loadHtml:(NSString*)htContent pattern:(NSString*)pattern templeStr:(NSString*)templeStr{
    NSString* resultStr=nil;
    NSRegularExpression* reg=[[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    resultStr=[reg stringByReplacingMatchesInString:htContent options:NSMatchingReportProgress range:NSMakeRange(0, htContent.length) withTemplate:templeStr];
    return resultStr;
}
- (NSMutableArray*)getComments:(NSInteger) typeID{
    switch (typeID) {
        case 1:
            return _artDetailComments;
            break;
        case 2:
            return _imgDetailComments;
            break;
        case 3:
            return _slideDetailComments;
        default:
            return nil;
            break;
    }
}
#pragma mark - 监听键盘和收藏数量变化处理
- (void)keyboardDidShow:(NSNotification*)notificatio{
    //获取键盘的高度
    NSDictionary* userInfo=[notificatio userInfo];
    NSValue* value=[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect=[value CGRectValue];
    _keyboardHeight=keyBoardRect.size.height;
    _viewBottomConTran.constant=_keyboardHeight;
    _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHiden:)];
    [self.view addGestureRecognizer:_tap];
}

- (void)keyboardDidHide:(NSNotification*)notifiction{
    _viewBottomConTran.constant=0;
}
- (void)keyBoardHiden:(UITapGestureRecognizer *)tap
{
    [_commentTextF resignFirstResponder];
    [self.view removeGestureRecognizer:_tap];
}
- (void)upCollectNum{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath* indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationNone];
    });
}
#pragma mark  - tableView delegate source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            //文章内容
        {
            return 2;
        }
            break;
        case 1://评论相关
        {
            if (self.typeID==1) {
                return self.artDetailComments.count+1;
            }else if (self.typeID==2){
                return self.imgDetailComments.count+1;
            }else if (self.typeID==3){
                return self.slideDetailComments.count+1;
            }else return 1;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        NSInteger num=[self getComments:self.typeID].count;
        if (num>0) {
            return  [self headerViewWithSectionTitle:[NSString stringWithFormat:@"评论(%lu)",num]];
        }
        return [self headerViewWithSectionTitle:@"评论"];
    }
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    return [tableView fd_heightForCellWithIdentifier:DetailAuthorCellIdentifier configuration:^(DetailAuthorCell* cell) {
                        cell.user=self.user;
                        cell.collectCount=self.count;
                    }];
                    break;
                case 1:
                    return _webViewHeight+30;
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:{
            if ([[self getComments:self.typeID] count]>0&&[[self getComments:self.typeID] count]>indexPath.row) {
                
               return  [tableView fd_heightForCellWithIdentifier:CommentCellIdentifier configuration:^(CommentCell* cell) {
                    cell.commentM=[[self getComments:self.typeID] objectAtIndex:indexPath.row];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }];
            }
        }
            break;
        default:
            break;
            return 44;
    }
     return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section!=0 ? 32:0.001;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row==0) {
                DetailAuthorCell* dAuthorCell=[tableView dequeueReusableCellWithIdentifier:DetailAuthorCellIdentifier forIndexPath:indexPath];
                dAuthorCell.user=_user;
                dAuthorCell.collectCount=_count;
                dAuthorCell.selectionStyle=UITableViewCellSelectionStyleNone;
                return dAuthorCell;
            }
            if (indexPath.row==1) {
                    ContentWKWebViewCell* cWkWebCell=[tableView dequeueReusableCellWithIdentifier:ContentWKWebViewCellIdentifier forIndexPath:indexPath];
                    _WKWebViewCell=cWkWebCell;
                    cWkWebCell.contentWebView.delegate=self;
                    if (self.typeID==1) {
                        //URL加载网页
                        NSURL* artUrl=[NSURL URLWithString:_artDetails.articleUrl];
                        NSURLRequest* artRequest=[NSURLRequest requestWithURL:artUrl];
                        [cWkWebCell.contentWebView loadRequest:artRequest];
                    }else {
                        //加载本地网页
                        NSURL* baseUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
                        NSString* htmlPath=[[NSBundle mainBundle] pathForResource:@"temple" ofType:@"html"];
                        NSString* htmlCont=[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
                        NSString* title;
                        NSString* imgUrl;
                        NSString* des;
                        if (_imgDetails!=nil||_slideArtDetails!=nil) {
                            if (_slideArtDetails!=nil) {
                                title=_slideArtDetails.imgTitle;
                                imgUrl=_slideArtDetails.imgUrl;
                                des=_slideArtDetails.imgDes;
                            }if (_imgDetails!=nil) {
                                title=_imgDetails.ImgTopic;
                                imgUrl=_imgDetails.imgUrl;
                                des=_imgDetails.imgDes;
                            }
                            NSString* htmlCont1=[self loadHtml:htmlCont pattern:@"BiaoTi" templeStr:title];
                            NSString* htmlCont2=[self loadHtml:htmlCont1 pattern:@"IMGURL" templeStr:imgUrl];
                            NSString* htmlCont3=[self loadHtml:htmlCont2 pattern:@"ArtContent" templeStr:des];
                            [cWkWebCell.contentWebView loadHTMLString:htmlCont3 baseURL:baseUrl];
                        }
                }
                return cWkWebCell;
            }
        }
            break;
        case 1:{
          //评论
            if (_artDetailComments.count>0||_imgDetailComments.count>0||_slideDetailComments.count>0) {
                if (indexPath.row==[self getComments:self.typeID].count) {
                    UITableViewCell *cell = [UITableViewCell new];
                    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                    cell.textLabel.text = @"更多评论";
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.textLabel.textColor =UIColorFromHex(0x24cf5f);
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
                }else{
                    CommentCell* commentCell=[tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier forIndexPath:indexPath];
                    if ([[self getComments:self.typeID] count]>0){
                        commentCell.commentM=[[self getComments:self.typeID] objectAtIndex:indexPath.row];
                        commentCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    }
                    return commentCell;
                }
            }else{
                UITableViewCell *cell = [UITableViewCell new];
                cell.textLabel.text = @"还没有评论";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = UIColorFromHex(0x24cf5f);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;

            }
        }
            break;
        default:
            break;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.typeID==1) {
        NSURL* artUrl=[NSURL URLWithString:_artDetails.articleUrl];
        NSURLRequest* artRequest=[NSURLRequest requestWithURL:artUrl];
        [_WKWebViewCell.contentWebView loadRequest:artRequest];
    }else {
        //加载本地网页
        NSURL* baseUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString* htmlPath=[[NSBundle mainBundle] pathForResource:@"temple" ofType:@"html"];
        NSString* htmlCont=[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        NSString* title;
        NSString* imgUrl;
        NSString* des;
        if (_imgDetails!=nil||_slideArtDetails!=nil) {
            if (_slideArtDetails!=nil) {
                title=_slideArtDetails.imgTitle;
                imgUrl=_slideArtDetails.imgUrl;
                des=_slideArtDetails.imgDes;
            }if (_imgDetails!=nil) {
                title=_imgDetails.ImgTopic;
                imgUrl=_imgDetails.imgUrl;
                des=_imgDetails.imgDes;
            }
            NSString* htmlCont1=[self loadHtml:htmlCont pattern:@"BiaoTi" templeStr:title];
            NSString* htmlCont2=[self loadHtml:htmlCont1 pattern:@"IMGURL" templeStr:imgUrl];
            NSString* htmlCont3=[self loadHtml:htmlCont2 pattern:@"ArtContent" templeStr:des];
            [_WKWebViewCell.contentWebView loadHTMLString:htmlCont3 baseURL:baseUrl];
        }
    }
    

}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(RTWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType{
//    if ([request.URL.absoluteString hasPrefix:@"file"]) {
//        return YES;
//    }
    
//    [self.navigationController handleURL:request.URL name:nil];
//    return [request.URL.absoluteString isEqualToString:@"about:blank"];
    return YES;
}
- (void)webViewDidFinishLoad:(RTWebView *)webView{
    if (_isFinshDisplayH5)
    {
        return;
    }
    [YJProgressHUD hide];
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(NSNumber* result, NSError *err) {
        CGFloat webViewHeight = [result floatValue];
        _webViewHeight = webViewHeight;
        dispatch_async(dispatch_get_main_queue(), ^{
            _isFinshDisplayH5 = YES;
            NSIndexPath* indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
}
- (void)webView:(RTWebView *)webView didFailLoadWithError:(NSError *)error{
     NSLog(@"%@",error);
}
#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendComment:textField.text];
    [textField resignFirstResponder];
    return YES;
}
@end
