//
//  HWeakTimer.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/8.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWeakTimer : NSObject

typedef void (^HWTimerHandler)(id userInfo);



+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(HWTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

@end
