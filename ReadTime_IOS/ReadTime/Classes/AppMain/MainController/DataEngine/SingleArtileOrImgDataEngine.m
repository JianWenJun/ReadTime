//
//  SingleArtileDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/28.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "SingleArtileOrImgDataEngine.h"

@implementation SingleArtileOrImgDataEngine

+ (RTBaseDataEngine *)control:(NSObject *)control
                     objectID:(NSString*)objectID
                       type:(NSInteger)typeID
                     complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=[NSString stringWithFormat:@"{\"objectId\":\"%@\"}",objectID];
    NSDictionary *param = @{@"where":whereParm
                            };
    NSString* path=@"classes/Article";
    if (typeID==2) {
        path=@"classes/ImgArt";
    }else if(typeID==3){
        path=@"classes/LArticle";
    }
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];

}
+ (RTBaseDataEngine *)control:(NSObject *)control userID:(NSInteger)userID complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=[NSString stringWithFormat:@"{\"userID\":%ld}",userID];
    NSDictionary *param = @{@"where":whereParm
                            };
     return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/_User" param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
@end
