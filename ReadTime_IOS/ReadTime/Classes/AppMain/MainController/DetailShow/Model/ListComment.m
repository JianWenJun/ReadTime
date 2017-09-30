//
//  ListComment.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ListComment.h"
#import "Comment.h"
@implementation ListComment

+ (NSDictionary*)mj_objectClassInArray{
    return @{
             @"results":[Comment class]
             };
}

@end
