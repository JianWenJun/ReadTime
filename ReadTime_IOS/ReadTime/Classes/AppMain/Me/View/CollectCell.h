//
//  CollectCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/4.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collectinfo.h"
@interface CollectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *typeName;

@property (strong,nonatomic)Collectinfo* collect;

@end
