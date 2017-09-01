//
//  UITabBarItem+ZJNewsExtension.m
//  Pods
//
//  Created by Prewindemon on 2017/5/18.
//
//

#import "UITabBarItem+ZbCoreExtension.h"
#import <objc/runtime.h>

@implementation UITabBarItem (ZbCoreExtension)


#pragma mark getset
- (UIViewController *)zbcore_containController{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZbcore_containController:(UIViewController *)zbcore_containController{
    objc_setAssociatedObject(self, @selector(zbcore_containController), zbcore_containController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
