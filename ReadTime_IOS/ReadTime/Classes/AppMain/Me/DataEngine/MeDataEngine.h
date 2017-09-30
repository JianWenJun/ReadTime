//
//  MeDataEngine.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeDataEngine : NSObject

//获取验证码，1表示注册验证码，2表示重置密码的验证码
+ (RTBaseDataEngine *)control:(NSObject *)control
                         phoneNum:(NSString*)phoneNum
                       typeID:(NSInteger)type
                     complete:(CompletionDataBlock)responseBlock;
//填写用户信息，1表示注册信息，2表示重置密码信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                     phoneNum:(NSString*)phoneNum
                     code:(NSString*)code
                     passW:(NSString*)passW
                    typeID:(NSInteger)type
                  complete:(CompletionDataBlock)responseBlock;
//登录用户信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                     phoneNum:(NSString*)phoneNum
                        passW:(NSString*)passW
                     complete:(CompletionDataBlock)responseBlock;

@end
