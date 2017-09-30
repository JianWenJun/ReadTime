//
//  RTAppContext.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/20.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
//应用基本信息
#import <Foundation/Foundation.h>

@interface RTAppContext : NSObject
@property (nonatomic, copy) NSString *channelID;    //渠道号
@property (nonatomic, copy) NSString *appName;      //应用名称
@property (nonatomic, copy) NSString *user_id;      //


@property (nonatomic, copy, readonly) NSString *city_id;          //城市id
@property (nonatomic, copy, readonly) NSString *device_name;            //设备名称
@property (nonatomic, copy, readonly) NSString *os_name;            //系统名称
@property (nonatomic, copy, readonly) NSString *os_version;            //系统版本
@property (nonatomic, copy, readonly) NSString *bundle_version;           //Bundle版本
@property (nonatomic, copy, readonly) NSString *app_client_id;         //请求来源，值都是@"mobile"
@property (nonatomic, copy, readonly) NSString *device_model;      //操作系统类型
@property (nonatomic, copy, readonly) NSString *qtime;        //发送请求的时间
@property (nonatomic, copy, readonly) NSString *device_id;
@property (nonatomic, readonly) BOOL isReachable;


+ (instancetype)sharedInstance;
@end
