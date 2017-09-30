//
//  Comment.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/28.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface Comment : BaseModel

@property (nonatomic,copy)NSString* userName;//

@property (nonatomic,copy)NSString* commentContent;


@property (nonatomic,copy)NSString* desID;
@end
