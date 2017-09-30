//
//  WaterFallCollectionLayout.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^itemHeightBlock)(NSIndexPath* index);

@interface WaterFallCollectionLayout : UICollectionViewLayout

@property(nonatomic,strong)itemHeightBlock heightBlock;
@property(nonatomic,assign,readonly)CGFloat itemWidth;

- (instancetype)initWithItemHeightBlock:(itemHeightBlock)block;

@end
