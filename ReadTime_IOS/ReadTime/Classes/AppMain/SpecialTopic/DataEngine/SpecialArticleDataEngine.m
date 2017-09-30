//
//  SpecialArticleDataEnginr.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "SpecialArticleDataEngine.h"

@implementation SpecialArticleDataEngine

+ (RTBaseDataEngine*)control:(NSObject *)control skip:(NSInteger)skip typeID:(NSInteger)num complete:(CompletionDataBlock)responseBlock{
     NSString *whereParm=[NSString stringWithFormat:@"{\"typeID\":%ld}",num];
     NSDictionary *param = @{@"where":whereParm,
                            @"limit":@(10),
                            @"skip":@(skip),
                            };
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/Article" param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}

@end
