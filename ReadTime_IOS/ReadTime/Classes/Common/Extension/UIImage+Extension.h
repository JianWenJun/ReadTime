//
//  UIImage+Extension.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//通过颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageCompressionRatio:(UIImage *)image;
- (UIImage *)imageToColor:(UIColor *)color;

@end
