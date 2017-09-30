//
//  UserInfo.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic,copy)NSString* headUrl;
@property (nonatomic,copy)NSString* objectId;
@property (nonatomic,copy)NSString* sessionToken;
@property (nonatomic,copy)NSString* signature;
@property (nonatomic,assign)NSUInteger userID;
@property (nonatomic,copy)NSString* username;

@end
