//
//  WPImageMetaViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/12.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WPImageMeta;
@class WPImageMetaViewController;
@protocol WPImageMetaViewControllerDelegate <NSObject>

- (void)imageMetaViewController:(WPImageMetaViewController*)controller
       didFinshEditingImageMeta:(WPImageMeta*)imageMeta;

@end

@interface WPImageMetaViewController : UIViewController

@property(nonatomic,weak)id<WPImageMetaViewControllerDelegate>delegate;
@property(nonatomic,strong)WPImageMeta* imageMeta;

@end
