//
//  UITextField+TFHxtension.m
//  TwentyFourHours
//
//  Created by Prewindemon on 2016/10/31.
//  Copyright © 2016年 ZBJT. All rights reserved.
//

#import "UITextField+ZbCoreExtension.h"
#import "NSObject+ZbCoreMethodSwizzling.h"
#import <objc/runtime.h>
@implementation UITextField (ZbCoreExtension)

+ (void)load{
    [self hook_swizzleSelector: @selector(textRectForBounds:) withSelector: @selector(hook_textRectForBounds:)];
    [self hook_swizzleSelector: @selector(editingRectForBounds:) withSelector: @selector(hook_editingRectForBounds:)];
}

#pragma mark Getter/Setter方法
- (CGFloat)zb_textTabSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setZb_textTabSpace:(CGFloat)zb_textTabSpace{
    self.zb_placeHolderTabSpace = zb_textTabSpace;
    objc_setAssociatedObject(self, @selector(zb_textTabSpace), @(zb_textTabSpace), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)zb_placeHolderTabSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setZb_placeHolderTabSpace:(CGFloat)zb_placeHolderTabSpace{
    objc_setAssociatedObject(self, @selector(zb_placeHolderTabSpace), @(zb_placeHolderTabSpace), OBJC_ASSOCIATION_COPY_NONATOMIC);
}


//控制placeHolder 的位置，左右缩 10
- (CGRect)hook_textRectForBounds:(CGRect)bounds {
    if (self.zb_placeHolderTabSpace) {
        return CGRectInset(bounds, self.zb_placeHolderTabSpace, 0);
    }
    return [self hook_textRectForBounds: bounds];
}

//控制文本的位置，左右缩 10
- (CGRect)hook_editingRectForBounds:(CGRect)bounds {
    if (self.zb_textTabSpace) {
        return CGRectInset(bounds, self.zb_textTabSpace, 0);
    }
    return [self hook_editingRectForBounds: bounds];
}

@end
