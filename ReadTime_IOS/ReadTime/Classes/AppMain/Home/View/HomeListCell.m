//
//  HomeListCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/20.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "HomeListCell.h"
#import "Article.h"

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    // Initialization code
}
- (void)setData:(id)data delegate:(id)delegate{
    if ([data isKindOfClass:[NSDictionary class]]) {
        if ([data[@"data"] isKindOfClass:[Article class]]) {
            Article* art=data[@"data"];
            [_titleHeader setText:art.articleHeader];
            [_titleHeader sizeToFit];
            NSString* artContent=art.articleContent;
            [self setPhotots:artContent];
        }
    }
}
- (void)setPhotots:(NSString*)content{
    if (content==nil||[content isEqual:@""]) {
        return;
    }
    if ([[content substringToIndex:1] isEqual:@"["]) {
//        _flowPhotosView.translatesAutoresizingMaskIntoConstraints=NO;
        _flowPhotosView.hidden=NO;
        _artContent.hidden=YES;
//        self.PhotoWidth.constant=SCREEN_WIDTH-2*10;
        self.PhotoConstraint.constant=circleCellPhotosWH;
        self.artContentConstraint.constant=0;
        _flowPhotosView.photoWidth=circleCellPhotosWH;
        _flowPhotosView.photoHeight=circleCellPhotosWH;
        _flowPhotosView.photoMargin=5;
        NSString *newStr = [content stringByReplacingOccurrencesOfString:@"'" withString:@""];//去除‘
        NSString *newStr1 = [newStr stringByReplacingOccurrencesOfString:@" " withString:@""];//去除空格

        NSString * imgStr=[newStr1 substringWithRange:NSMakeRange(1, newStr1.length-2)];
        NSArray* arry=[imgStr componentsSeparatedByString:@","];
        _flowPhotosView.thumbnailUrls=arry;
        _flowPhotosView.originalUrls=arry;
        
    }else{
        _artContent.hidden=NO;
        _flowPhotosView.hidden=YES;
//        self.PhotoWidth.constant=0;
        self.PhotoConstraint.constant=0;
        self.artContentConstraint.constant=100;
        [_artContent setText:content];
        [_artContent sizeToFit];
        
    }
}
@end
