//
//  CommentCell.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "CommentCell.h"
#import "UIImage+DSRoundImage.h"
@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCommentM:(Comment *)commentM{
    UIImage* faceImg=[UIImage createRoundedRectImage:[UIImage imageNamed:@"default_head"] size:CGSizeMake(35, 35) radius:18];
    [self.face setImage:faceImg];
    self.name.text=commentM.userName;
    self.time.text=[UserConfig getDate:[UserConfig dateFromISO8601String:commentM.createdAt]];
    self.comment.text=commentM.commentContent;
    CGRect rect = [commentM.commentContent boundingRectWithSize:CGSizeMake(295, 1000)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
//    NSLog(@"height-------:%f",rect.size.height+2);
    self.commentH.constant=rect.size.height+2;
}

@end
