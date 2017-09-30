//
//  DetailViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/27.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property (weak, nonatomic) IBOutlet UITextField *commentTextF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottomConTran;


@property(nonatomic,assign)NSInteger typeID;//1，文章 2，美图，3，轮播图
- (instancetype)initWithObjectId:(NSString*)objectID typeID:(NSInteger)typeID;
- (instancetype)initWithObjectId:(NSString*)objectID typeID:(NSInteger)typeID isZti:(BOOL)isZti;
@end
