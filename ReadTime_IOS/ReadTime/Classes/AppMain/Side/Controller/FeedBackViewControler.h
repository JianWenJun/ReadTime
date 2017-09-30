//
//  FeedBackViewControler.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseViewController.h"
#import "PlaceholderTextView.h"
@interface FeedBackViewControler : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *errorType;
@property (weak, nonatomic) IBOutlet UIButton *founctionType;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *content;
@property (weak, nonatomic) IBOutlet UIImageView *addImg;

@end
