//
//  UpArticleViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "WPEditorViewController.h"

#import "ArticleModel.h"
@interface UpArticleViewController : WPEditorViewController<WPEditorViewControllerDelegate>

@property(nonatomic,strong)ArticleModel* model;

@end
