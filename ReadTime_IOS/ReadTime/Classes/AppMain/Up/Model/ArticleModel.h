//
//  ArticleModel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/11.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleModel : BaseModel
//
//@property (nonatomic,copy)NSString* userID;
//@property (nonatomic,copy)NSString *article_id;
//@property (nonatomic,copy)NSString* createTime;
//@property(nonatomic,copy)NSString *publishedTime;
//@property(nonatomic,copy)NSString *title;
//@property(nonatomic,copy)NSString *content;
//@property(nonatomic,copy)NSString *cover_image_url;//封面URL
@property (nonatomic, copy)NSString* imgUrl;
@property (nonatomic, copy)NSString* artContent;
@property (nonatomic,copy)NSString* artTitle;
@property (nonatomic, copy)NSString* userName;
@property (nonatomic,assign)NSInteger userID;

@end
