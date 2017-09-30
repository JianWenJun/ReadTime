//
//  FeedBackModel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackModel : NSObject

@property (nonatomic, copy)NSString* content;
@property (nonatomic,copy)NSString* type;
@property (nonatomic, copy)NSString* imgUrl;
@property (nonatomic,assign)NSInteger userID;
@end
