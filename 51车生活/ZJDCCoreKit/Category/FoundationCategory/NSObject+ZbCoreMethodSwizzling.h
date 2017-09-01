//
//  NSObject+MethodSwizzling.h
//  TwentyFourHours
//
//  Created by Prewindemon on 2016/10/19.
//  Copyright © 2016年 ZBJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzling)

+ (IMP)hook_swizzleSelector:(SEL)origSelector
               withIMP:(IMP)newIMP;

+ (void)hook_swizzleSelector:(SEL)origSelector
                    withSelector:(SEL)newSelector;

+ (void)hook_swizzleClassSelector:(SEL)origSelector
                     withSelector:(SEL)newSelector;
@end
