//
//  ImgBeaDataEngine.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgBeaDataEngine : NSObject

//每次获取 limit固定为10  和  skip 来做分页
+ (RTBaseDataEngine *)control:(NSObject *)control
                         skip:(NSInteger)skip
                     complete:(CompletionDataBlock)responseBlock;

@end
