//
//  CollAndUpMainViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseViewController.h"

@interface CollAndUpMainViewController : BaseViewController
@property (nonatomic,assign)NSUInteger selectIndex;//选中的是哪个
- (instancetype)init;
- (void)refreshCurrentViewCOntroller;

@end
