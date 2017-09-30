//
//  BaseViewModel.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    BaseViewModel* viewModel=[super allocWithZone:zone];
    if (viewModel) {
        [viewModel initialize];//初始化操作
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model{
    self=[super init];
    if (self) {
        
    }
    return self;
}

/**
 供子代复写
 */
- (void)initialize{
    
}
@end
