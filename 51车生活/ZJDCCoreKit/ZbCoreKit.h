//
//  ZbCoreMacros.h
//  ZbCoreModule
//
//  Created by Prewindemon on 16/8/27.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#ifndef ZbCoreKit_h
#define ZbCoreKit_h

#import "ZbCoreCategoryMacros.h"
#import "ZbCoreUtil.h"
#import "ZbCoreUserDefaults.h"

//RGB颜色
#define UIColorFromRGB(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//默认字体
#define Default_Font(num)                [UIFont systemFontOfSize:(num)]
#define Default_Bold_Font(num)           [UIFont boldSystemFontOfSize:(num)]

//是否为iOS7及以上系统
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
//是否为iOS9及以上系统
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
//是否为iOS10及以上系统
#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

//屏幕宽度
#define _ScreenWidth           [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define _ScreenHeight          [UIScreen mainScreen].bounds.size.height
//导航栏高度
#define _NavigationHeight      44.0f
//tab栏高度
#define _TabbarHeight          49.0f
//状态栏高度
#define _StatusBarHeight       (iOS7 ? 20 : 0)
//适配宽度
#define Fit_Width(width)       ((width) * Fit_Ratio)
//适配高度
#define Fit_Height(height)     ((height) * Fit_Ratio)
//适配比例
#define Fit_Ratio              (_ScreenWidth / 375.0f)

#define ZBURL(urlString)       [NSURL URLWithString:urlString]

//Debug模式打印Log信息
#ifdef  DEBUG
#define debug_NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define debug_NSLog(format, ...)
#endif

#ifdef DEBUG
#define ZBLog(...) NSLog(@"\n%s 第%d行: \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define ZBLog(...)
#endif

#define zbcore_Weak(o) __weak typeof(o) weak_##o = o;

#endif /* ZbCoreMacros_h */
