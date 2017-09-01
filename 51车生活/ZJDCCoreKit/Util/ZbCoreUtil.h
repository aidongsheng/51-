//
//  GlobalUtil.h
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/8/29.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 获取当前正在显示的控制器
 */
UIViewController *zbcore_currentController();

/** 获取当前正在显示的控制器 */
#ifndef zbcore_currentViewController
#define zbcore_currentViewController zbcore_currentController()
#endif

@interface NSString (ZbCoreExpand)

#pragma mark 加密
/**
 *  获取MD5编码后字符串
 *
 *  @param str 待编码
 *
 *  @return 编码字符串
 */
+(NSString *)zbcore_md5:(NSString *)str;
/**
 *  是否是电话
 *
 *  @return 是否
 */
-(BOOL)zbcore_checkPhoneNumInput;

/**
 *  字典型转String
 */
+(NSString *)zbcore_dictToString:(NSDictionary*)dict;

/**
 *  将base64格式字符串转换为文本
 *
 *  @param base64 带转换文字
 *
 *  @return 转换后
 */
+ (NSString *)zbcore_textFromBase64String:(NSString *)base64;
@end

@interface NSData(ZbCoreSha256)
- (NSData *)sha256;
- (NSString *)hex;
@end

@interface NSString (ZbCoreSha256)
- (NSString *)sha256;
@end


@interface NSData (ZbCoreMD5)

+(NSData *)zbcore_MD5Digest:(NSData *)input;
-(NSData *)zbcore_MD5Digest;

+(NSString *)zbcore_MD5HexDigest:(NSData *)input;
-(NSString *)zbcore_MD5HexDigest;

@end

@interface NSData (ZbCoreUtils)
- (NSString *)zbcore_detectImageSuffix;

+ (NSData*)zbcore_dataWithBase64EncodedString:(NSString*)string;
@end






#pragma mark UIView线条绘制
@class MASConstraintMaker;
@interface UIView (ZbCoreUtils)
/**
 画线
 
 @param lineColor 线条颜色
 @param block     mas设置
 */
- (UIView *)zbcore_drawLine: (UIColor *)lineColor
                   masBlock: (void(^)(MASConstraintMaker *make))block;

/**
 画线
 
 @param lineColor 线条颜色
 @param superView 父视图
 @param block     mas设置
 */
+ (UIView *)zbcore_drawLine: (UIColor *)lineColor
                     inView: (UIView *)superView
                   masBlock: (void(^)(MASConstraintMaker *make))block;
@end


#pragma mark Util方法
@interface ZbCoreUtil : NSObject
/**
 *  设备号
 */
+ (NSString*)zbcore_deviceVersion;
/**
 *  真实大小
 */
+ (CGSize)zbcore_resolutionSize;

/**
 *  过滤html标签
 *
 *  @param html 要过滤的html
 *
 *  @return 结果
 */
+ (NSString *)zbcore_filterHTML:(NSString *)html;
@end
