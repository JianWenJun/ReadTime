//
//  BaseModel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (copy, nonatomic)NSString* objectId;
@property (copy, nonatomic)NSString* updatedAt;
@property (copy, nonatomic)NSString* createdAt;

@end
