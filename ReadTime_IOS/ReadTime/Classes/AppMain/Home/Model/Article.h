//
//  Article.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseModel.h"

@interface Article : BaseModel

@property (copy,nonatomic)NSString* articleContent;
@property (copy,nonatomic)NSString* articleHeader;
@property (copy,nonatomic)NSString* articleUrl;
@property (assign,nonatomic)NSUInteger userID;
@property (assign,nonatomic)NSUInteger collectNum;
@property (assign,nonatomic)NSUInteger commentNum;
@property (assign,nonatomic)NSUInteger articleID;
@property (assign,nonatomic)NSUInteger typeID;


@end
