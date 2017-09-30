//
//  RTAPIBaseRequestDataModel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
/**
 *  网络请求参数传递类，只在BaseEngine以下的层次传递使用
 */
#import <Foundation/Foundation.h>

@interface RTAPIBaseRequestDataModel : NSObject

/**
 网络请求参数
 */
@property (strong,nonatomic)NSString *apiMethodPath;//网络请求地址
@property (assign,nonatomic)RTServiceType serviceType;//请求服务器类型对于多服务器的请求
@property (strong,nonatomic)NSDictionary* parameters;//请求参数
@property (assign,nonatomic)RTAPIManagerRequestType requestType;//请求方法
@property (nonatomic,copy)CompletionDataBlock responseBlock;//请求回调

//上传
@property (strong,nonatomic)NSData* dataFilePath;
@property (strong,nonatomic)NSString* dataName;
@property (strong,nonatomic)NSString* filename;
@property (strong,nonatomic)NSString* mimeType;

//下载，上传进度
@property (nonatomic,copy)ProgressBlock uploadProgress;
@property (nonatomic,copy)ProgressBlock downloadProgress;

@end
