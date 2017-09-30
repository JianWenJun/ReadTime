//
//  ImgBea.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseModel.h"

@interface ImgBea : BaseModel

@property (copy,nonatomic)NSString* imgDes;
@property (copy,nonatomic)NSString* ImgTopic;
@property (copy,nonatomic)NSString* imgUrl;
@property (assign,nonatomic)NSUInteger userID;
@property (assign,nonatomic)NSUInteger collectNum;
@property (assign,nonatomic)NSUInteger commentNum;
@property (assign,nonatomic)NSUInteger imgArtID;
@property (assign,nonatomic)NSUInteger typeID;

@end
