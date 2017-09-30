//
//  UIImage+ImageRoundedCorner.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/16.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "UIImage+ImageRoundedCorner.h"

@implementation UIImage (ImageRoundedCorner)
- (UIImage*) imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners  cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx, path.CGPath);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathStroke);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
}


// CGContext 裁剪
- (UIImage *)CGContextClip:(UIImage *)img cornerRadius:(CGFloat)c {
    int w = img.size.width * img.scale;
    int h = img.size.height * img.scale;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, c);
    CGContextAddArcToPoint(context, 0, 0, c, 0, c);
    CGContextAddLineToPoint(context, w-c, 0);
    CGContextAddArcToPoint(context, w, 0, w, c, c);
    CGContextAddLineToPoint(context, w, h-c);
    CGContextAddArcToPoint(context, w, h, w-c, h, c);
    CGContextAddLineToPoint(context, c, h);
    CGContextAddArcToPoint(context, 0, h, 0, h-c, c);
    CGContextAddLineToPoint(context, 0, c);
    CGContextClosePath(context);
    
    CGContextClip(context);     // 先裁剪 context，再画图，就会在裁剪后的 path 中画
    [img drawInRect:CGRectMake(0, 0, w, h)];       // 画图
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ret;
}

// UIBezierPath 裁剪
- (UIImage *)UIBezierPathClip:(UIImage *)img cornerRadius:(CGFloat)c {
    int w = img.size.width * img.scale;
    int h = img.size.height * img.scale;
    CGRect rect = CGRectMake(0, 0, w, h);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:c] addClip];
    [img drawInRect:rect];
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ret;
}

@end
