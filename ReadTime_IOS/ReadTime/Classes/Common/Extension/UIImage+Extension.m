//
//  UIImage+Extension.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "UIImage+Extension.h"
#import "UIImage-Extension.h"


@implementation UIImage (Extension)
+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//1000PX以下不缩放； 1000-2000PX缩放至1/2大小；2000-4800PX缩放至1/4大小；4800PX以上缩放至1/8大小。
+ (UIImage *)imageCompressionRatio:(UIImage *)image {
    int width = image.size.width;
    int height = image.size.height;
    
    float size;
    if (width > height) {
        size = width;
    } else {
        size = height;
    }
    
    UIImage *croppedImage;
    if (size > 4800) {
        croppedImage = [image imageCompressForSize:image targetSize:CGSizeMake(image.size.width/8, image.size.height/8)];
    } else if (size > 2000) {
        croppedImage = [image imageCompressForSize:image targetSize:CGSizeMake(image.size.width/4, image.size.height/4)];
    } else if (size > 1000) {
        croppedImage = [image imageCompressForSize:image targetSize:CGSizeMake(image.size.width/2, image.size.height/2)];
    } else {
        croppedImage = [image imageCompressForSize:image targetSize:CGSizeMake(image.size.width, image.size.height)];
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation != UIDeviceOrientationPortrait) {
        
        CGFloat degree = 0;
        if (orientation == UIDeviceOrientationPortraitUpsideDown) {
            degree = 180;// M_PI;
        } else if (orientation == UIDeviceOrientationLandscapeLeft) {
            degree = -90;// -M_PI_2;
        } else if (orientation == UIDeviceOrientationLandscapeRight) {
            degree = 90;// M_PI_2;
        }
        croppedImage = [croppedImage rotatedByDegrees:degree];
    }
    
    NSLog(@"width:%f height:%f",croppedImage.size.width,croppedImage.size.height);
    
    return croppedImage;
}
- (UIImage *)rotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
static inline CGFloat DegreesToRadians(CGFloat degrees)
{
    return M_PI * (degrees / 180.0);
}
//改变图片颜色
- (UIImage *)imageToColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
