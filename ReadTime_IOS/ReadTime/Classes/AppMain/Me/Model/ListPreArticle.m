//
//  ListPreArticle.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/5.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ListPreArticle.h"
#import "ArticleModel.h"
@implementation ListPreArticle
+ (NSDictionary*)mj_objectClassInArray{
    //    NSLog(@"inArray----------------");
    return @{
             @"results":[ArticleModel class]
             };
}

@end
