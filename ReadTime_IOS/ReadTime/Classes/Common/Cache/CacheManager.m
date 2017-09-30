//
//  CacheManager.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "CacheManager.h"
#import "SDImageCache.h"
@implementation CacheManager
+ (instancetype)shareCInstance{
    static CacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CacheManager alloc] init];
    });
    
    return manager;
}
#pragma mark - 计算单个文件大小
- (CGFloat)fileSizePath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
- (CGFloat)loadCacheSize{
    self.cacheSize=0;
    NSString* cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSArray* files=[[NSFileManager defaultManager]subpathsAtPath:cachePath];
    for (NSString* f in files) {
        NSString* path=[cachePath stringByAppendingString:f];
        self.cacheSize +=[self fileSizePath:path];
    }
    return self.cacheSize;
}
#pragma mark - 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    float folderSize=0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray* arry=[fileManager subpathsAtPath:path];
        for (NSString *f in arry) {
            NSString* absolutepath=[path stringByAppendingString:f];
            folderSize +=[self fileSizePath:absolutepath];
        }
        //SDWebImage框架自身计算缓存的实现
//        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
#pragma mark - 清除缓存

//第一种：
//-(void)clearCache:(NSString *)path{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            //如有需要，加入条件，过滤掉不想删除的文件
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            [fileManager removeItemAtPath:absolutePath error:nil];
//        }
//    }
//    [[SDImageCache sharedImageCache] cleanDisk];
//}
//第二种
- (void)ClearCacheSize{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSLog(@"cachePath:%@",cachePath);
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        for (NSString *p in files)
        {
            NSError *error;
            NSString *path = [cachePath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];

    });
}
- (void)clearCacheSuccess
{
    NSLog(@"清理成功");
}
@end
