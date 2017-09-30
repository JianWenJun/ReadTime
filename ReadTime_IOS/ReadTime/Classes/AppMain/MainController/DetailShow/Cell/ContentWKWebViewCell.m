//
//  ContentWKWebViewCellTableViewCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/27.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ContentWKWebViewCell.h"
#import "RTWebView.h"
@implementation ContentWKWebViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        RTWebView* contentView=[[RTWebView alloc]initWithFrame:CGRectZero usingUIWebView:NO];
        contentView.userInteractionEnabled=YES;
        [contentView.scrollView setBounces:NO];
        [contentView.scrollView setScrollEnabled:NO];
        [self.contentView addSubview:contentView];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint* leftC=[NSLayoutConstraint constraintWithItem:contentView
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0f
                                                                constant:16];
        NSLayoutConstraint* rightC=[NSLayoutConstraint constraintWithItem:contentView
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0f
                                                                constant:-16];
        NSLayoutConstraint* topC=[NSLayoutConstraint constraintWithItem:contentView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0f
                                                                constant:4];
        NSLayoutConstraint* BottomC=[NSLayoutConstraint constraintWithItem:contentView
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0f
                                                                constant:-16];
        
        [self.contentView addConstraint:leftC];
        [self.contentView addConstraint:rightC];
        [self.contentView addConstraint:topC];
        [self.contentView addConstraint:BottomC];
        _contentWebView=contentView;
    }
    return self;
}
@end
