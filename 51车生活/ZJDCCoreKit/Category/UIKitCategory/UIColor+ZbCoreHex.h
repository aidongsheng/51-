//
//  UIColor+ZBHex.h
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/8/27.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZbCoreHex)

//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *) zbcore_colorWithHex: (NSString *)hexString;
@end
