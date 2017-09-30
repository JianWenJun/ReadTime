//
//  CommentCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *face;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentH;


@property (strong,nonatomic)Comment* commentM;

@end
