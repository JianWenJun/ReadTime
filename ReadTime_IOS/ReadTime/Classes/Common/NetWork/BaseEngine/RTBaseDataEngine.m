//
//  RTBaseDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTBaseDataEngine.h"
#import "RTAPIClient.h"
#import "RTAPIBaseRequestDataModel.h"
#import "NSObject+RTNetWorkingAutoCancel.h"
@interface RTBaseDataEngine()
@property(strong,nonatomic)NSNumber * requestID;
@end
@implementation RTBaseDataEngine
- (void)dealloc{
    [self cancelRequest];
}

- (void)cancelRequest{
    [[RTAPIClient shareInstance]cancelRequestWithRequestID:self.requestID];
}

+ (RTBaseDataEngine*)control:(NSObject *)control
      callAPIWithServiceType:(RTServiceType)serviceType
                        path:(NSString *)path
                       param:(NSDictionary *)parameters
                 requestType:(RTAPIManagerRequestType)requestType
                   alertType:(DataEngineAlertType)alertType
               progressBlock:(ProgressBlock)progressBlock
                    complete:(CompletionDataBlock)responseBlock
      errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndex{
    RTBaseDataEngine* engine=[[RTBaseDataEngine alloc]init];
    __weak typeof(control)weakControl=control;
    RTAPIBaseRequestDataModel* dataModel=[engine dataModelWith:serviceType
                                                          path:path
                                                         param:parameters
                                                  dataFilePath:nil
                                                      dataName:nil
                                                      fileName:nil
                                                      mimeType:nil
                                                   requestType:requestType
                                           uploadProgressBlock:progressBlock
                                         downloadProgressBlock:nil
                                                      complete:^(id data,NSError* error){
                                                          if (responseBlock) {
                                                              //unicode转utf
                                                              
                                                              responseBlock(data,error);
                                                          }
                                                          [weakControl.networkingAutoCancelRequest removeEngineWithRequestID:engine.requestID];
                                                      }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}


+ (RTBaseDataEngine*)control:(NSObject *)control uploadAPIWithServiceType:(RTServiceType)serviceType path:(NSString *)path param:(NSDictionary *)parameters dataFilePath:(NSData *)dataFilePath dataName:(NSString *)dataName fileName:(NSString *)fileName mimeType:(NSString *)mimeType requestType:(RTAPIManagerRequestType)requestType alertType:(DataEngineAlertType)alertType uploadProgressBlock:(ProgressBlock)uploadProgressBlock downloadProgressBlock:(ProgressBlock)downloadProgressBlock complete:(CompletionDataBlock)responseBlock errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock{
    RTBaseDataEngine* engine=[[RTBaseDataEngine alloc]init];
    __weak typeof(control)WeakControl=control;
    RTAPIBaseRequestDataModel* requestmodel=[engine dataModelWith:serviceType
                                                             path:path
                                                            param:parameters
                                                     dataFilePath:dataFilePath
                                                         dataName:dataName
                                                         fileName:fileName
                                                         mimeType:mimeType
                                                      requestType:requestType
                                              uploadProgressBlock:uploadProgressBlock
                                            downloadProgressBlock:downloadProgressBlock
                                                         complete:^(id data, NSError *error) {
                                                             if (responseBlock) {
                                                                 //可以在这里做错误的UI处理，或者是在上层engine做

                                                                 responseBlock(data,error);
                                                             }
                                                             [WeakControl.networkingAutoCancelRequest removeEngineWithRequestID:engine.requestID];
                                                         }];
    [engine callRequestWithRequestModel:requestmodel control:control];
    return engine;
}
#pragma mark - private methods
- (RTAPIBaseRequestDataModel *)dataModelWith:(RTServiceType)serviceType
                                        path:(NSString *)path
                                       param:(NSDictionary *)parameters
                                dataFilePath:(NSData *)dataFilePath
                                    dataName:(NSString *)dataName
                                    fileName:(NSString *)fileName
                                    mimeType:(NSString *)mimeType
                                 requestType:(RTAPIManagerRequestType)requestType
                         uploadProgressBlock:(ProgressBlock)uploadProgressBlock
                       downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                                    complete:(CompletionDataBlock)responseBlock{
    RTAPIBaseRequestDataModel *dataModel = [[RTAPIBaseRequestDataModel alloc]init];
    dataModel.serviceType = serviceType;
    dataModel.apiMethodPath = path;
    dataModel.parameters = parameters;
    dataModel.dataFilePath = dataFilePath;
    dataModel.filename=fileName;
    dataModel.dataName = dataName;
    dataModel.mimeType = mimeType;
    dataModel.requestType = requestType;
    dataModel.uploadProgress = uploadProgressBlock;
    dataModel.downloadProgress = downloadProgressBlock;
    dataModel.responseBlock = responseBlock;
    return dataModel;
}
//- (NSString*)unicodeToUtf:(id)data{
//    NSData *da=[NSData dataWithData:<#(nonnull NSData *)#>]
//}
- (void)callRequestWithRequestModel:(RTAPIBaseRequestDataModel*)requestModel control:(NSObject*)control{
    self.requestID=[[RTAPIClient shareInstance]callRequestWithRequestModel:requestModel];
    [control.networkingAutoCancelRequest setEngine:self requestID:self.requestID];
}
@end
