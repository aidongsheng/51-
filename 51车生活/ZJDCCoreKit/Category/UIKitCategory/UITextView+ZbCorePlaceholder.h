//
//  UITextView+Placeholder.h
//  TwentyFourHours
//
//  Created by superzhang on 2016/12/29.
//  Copyright © 2016年 ZBJT. All rights reserved.

@import UIKit;

FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

@interface UITextView (ZbCorePlaceholder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end
