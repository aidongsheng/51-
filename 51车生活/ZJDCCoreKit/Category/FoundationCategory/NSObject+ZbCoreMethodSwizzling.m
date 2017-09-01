//
//  NSObject+MethodSwizzling.m
//  TwentyFourHours
//
//  Created by Prewindemon on 2016/10/19.
//  Copyright © 2016年 ZBJT. All rights reserved.
//

#import "NSObject+ZbCoreMethodSwizzling.h"
#import <objc/runtime.h>
@implementation NSObject (MethodSwizzling)

+ (IMP)hook_swizzleSelector:(SEL)origSelector
               withIMP:(IMP)newIMP {
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    
    if(!class_addMethod(self, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

+ (void)hook_swizzleSelector:(SEL)origSelector withSelector:(SEL)newSelector{
    
    Class class = [self class];
    
    Method oriMethod = class_getInstanceMethod(class, origSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    method_exchangeImplementations(oriMethod, newMethod);
}


+ (void)hook_swizzleClassSelector:(SEL)origSelector withSelector:(SEL)newSelector{
    
    Class class = [self class];
    
    Method oriMethod = class_getClassMethod(class, origSelector);
    Method newMethod = class_getClassMethod(class, newSelector);
    method_exchangeImplementations(oriMethod, newMethod);
}

@end
