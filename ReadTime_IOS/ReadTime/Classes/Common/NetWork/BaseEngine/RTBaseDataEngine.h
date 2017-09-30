//
//  RTBaseDataEngine.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTBaseDataEngine : NSObject

/**
 取消self的hash网络请求
 */
- (void)cancelRequest;
/**
 *  下面的区分get/post/upload/download只是为了上层Engine调用方便，实现都是一样的
 */
///get ／post

+ (RTBaseDataEngine*)control:(NSObject*)control
      callAPIWithServiceType:(RTServiceType)serviceType
                        path:(NSString*)path
                       param:(NSDictionary*)parameters
                 requestType:(RTAPIManagerRequestType)requestType
                   alertType:(DataEngineAlertType)alertType
               progressBlock:(ProgressBlock)progressBlock
                    complete:(CompletionDataBlock)responseBlock
      errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndex;

//up//
+ (RTBaseDataEngine *)control:(NSObject *)control
     uploadAPIWithServiceType:(RTServiceType)serviceType
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                 dataFilePath:(NSData *)dataFilePath
                     dataName:(NSString *)dataName
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                  requestType:(RTAPIManagerRequestType)requestType
                    alertType:(DataEngineAlertType)alertType
          uploadProgressBlock:(ProgressBlock)uploadProgressBlock
        downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                     complete:(CompletionDataBlock)responseBlock
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock;
@end
