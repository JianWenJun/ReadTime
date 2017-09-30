//
//  HomeListCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/20.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "PYPhotosView.h"
@interface HomeListCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleHeader;
@property (weak, nonatomic) IBOutlet PYPhotosView *flowPhotosView;
@property (weak, nonatomic) IBOutlet UILabel *artContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PhotoConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *artContentConstraint;


@end
