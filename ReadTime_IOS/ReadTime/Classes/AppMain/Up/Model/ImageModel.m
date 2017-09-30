//
//  ImageModel.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/13.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
+ (ImageModel *)ittemModelWithImage:(UIImage *)image imageUrl:(NSString *)imageUrl isDelete:(BOOL)isDelete {
    ImageModel *model = [ImageModel new];
    model.image = image;
    NSString *str = kSafeString(imageUrl);
    str = [str stringByReplacingOccurrencesOfString:@"!small9" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"!dplist" withString:@""];
    model.imageUrl = str;
    model.isDelete = isDelete;
    return model;
}

@end
