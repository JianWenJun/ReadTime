//
//  BaseCollectionViewCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
+ (float)getCellFrame:(id)msg;

- (void)setData:(id)data delegate:(id)delegate;

@end
