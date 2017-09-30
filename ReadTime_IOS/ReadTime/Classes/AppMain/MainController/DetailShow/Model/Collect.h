//
//  Collect.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/30.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collect : NSObject

@property(nonatomic,assign)NSInteger count;

@property(strong, nonatomic)NSMutableArray* results;

@end

@interface CollectOne : NSObject

@property (copy, nonatomic)NSString* objectId;

@end
