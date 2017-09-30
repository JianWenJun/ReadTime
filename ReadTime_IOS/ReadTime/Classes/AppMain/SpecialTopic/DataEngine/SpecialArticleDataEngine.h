//
//  SpecialArticleDataEnginr.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialArticleDataEngine : NSObject

//每次获取 limit固定为10  和  skip 来做分页
+ (RTBaseDataEngine *)control:(NSObject *)control
                         skip:(NSInteger)skip
                       typeID:(NSInteger)num
                     complete:(CompletionDataBlock)responseBlock;

@end
