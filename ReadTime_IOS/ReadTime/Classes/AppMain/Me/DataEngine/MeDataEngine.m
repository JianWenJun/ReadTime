//
//  MeDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "MeDataEngine.h"

@implementation MeDataEngine
//获取验证码，1表示注册验证码，2表示重置密码的验证码
+ (RTBaseDataEngine*)control:(NSObject *)control phoneNum:(NSString *)phoneNum typeID:(NSInteger)type complete:(CompletionDataBlock)responseBlock{
    NSLog(@"电话号码：%@",phoneNum);
    NSDictionary *param=@{
                          @"mobilePhoneNumber":phoneNum,
                          @"ttl":@(3),
                          @"name":@"ReadTime",
                          @"op":@"注册"
                          };
    NSString* path=@"requestSmsCode";
    if (type==2) {
        path=@"requestPasswordResetBySmsCode";
    }
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
//填写用户信息，1表示注册信息，2表示重置密码信息
+ (RTBaseDataEngine*)control:(NSObject *)control phoneNum:(NSString *)phoneNum code:(NSString *)code passW:(NSString *)passW typeID:(NSInteger)type complete:(CompletionDataBlock)responseBlock{
    if (type==1) {
        NSDictionary *param=@{
                              @"mobilePhoneNumber":phoneNum,
                              @"smsCode":code,
                              @"password":passW
                              };
        return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"usersByMobilePhone" param:param requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
    }else  {
        NSString* path=[NSString stringWithFormat:@"resetPasswordBySmsCode/%@",code];
        NSDictionary *param=@{
                              @"password":passW
                              };
        return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypePut alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
    }
}
//登录用户信息
+ (RTBaseDataEngine*)control:(NSObject *)control phoneNum:(NSString *)phoneNum  passW:(NSString *)passW complete:(CompletionDataBlock)responseBlock{
    NSDictionary *param=@{
                          @"mobilePhoneNumber":phoneNum,
                          @"password":passW
                          };
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"login" param:param requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}

@end
