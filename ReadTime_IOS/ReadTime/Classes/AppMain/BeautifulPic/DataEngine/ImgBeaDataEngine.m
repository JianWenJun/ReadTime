//
//  ImgBeaDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/22.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "ImgBeaDataEngine.h"

@implementation ImgBeaDataEngine

+ (RTBaseDataEngine*)control:(NSObject *)control skip:(NSInteger)skip
                    complete:(CompletionDataBlock)responseBlock{
    NSDictionary *param = @{
                            @"limit":@(20),
                            @"skip":@(skip),
                            };
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/ImgArt" param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}


@end
