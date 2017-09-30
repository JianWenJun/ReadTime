//
//  UserConfig.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/25.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;

@interface UserConfig : NSObject

+ (void)saveProfile:(UserInfo*)user;
+ (void)updateProfile:(UserInfo*)user;
+ (void)clearProfile;
+ (UserInfo*)myProfile;

+ (void)saveUserImg:(UIImage*)portrait;
+ (NSInteger)getUserID;
+ (NSString*)getUserName;
+ (NSString*)getSessionTocken;
+ (NSString*)getUserObjectID;
+ (UIImage *)getPortrait;
+ (NSString*)getUserIMgurl;
+ (BOOL)IsLogin;
+ (NSDate *)dateFromISO8601String:(NSString *)string;
+ (NSString*)getDate:(NSDate*)data;
+ (NSString*)getCurrent;
@end
