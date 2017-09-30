//
//  TitleBarView.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleBarView : UIScrollView

@property (nonatomic,strong)NSMutableArray* titleButtons;
@property (nonatomic,assign)NSUInteger currentIndex;
@property (nonatomic,copy) void (^titleButtonClicked)(NSUInteger index);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles;

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles
                andNeedScroll:(BOOL)isNeedScroll;
- (void)setTitleButtonsColor;
- (void)scrollToCenterWithIndex:(NSInteger)index;

//reset
- (void)reloadAllButtonsofTitleBarWithTitles:(NSArray *)titles;


@end
