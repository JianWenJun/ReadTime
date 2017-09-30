//
//  UIImageView+ImageViewCorner.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/16.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageViewCorner)

- (void)adddCorner:(CGFloat)radius;
- (void)loadPortrait:(NSURL *)portraitURL;
- (void)loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius;
@end
