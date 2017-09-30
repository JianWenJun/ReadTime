//
//  NSString+UtilNetWorking.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/20.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "NSString+UtilNetWorking.h"

@implementation NSString (UtilNetWorking)
+ (BOOL)isEmptyString:(NSString *)string{
    if (!string) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    return string.length==0;
}
@end
