//
//  ApiConfig.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#ifndef ApiConfig_h
#define ApiConfig_h
#if !defined YA_BUILD_FOR_DEVELOP && !defined YA_BUILD_FOR_TEST && !defined YA_BUILD_FOR_RELEASE && !defined YA_BUILD_FOR_PRERELEASE

#define YA_BUILD_FOR_DEVELOP
//#define YA_BUILD_FOR_TEST
//#define YA_BUILD_FOR_PRERELEASE
//#define YA_BUILD_FOR_HOTFIX
//#define YA_BUILD_FOR_RELEASE      //该环境的优先级最高

#endif

#if (defined(DEBUG) || defined(ADHOC) || !defined YA_BUILD_FOR_RELEASE)
#define DELog(format, ...)  NSLog((@"FUNC:%s\n" "LINE:%d\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DELog(format, ...)
#endif

typedef NS_ENUM(NSUInteger, RTServiceType) {
    YAServiceYA,      //A服务器
    YAServiceYB //B服务器
};
/**
 请求类型的枚举
 */
typedef NS_ENUM (NSUInteger, RTAPIManagerRequestType)
{
    
    RTAPIManagerRequestTypeGet,
    RTAPIManagerRequestTypePost,
    RTAPIManagerRequestTypePostUpload,
    RTAPIManagerRequestTypeGetDownload,
    RTAPIManagerRequestTypePut,
    RTAPIManagerRequestTypeDelete,
RTAPIManagerRequestTypePostUserInfo};

/**
 数据显示
 */
typedef NS_ENUM(NSInteger, DataEngineAlertType) {
    DataEngineAlertType_None,
    DataEngineAlertType_Toast,
    DataEngineAlertType_Alert,
    DataEngineAlertType_ErrorView
};

typedef void(^ProgressBlock)(NSProgress* taskProgress);
typedef void(^CompletionDataBlock)(id data,NSError* error);
typedef void(^ErrorAlertSelectIndexBlock)(NSUInteger buttonIndex);

#endif /* ApiConfig_h */
