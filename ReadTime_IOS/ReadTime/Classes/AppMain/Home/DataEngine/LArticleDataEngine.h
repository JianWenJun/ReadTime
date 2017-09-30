//
//  LArticleDataEngine.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/17.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LArticleDataEngine : NSObject

+ (RTBaseDataEngine*)control:(NSObject*)object complete:(CompletionDataBlock)responeBlock;


@end
