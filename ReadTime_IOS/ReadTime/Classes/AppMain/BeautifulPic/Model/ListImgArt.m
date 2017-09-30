//
//  ListImgArt.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ListImgArt.h"
#import "ImgBea.h"

@implementation ListImgArt

+ (NSDictionary*)mj_objectClassInArray{
    return @{
             @"results":[ImgBea class]
             };
}

@end
