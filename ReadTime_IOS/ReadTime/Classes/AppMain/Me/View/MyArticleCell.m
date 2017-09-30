//
//  MyArticleCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/5.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "MyArticleCell.h"

@implementation MyArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ArticleModel *)model{
    self.title.text=model.artTitle;
    self.data.text=[UserConfig getDate:[UserConfig dateFromISO8601String:model.createdAt]];
}
@end
