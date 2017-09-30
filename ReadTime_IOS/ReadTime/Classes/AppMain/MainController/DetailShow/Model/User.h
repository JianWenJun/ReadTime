//
//  User.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/29.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,copy)NSString* objectId;
@property(nonatomic,assign)NSInteger userID;
@property(nonatomic,copy)NSString* headUrl;
@property(nonatomic,copy)NSString* username;
@property(nonatomic,copy)NSString* signature;

@end
