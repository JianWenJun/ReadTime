//
//  MyArticleCell.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/5.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface MyArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *data;


@property(nonatomic,strong)ArticleModel* model;

@end
