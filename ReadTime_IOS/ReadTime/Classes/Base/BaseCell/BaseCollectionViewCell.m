//
//  BaseCollectionViewCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell
- (void)awakeFromNib{
    [super awakeFromNib];
}
- (void)setData:(id)data delegate:(id)delegate{
    
}
+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (float)getCellFrame:(id)msg {
    if ([msg isKindOfClass:[NSNumber class]]) {
        NSNumber *number = msg;
        float height = number.floatValue;
        if (height > 0) {
            return height;
        }
    }
    return 44;
}


@end
