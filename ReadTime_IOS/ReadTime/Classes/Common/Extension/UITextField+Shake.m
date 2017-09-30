//
//  UITextField+Shake.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/2.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "UITextField+Shake.h"

@implementation UITextField (Shake)
- (void)shake {
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    keyFrame.duration = 0.3;
    CGFloat x = self.layer.position.x;
    keyFrame.values = @[@(x + 30), @(x - 30), @(x + 20), @(x - 20), @(x + 10), @(x - 10), @(x + 5), @(x - 5)];
    [self.layer addAnimation:keyFrame forKey:@"shake"];
    
}
@end
