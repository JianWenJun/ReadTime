//
//  CommmentAndCollectDataEngine.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/28.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommmentAndCollectDataEngine : NSObject

//通过文章ID在收藏表查找收藏数
+ (RTBaseDataEngine *)control:(NSObject *)control
                     objectIDinCollect:(NSString*)objectID
                     complete:(CompletionDataBlock)responseBlock;

//通过文章ID在评论表查找评论,和评论数
+ (RTBaseDataEngine *)control:(NSObject *)control
                     objectIDinComment:(NSString*)objectID
                     complete:(CompletionDataBlock)responseBlock;

//通过当前登录用户ID和文章ID在收藏表查找收藏记录
+ (RTBaseDataEngine *)control:(NSObject *)control
            objectIDinCollect:(NSString*)objectID
                       userID:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock;

//添加收藏
+ (RTBaseDataEngine *)control:(NSObject *)control
            objectIDinCollect:(NSString*)objectID//收藏的文字objectID
                       userID:(NSInteger)userID//收藏用户ID
                      artType:(NSInteger)typeID
                   collectDes:(NSString*)collectDes
                     complete:(CompletionDataBlock)responseBlock;
//取消收藏
+ (RTBaseDataEngine *)control:(NSObject *)control
            objectIDinCollectCancel:(NSString*)objectID//收藏的文字objectID
                     complete:(CompletionDataBlock)responseBlock;

//
//添加评论
+ (RTBaseDataEngine *)control:(NSObject *)control
            objectIDinComment:(NSString*)objectID
                       userName:(NSString*)username
                       userID:(NSInteger)userID
               commentContent:(NSString*)content
                     complete:(CompletionDataBlock)responseBlock;
//删除评论
+ (RTBaseDataEngine *)control:(NSObject *)control
      objectIDinCommentCancel:(NSString*)objectID//收藏的文字objectID
                     complete:(CompletionDataBlock)responseBlock;

//通过用户ID查找收藏记录
+ (RTBaseDataEngine *)control:(NSObject *)control
            userIDinCollect:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock;

//通过用户ID查找评论记录
+ (RTBaseDataEngine *)control:(NSObject *)control
              userIDinComment:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock;
//通过用户ID查找发布文章记录
+ (RTBaseDataEngine *)control:(NSObject *)control
              userIDinPreArticle:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock;
@end
