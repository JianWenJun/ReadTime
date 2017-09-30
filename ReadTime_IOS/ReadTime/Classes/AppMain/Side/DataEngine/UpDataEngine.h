//
//  UpFeedBackDataEngine.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedBackModel.h"
#import "ArticleModel.h"
@interface UpDataEngine : NSObject


//提交反馈信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                         feedBackModel:(FeedBackModel*)model
                     complete:(CompletionDataBlock)responseBlock;
//只上传文件
+ (RTBaseDataEngine*)control:(NSObject *)control
                dataFilePath:(NSData *)dataFilePath
                    fileName:(NSString *)fileName
                    mimeType:(NSString *)mimeType
                    complete:(CompletionDataBlock)responseBlock;
//更改用户信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                userName:(NSString*)name
                         sign:(NSString*)sign
                     complete:(CompletionDataBlock)responseBlock;

//提交文章信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                     artModel:(ArticleModel*)model
                     complete:(CompletionDataBlock)responseBlock;

@end
