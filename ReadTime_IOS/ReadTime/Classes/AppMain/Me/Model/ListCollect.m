//
//  ListCollect.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/5.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ListCollect.h"
#import "Collectinfo.h"
@implementation ListCollect

+ (NSDictionary*)mj_objectClassInArray{
    //    NSLog(@"inArray----------------");
    return @{
             @"results":[Collectinfo class]
             };
}

@end
