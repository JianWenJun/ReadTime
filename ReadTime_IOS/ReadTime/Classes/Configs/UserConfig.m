//
//  UserConfig.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/25.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "UserConfig.h"
#import "UserInfo.h"
@implementation UserConfig

+ (void)saveProfile:(UserInfo *)user{
    NSUserDefaults* userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:user.username forKey:@"username"];
    [userDefault setObject:user.sessionToken forKey:@"sessionToken"];
    [userDefault setObject:user.objectId forKey:@"objectId"];
    [userDefault setObject:user.headUrl forKey:@"headUrl"];
    [userDefault setObject:user.signature forKey:@"signature"];
    [userDefault setInteger:user.userID forKey:@"userID"];
    [userDefault synchronize];
}
+ (void)updateProfile:(UserInfo *)user{
    NSUserDefaults* userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:user.username forKey:@"username"];
    [userDefault setObject:user.sessionToken forKey:@"sessionToken"];
    [userDefault setObject:user.objectId forKey:@"objectId"];
    [userDefault setObject:user.headUrl forKey:@"headUrl"];
    [userDefault setObject:user.signature forKey:@"signature"];
    [userDefault setInteger:user.userID forKey:@"userID"];
    [userDefault synchronize];
}
+ (void)clearProfile{
    NSUserDefaults* userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"" forKey:@"username"];
    [userDefault setObject:@"" forKey:@"sessionToken"];
    [userDefault setObject:@"" forKey:@"objectId"];
    [userDefault setObject:@"" forKey:@"headUrl"];
    [userDefault setObject:@"" forKey:@"signature"];
    [userDefault setInteger:0 forKey:@"userID"];
    [userDefault synchronize];
}

+ (UserInfo *)myProfile{
    UserInfo* userInfo=[[UserInfo alloc]init];
    NSUserDefaults* userDefault=[NSUserDefaults standardUserDefaults];
    userInfo.userID=[userDefault integerForKey:@"userID"];
    userInfo.sessionToken=[userDefault objectForKey:@"sessionToken"];
    userInfo.username=[userDefault objectForKey:@"username"];
    userInfo.objectId=[userDefault objectForKey:@"objectId"];
    userInfo.headUrl=[userDefault objectForKey:@"headUrl"];
    userInfo.signature=[userDefault objectForKey:@"signature"];
    return userInfo;
}
+ (void)saveUserImg:(UIImage *)portrait{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:UIImageJPEGRepresentation(portrait, 1) forKey:@"img"];
    
    [userDefaults synchronize];
}

+ (NSInteger)getUserID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"userID"];
}

+ (NSString*)getUserName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"username"];
}
+ (NSString *)getUserObjectID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"objectId"];
}
+ (NSString *)getSessionTocken{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"sessionToken"];
}
+ (UIImage *)getPortrait{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"img"];
}
+ (NSString *)getUserIMgurl{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"headUrl"];
}
+ (BOOL)IsLogin{
    if ([UserConfig getUserObjectID]==nil||[[UserConfig getUserObjectID]isEqualToString:@""]) {
        return NO;
    }else return YES;
}

+ (NSDate *)dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    //    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
}
+ (NSString*)getDate:(NSDate*)date{
    if (date==nil) {
        return nil;
    }
    NSDateFormatter *format1=[[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str1=[format1 stringFromDate:date];
    return str1;
}
+ (NSString*)getCurrent{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
@end
