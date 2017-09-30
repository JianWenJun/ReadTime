//
//  ListArticle.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ListArticle.h"
#import "Article.h"
@implementation ListArticle

+ (NSDictionary*)mj_objectClassInArray{
    return @{
             @"results":[Article class]
             };
}
@end
