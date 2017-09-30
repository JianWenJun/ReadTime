//
//  XinLinCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "PYPhotosView.h"
@interface XinLinCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleHeader;
@property (weak, nonatomic) IBOutlet PYPhotosView *showImage;
@property (weak, nonatomic) IBOutlet UILabel *titleContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgConstraint;


@end
