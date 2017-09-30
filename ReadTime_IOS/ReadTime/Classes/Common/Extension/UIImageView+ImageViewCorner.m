//
//  UIImageView+ImageViewCorner.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/16.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "UIImageView+ImageViewCorner.h"
#import "UIImage+ImageRoundedCorner.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (ImageViewCorner)
- (void)adddCorner:(CGFloat)radius{
//    self.image=[self.image imageAddCornerWithRadius:radius andSize:self.bounds.size];
    self.image=[self.image UIBezierPathClip:self.image cornerRadius:radius];
}
- (void)loadPortrait:(NSURL *)portraitURL{
     [self sd_setImageWithURL:portraitURL placeholderImage:[UIImage imageNamed:@"default_home_header"] options:0];
}
- (void)loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius{
    
    NSURL *url;
    
    if (placeHolderStr == nil) {
        placeHolderStr = @"default_head";
    }
    url=[NSURL URLWithString:urlStr];
    if (radius != 0.0) {
                //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image=cacheImage;
        }else{
            [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    
                    UIImage* radiusImage=[self.image imageAddCornerWithRadius:radius andSize:self.frame.size];
                    [[SDImageCache sharedImageCache]storeImage:radiusImage forKey:cacheurlStr];
                    //清除原有非圆角图片缓存
                    [[SDImageCache sharedImageCache] removeImageForKey:urlStr];
                }
            }];
        }
        
    }

}

@end
