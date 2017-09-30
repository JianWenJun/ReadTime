//
//  SingleArtileDataEngine.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/28.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleArtileOrImgDataEngine : NSObject
//通过objectID获取美图或者文章,或者轮播图
+ (RTBaseDataEngine *)control:(NSObject *)control
                         objectID:(NSString*)objectID
                        type:(NSInteger)typeID
                     complete:(CompletionDataBlock)responseBlock;

//通过发布的文字的用户ID查找用户信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                     userID:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock;

@end
