//
//  UILabel+TFHExtension.m
//  TwentyFourHours
//
//  Created by Prewindemon on 2016/12/30.
//  Copyright © 2016年 ZBJT. All rights reserved.
//

#import "UILabel+ZbCoreExtension.h"
#import <objc/runtime.h>
#import "NSObject+ZbCoreMethodSwizzling.h"

#define CalculateLineSpaceWithLineHeight(lineHeight, fontSize) (((lineHeight - fontSize) / fontSize / 2) + 1)

@implementation UILabel (ZbCoreExtension)

+ (void)load{
    [self hook_swizzleSelector: @selector(setText:) withSelector:@selector(zbcore_hook_setText:)];
}

#pragma mark =========================设置行高=========================

- (void)zbcore_hook_setText:(NSString *)text{
    [self zbcore_hook_setText: text];
    if (self.lineHeight > self.font.pointSize) {
        NSMutableAttributedString *textAttrString = [self.attributedText mutableCopy];
        if (![textAttrString length]) {
            textAttrString = [[NSMutableAttributedString alloc]initWithString: text ? : @""];
        }
        NSMutableParagraphStyle *lineSpaceStyle = [[NSMutableParagraphStyle alloc] init];
        lineSpaceStyle.lineHeightMultiple = CalculateLineSpaceWithLineHeight(self.lineHeight, self.font.pointSize);
        [textAttrString addAttribute: NSParagraphStyleAttributeName value: lineSpaceStyle range: NSMakeRange(0 , [textAttrString length])];
        NSLineBreakMode lineBreakMode = NSLineBreakByTruncatingTail;
        self.attributedText = textAttrString;
        self.lineBreakMode = lineBreakMode;
    }
    
}

- (void)setLineHeight:(CGFloat)lineHeight{
    objc_setAssociatedObject(self, @selector(lineHeight), @(lineHeight), OBJC_ASSOCIATION_COPY);
    if ([self.text length]) {
        NSMutableAttributedString *textAttrString = [self.attributedText mutableCopy];
        if (![textAttrString length]) {
            textAttrString = [[NSMutableAttributedString alloc]initWithString: self.text ? : @""];
        }
        NSMutableParagraphStyle *lineSpaceStyle = [[NSMutableParagraphStyle alloc] init];
        lineSpaceStyle.lineHeightMultiple = CalculateLineSpaceWithLineHeight(self.lineHeight, self.font.pointSize);
        [textAttrString addAttribute: NSParagraphStyleAttributeName value: lineSpaceStyle range: NSMakeRange(0 , [textAttrString length])];
        NSLineBreakMode lineBreakMode = NSLineBreakByTruncatingTail;
        self.attributedText = textAttrString;
        self.lineBreakMode = lineBreakMode;
    }
    
}
- (CGFloat)lineHeight{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


@end
