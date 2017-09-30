//
//  ImageModel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/13.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseModel.h"

@interface ImageModel : BaseModel
@property (nonatomic,strong) UIImage *image;//刚从相册或者相机中添加的照片
@property (nonatomic,copy) NSString *imageUrl;//图片地址 该地址指的是网络地址
@property (nonatomic,assign) BOOL isDelete;//是否被删除 默认未被删除

+ (ImageModel *)ittemModelWithImage:(UIImage *)image imageUrl:(NSString *)imageUrl isDelete:(BOOL)isDelete;
@end
