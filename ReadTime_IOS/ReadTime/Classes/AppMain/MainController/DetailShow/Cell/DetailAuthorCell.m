//
//  DetailAuthorCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/27.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "DetailAuthorCell.h"
#import "UIImageView+WebCache.h"

@implementation DetailAuthorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUser:(User *)user{
    [_authorImg setIsRound:YES withSize:CGSizeMake(36, 36)];
    [_authorImg sd_setImageWithURL:[NSURL URLWithString:user.headUrl]];
    _authorName.text=user.username;
    _authorSign.text=user.signature;
}
- (void)setCollectCount:(NSInteger)collectCount{
    NSString* str=[NSString stringWithFormat:@"该文章被收藏%ld次",collectCount];
    _collectNum.text=str;
}
@end
