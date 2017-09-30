//
//  ImgBeaCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionViewCell.h"
@interface ImgBeaCell : BaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *imgDes;

@end
