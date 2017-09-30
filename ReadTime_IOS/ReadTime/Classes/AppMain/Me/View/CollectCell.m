//
//  CollectCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/4.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "CollectCell.h"

@implementation CollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCollect:(Collectinfo *)collect{
    self.title.text=collect.CollectDes;
    NSInteger type=collect.desTypeID;
    if (type==1) {
        [self.typeImg setImage:[UIImage imageNamed:@"collect_wen"]];
        self.typeName.text=@"文";
    }else if (type==2){
        [self.typeImg setImage:[UIImage imageNamed:@"collect_tu"]];
        self.typeName.text=@"图";
    }else if (type==3){
        [self.typeImg setImage:[UIImage imageNamed:@"collect_lun"]];
        self.typeName.text=@"轮";
    }
}
@end
