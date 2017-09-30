//
//  RTBaseServers.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  开发、测试、预发、正式、HotFix和自定义环境,环境的切换是给开发人员和测试人员用的，对于外部正式打包不应该有环境切换的存在
 */
typedef NS_ENUM(NSUInteger,EnvironmentType) {
    EnvironmentTypeDevelop,
    EnvironmentTypeTest,
    EnvironmentTypePreRelease,
    EnvironmentTypeHotFix,
    EnvironmentTypeRelease,
    EnvironmentTypeCustom,
};
@protocol RTBaseServiceProtocol <NSObject>

/**
 *  开发、测试、预发、正式、HotFix五种环境的baseUrl在子类中实现，获取对应的URL赋值给apiBaseUrl，自定义在基类中进行保存获取
 */
@property (nonatomic, strong, readonly) NSString *developApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *testApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *prereleaseApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *hotfixApiBaseUrl;
@property (nonatomic, strong, readonly) NSString *releaseApiBaseUrl;

@end
@interface RTBaseServers : NSObject
@property(nonatomic,assign)EnvironmentType environment;
@property (nonatomic, strong, readonly) NSString *publicKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@end
