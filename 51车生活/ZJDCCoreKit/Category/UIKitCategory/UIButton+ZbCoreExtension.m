//
//  UIButton+ZBExtension.m
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/9/5.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import "UIButton+ZbCoreExtension.h"
#import <objc/runtime.h>
#import "UIImage+ZbCoreExtension.h"
#import "NSObject+ZbCoreDeallocBlock.h"


@interface UIButton ()

@property(nonatomic, strong)ZbCoreUIButtonClickBlock clickBlock;

@end

@implementation UIButton (ZbCoreExtension)






#pragma mark Getter/Setter方法
- (void)setZbcore_title:(NSString *)zbcore_title{
    [self setTitle: zbcore_title forState: UIControlStateNormal];
}
- (NSString *)zbcore_title{
    return self.currentTitle;
}
- (void)setZbcore_titleColor:(UIColor *)zbcore_titleColor{
    [self setTitleColor: zbcore_titleColor forState: UIControlStateNormal];
}
- (UIColor *)zbcore_titleColor{
    return self.titleLabel.textColor;
}
- (void)setZbcore_font:(UIFont *)zbcore_font{
    self.titleLabel.font = zbcore_font;
}
- (UIFont *)zbcore_font{
    return self.titleLabel.font;
}

static const char ZBUIButtonBackgroundColorKey;
- (void)setZbcore_backgroundColor:(UIColor *)zbcore_backgroundColor{
    // 存储新的
    [self willChangeValueForKey:@"zbcore_backgroundColor"]; // KVO
    objc_setAssociatedObject(self, &ZBUIButtonBackgroundColorKey,
                             zbcore_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"zbcore_backgroundColor"]; // KVO
    
    [self setBackgroundImage: [UIImage zbcore_ImageWithColor: zbcore_backgroundColor] forState: UIControlStateNormal];
}

- (UIColor *)zbcore_backgroundColor{
    return objc_getAssociatedObject(self, &ZBUIButtonBackgroundColorKey);
}


#pragma mark =========================快速添加点击事件=========================
- (void)setClickBlock:(ZbCoreUIButtonClickBlock)clickBlock{
    if (clickBlock != self.clickBlock) {
        
        /**
         *  两种方式的runtime
         */
        objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        [self addTarget: self action: @selector(zbcore_UIButtonEvent:) forControlEvents: UIControlEventTouchUpInside];
        if (!clickBlock) {
            [self removeTarget: self action: @selector(zbcore_UIButtonEvent:) forControlEvents: UIControlEventTouchUpInside];
        }
    }
}

- (ZbCoreUIButtonClickBlock)clickBlock{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)zbcore_addClickBlock:(ZbCoreUIButtonClickBlock)block{
    self.clickBlock = block;
}

- (void)zbcore_UIButtonEvent: (UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.clickBlock) {
            self.clickBlock(sender);
        }
    });
}

#pragma mark =========================扩大相应范围=========================
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        SEL originalSelector = @selector(pointInside:withEvent:);
        SEL swizzledSelector = @selector(zb_pointInside:withEvent:);
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
- (UIEdgeInsets)zbcore_hitTestEdgeInsets{
    return [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setZbcore_hitTestEdgeInsets:(UIEdgeInsets)zbcore_hitTestEdgeInsets{
    objc_setAssociatedObject(self, @selector(zbcore_hitTestEdgeInsets), [NSValue valueWithUIEdgeInsets:zbcore_hitTestEdgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)zb_pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    UIEdgeInsets insets = self.zbcore_hitTestEdgeInsets;
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        return [self zb_pointInside:point withEvent:event];
    } else {
        CGRect hitBounds = UIEdgeInsetsInsetRect(self.bounds, insets);
        return CGRectContainsPoint(hitBounds, point);
    }
}

@end
