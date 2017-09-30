//
//  LvXingCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "LvXingCell.h"
#import "Article.h"
@implementation LvXingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(id)data delegate:(id)delegate{
    //    [delegate fd_c
    if ([data isKindOfClass:[NSDictionary class]]) {
        if ([data[@"data"] isKindOfClass:[Article class]]) {
            Article* art=data[@"data"];
            _titleHeader.text=art.articleHeader;
            [self setCellContent:art.articleContent];
        }
    }
}

- (void)setCellContent:(NSString*)content{
    if ([content isEqual:@""]||content==nil) {
        return;
    }
    Boolean isHaveImg=false;
    isHaveImg=[content containsString:@"+"];
    if (isHaveImg) {
        _showImage.hidden=NO;
        NSArray* arrys=[content componentsSeparatedByString:@"+"];
        CGFloat height=(SCREEN_WIDTH-2*10)*300/375;
        _imgConstraint.constant=height;
        _showImage.photosMaxCol=1;
        _showImage.photoWidth=SCREEN_WIDTH-2*10;
        _showImage.photoHeight=height;
        NSRange range=[arrys[1] rangeOfString:@"?"];
        NSString* orgUrl=[arrys[1] substringToIndex:range.location];
        NSString* thumUrl=[arrys[1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _showImage.thumbnailUrls=@[thumUrl];
        _showImage.originalUrls=@[orgUrl];
        _titleContent.text=arrys[0];
        [_titleContent sizeToFit];
    }else{
        _showImage.hidden=YES;
        _imgConstraint.constant=0;
        _titleContent.text=content;
        [_titleContent sizeToFit];
    }
}
@end
