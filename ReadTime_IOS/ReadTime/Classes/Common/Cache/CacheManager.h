//
//  CacheManager.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject
@property (assign,nonatomic)CGFloat cacheSize;
+ (instancetype)shareCInstance;

/**
 计算单个文件大小

 @param path 路径
 @return 文件大小
 */
- (CGFloat)fileSizePath:(NSString*)path;

/**
 计算目录文件大小

 @param path 目录路径
 @return 目录文件大小
 */
- (CGFloat)folderSizeAtPath:(NSString*)path;

/**
 缓存大小

 */
- (CGFloat)loadCacheSize;

/**
 清除缓存
 */
- (void)ClearCacheSize;

/**
 清除成功回调
 */
- (void)clearCacheSuccess;

@end
