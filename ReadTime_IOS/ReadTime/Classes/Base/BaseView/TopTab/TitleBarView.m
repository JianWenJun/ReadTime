//
//  TitleBarView.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "TitleBarView.h"
#define kMaxBtnWidth 80
@interface TitleBarView()

@property (nonatomic,assign)BOOL isNeedScroll;

@end
@implementation TitleBarView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles{
    self=[super initWithFrame:frame];
    if (self) {
        [self reloadAllButtonsofTitleBarWithTitles:titles];
        self.showsHorizontalScrollIndicator=NO;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andNeedScroll:(BOOL)isNeedScroll{
    _isNeedScroll=isNeedScroll;
    return [self initWithFrame:frame andTitles:titles];
}
- (void)reloadAllButtonsofTitleBarWithTitles:(NSArray *)titles{
    if (_titleButtons) {
        NSArray* btns=_titleButtons.copy;
        for (UIButton* btn in btns) {
            [btn removeFromSuperview];
        }
    }else{
        _titleButtons=[NSMutableArray arrayWithCapacity:titles.count];
    }
    _currentIndex=0;
    _titleButtons=[NSMutableArray new];
    CGFloat buttonHeight = self.frame.size.height;
    CGFloat buttonWidth = self.frame.size.width / titles.count;
    if(titles.count * kMaxBtnWidth > self.frame.size.width){
        self.contentSize = CGSizeMake(titles.count * kMaxBtnWidth, self.frame.size.height);
        buttonWidth = kMaxBtnWidth;
    }else if(_isNeedScroll){
        self.contentSize = CGSizeMake(self.frame.size.width + 1, self.frame.size.height);
        if (titles.count != 4) {
            buttonWidth = kMaxBtnWidth;
        }
    }else{
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    [titles enumerateObjectsUsingBlock:^(NSString* title,NSUInteger index,BOOL* stop){
        UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:UIColorFromHex(0x909090) forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame=CGRectMake(buttonWidth *index, 0, buttonWidth, buttonHeight);
        button.tag=index;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButtons addObject:button];
        [self addSubview:button];
        [self sendSubviewToBack:button];
    }];
    UIButton* firstBtn=_titleButtons[0];
    [firstBtn setTitleColor:UIToneBackgroundColor forState:UIControlStateNormal];
    
};
- (void)onClick:(UIButton*)button{
    if (_currentIndex!=button.tag) {
        [self scrollToCenterWithIndex:button.tag];
        _titleButtonClicked(button.tag);
    }
}
- (void)scrollToCenterWithIndex:(NSInteger)index{
    UIButton *preTitle = _titleButtons[_currentIndex];
    [preTitle setTitleColor:UIColorFromHex(0x909090) forState:UIControlStateNormal];
    _currentIndex = index;
    UIButton *firstTitle = _titleButtons[index];
    [firstTitle setTitleColor:UIToneBackgroundColor forState:UIControlStateNormal];
    UIButton *button = [self viewWithTag:index];
    if (self.contentSize.width > self.frame.size.width) {
        if (CGRectGetMidX(button.frame) < SCREEN_SIZE.width / 2) {
            [self setContentOffset:CGPointZero animated:YES];
        }else if (self.contentSize.width - CGRectGetMidX(button.frame) < SCREEN_SIZE.width / 2){
            [self setContentOffset:CGPointMake(self.contentSize.width - CGRectGetWidth(self.frame), 0) animated:YES];
        }else{
            CGFloat needScrollWidth = CGRectGetMidX(button.frame) - self.contentOffset.x - SCREEN_SIZE.width / 2;
            [self setContentOffset:CGPointMake(self.contentOffset.x + needScrollWidth, 0) animated:YES];
        }
    }
}

- (void)setTitleButtonsColor
{
    for (UIButton *button in self.subviews) {
        button.backgroundColor = UIColorFromHex(0xf6f6f6);
    }
}
@end
