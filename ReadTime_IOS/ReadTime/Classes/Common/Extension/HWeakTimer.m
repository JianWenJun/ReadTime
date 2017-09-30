//
//  HWeakTimer.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/8.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "HWeakTimer.h"
@interface HWeakTimerTarget:NSObject

@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL selctor;
@property (nonatomic,weak)NSTimer* timer;

@end

@implementation HWeakTimerTarget

- (void)fire:(NSTimer*) timer{
    if (self.target) {
        [self.target performSelector:self.selctor withObject:timer.userInfo afterDelay:0.0f];
    }
    else{
        [self.timer invalidate];
    }
}

@end
@implementation HWeakTimer

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats{
    HWeakTimerTarget* timerTarget=[[HWeakTimerTarget alloc]init];
    timerTarget.target=aTarget;
    timerTarget.selctor=aSelector;
    timerTarget.timer=[NSTimer scheduledTimerWithTimeInterval:interval target:timerTarget selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    return timerTarget.timer;
}
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(HWTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats {
    NSMutableArray *userInfoArray = [NSMutableArray arrayWithObject:[block copy]];
    if (userInfo != nil) {
        [userInfoArray addObject:userInfo];
    }
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(_timerBlockInvoke:)
                                       userInfo:[userInfoArray copy]
                                        repeats:repeats];
}


+ (void)_timerBlockInvoke:(NSArray*)userInfo {
    HWTimerHandler block = userInfo[0];
    id info = userInfo[1];
    // or `!block ?: block();` @sunnyxx
    if (block) {
        block(info);
    }
}
@end
