//
//  NewObject.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/5/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
//创建了新的对象返回的响应体
#import <Foundation/Foundation.h>

@interface NewObject : NSObject

@property (copy, nonatomic)NSString* objectId;
@property (copy,nonatomic)NSString* createdAt;

@end
