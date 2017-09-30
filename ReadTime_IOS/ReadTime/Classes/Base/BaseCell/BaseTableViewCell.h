//
//  BaseTableViewCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SecondHouseCellType){
    SecondHouseCellTypeFirst,
    SecondHouseCellTypeMiddle,
    SecondHouseCellTypeLast,
    SecondHouseCellTypeSingle,
    SecondHouseCellTypeAny,
    SecondHouseCellTypeHaveTop,
    SecondHouseCellTypeHaveBottom,
    SecondHouseCellTypeNone
};
@interface BaseTableViewCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *lineviewTop;//上横线
@property (strong, nonatomic)  UIImageView *lineviewBottom;//下横线,都是用来分隔cell的

- (void)setSeperatorLineForIOS7 :(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection;
- (void)setSeperatorLine:(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection;
- (void)setData:(id)data delegate:(id)delegate;  

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
+ (float)getCellFrame:(id)msg;
@end
