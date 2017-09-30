//
//  BaseViewModel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/24.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTBaseDataEngine.h"
@interface BaseViewModel : NSObject

@property (nonatomic,strong)RTBaseDataEngine* baseDataEngine;//网络请求的发起和取消

+ (instancetype)allocWithZone:(struct _NSZone *)zone;

- (instancetype)initWithModel:(id)model;

- (void)initialize;

@end
