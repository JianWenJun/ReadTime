//
//  RTAPIResponseErrorHandler.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTAPIBaseRequestDataModel.h"
@interface RTAPIResponseErrorHandler : NSObject
+ (void)errorHandlerWithRequestDataModel:(RTAPIBaseRequestDataModel*)requestDataModel responseURL:(NSURLResponse*)responseURL
                          responseObject:(id)responseObject error:(NSError*)error errorHandler:(void(^)(NSError* newError))errorHandler;
@end
