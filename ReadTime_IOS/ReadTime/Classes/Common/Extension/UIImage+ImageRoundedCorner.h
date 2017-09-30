//
//  UIImage+ImageRoundedCorner.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/16.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageRoundedCorner)
//添加圆角的方法，并返回UIimage
- (UIImage*) imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;
- (UIImage*) CGContextClip:(UIImage*)img cornerRadius:(CGFloat)c;
- (UIImage*) UIBezierPathClip:(UIImage*)img cornerRadius:(CGFloat)c;
@end
