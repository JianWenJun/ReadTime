//
//  ListUser.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/29.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ListUser.h"
#import "User.h"
@implementation ListUser

+ (NSDictionary*)mj_objectClassInArray{
    return @{
             @"results":[User class]
             };
}
@end
