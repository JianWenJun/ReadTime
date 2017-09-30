//
//  SlideArticle.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
//轮播图的文章
#import "BaseModel.h"

@interface SlideArticle : BaseModel

@property (copy,nonatomic)NSString* imgTitle;
@property (copy,nonatomic)NSString* imgDes;
@property (copy,nonatomic)NSString* imgUrl;
@property (assign,nonatomic)NSUInteger userID;
@property (assign,nonatomic)NSUInteger collectNum;
@property (assign,nonatomic)NSUInteger commentNum;
@property (assign,nonatomic)NSUInteger larticleID;


@end
