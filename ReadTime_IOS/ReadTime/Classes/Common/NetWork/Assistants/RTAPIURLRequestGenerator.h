//
//  RTAPIURLRequestGenerator.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTAPIBaseRequestDataModel.h"
@interface RTAPIURLRequestGenerator : NSObject
+ (instancetype)shareInstance;
- (NSMutableURLRequest*)generateWithDataModel:(RTAPIBaseRequestDataModel*)dataModel;
@end
