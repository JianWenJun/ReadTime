//
//  HomeArticleDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "HomeArticleDataEngine.h"

@implementation HomeArticleDataEngine

+ (RTBaseDataEngine*)control:(NSObject *)control skip:(NSInteger )skip complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=@"{\"typeID\":{\"$in\":[1,2,3]}}";
    NSDictionary *param = @{@"where":whereParm,
                            @"limit":@(10),
                            @"skip":@(skip),
                            };
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/Article"  param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
@end
