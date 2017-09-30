//
//  DetailAuthorCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/27.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface DetailAuthorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *authorImg;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *authorSign;
@property (weak, nonatomic) IBOutlet UILabel *collectNum;

@property (nonatomic,strong)User* user;
@property (nonatomic,assign)NSInteger collectCount;

@end
