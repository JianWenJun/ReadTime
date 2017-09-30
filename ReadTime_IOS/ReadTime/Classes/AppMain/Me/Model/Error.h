//
//  Error.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Error : NSObject

@property(nonatomic ,assign)NSInteger code;
@property(nonatomic,copy)NSString* error;

@end
