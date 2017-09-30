//
//  ListSlideArticle.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/17.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ListSlideArticle.h"
#import "SlideArticle.h"

@implementation ListSlideArticle
//- (void)mj_keyValuesDidFinishConvertingToObject{
//    NSLog(@"finish-----");
//
//}

+ (NSDictionary*)mj_objectClassInArray{
//    NSLog(@"inArray----------------");
    return @{
             @"results":[SlideArticle class]
             };
}
//+ (NSDictionary *)replacedKeyFromPropertyName
//
//{
//    
//    return @{@"slides" : @"results"};
//    
//}
@end
