//
//  UIImage+ZBExtension.h
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/8/29.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _dotted_line_Type {
    Left                    = 0x1,
    Right                   = 0x1<<1,
    Top                     = 0x1<<2,
    Bottom                  = 0x1<<3,
    All                     = 0x1<<4
} dotted_line_Type;

@interface UIImage (ZbCoreExtension)


/**
 获取指定大小的压缩图片

 @param image             原图片
 @param size              大小
 */
+ (UIImage *)zbcore_imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  获取颜色图片，默认大小50*50
 *
 *  @param color 颜色
 */
+ (UIImage *)zbcore_ImageWithColor: (UIColor *)color;

/**
 *  获取颜色图片
 *
 *  @param color 颜色
 *  @param size  大小
 */
+ (UIImage *)zbcore_ImageWithColor: (UIColor *)color size:(CGSize)size;

/**
 *  获取指定文字图片，文字默认80%高度
 *
 *  @param word 文字
 *  @param size 大小
 */
+ (UIImage *)zbcore_ImageWithWord:(NSString *)word size: (CGSize) size;
/**
 *  获取指定大小文字图片
 *
 *  @param word     文字
 *  @param size     大小
 *  @param fontSize 字体大小
 */
+ (UIImage *)zbcore_ImageWithWord:(NSString *)word size: (CGSize) size fontSize: (CGFloat) fontSize;
/**
 *  获取指定大小文字图片
 *
 *  @param word         文字
 *  @param wordColor    文字颜色
 *  @param size         大小
 *  @param fontSize     字体大小
 *  @param imageColor   背景颜色
 */
+ (UIImage *)zbcore_ImageWithWord:(NSString *)word wordColor: (UIColor *)wordColor size:(CGSize)size fontSize:(CGFloat)fontSize imageColor: (UIColor *)imageColor;

/**
 *  画一条虚线
 *
 *  @param size        大小
 *  @param color       颜色
 *  @param borderWidth 宽度
 *  @param type        类型
 *
 *  @return 虚线图片
 */
+ (UIImage*)dottedLineWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth Type:(dotted_line_Type)type;
/**
 裁剪图片为圆形
 
 @param sourceImage 原图片
 
 */
+ (UIImage *)zbcore_circleImageWithImage:(UIImage *)sourceImage;

/**
 裁剪图片为圆形
 
 @param sourceImage 原图片
 @param borderWidth 边框
 @param borderColor 边框颜色
 
 */
+ (UIImage *)zbcore_circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 绘制圆点
 
 @param pointColor 圆点颜色
 @param pointSize  圆点大小
 
 @return 圆点
 */
+ (UIImage *)zbcore_circlePointImageWithColor: (UIColor *)pointColor size: (CGSize)pointSize;

/**
 绘制圆点
 
 @param pointColor 圆点颜色
 @param pointSize  圆点大小
 
 @return 圆点
 */
+ (UIView *)zbcore_circlePointViewWithColor: (UIColor *)pointColor size: (CGSize)pointSize;


/**
 处理图片添加半透明遮罩

 @param image 图片
 @param alpha 遮罩透明渡
 */
+ (UIImage *)zbcore_addHalfAlphaCover:(UIImage *)image alpha: (CGFloat)alpha;

/**
 生成渐变图片
 
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param size 大小
 @param startPoint 开始位置
 @param endPoint 结束位置
 @return 渐变图片
 */
+ (UIImage *)zbcore_GraduallyImageWithstartColor:(UIColor *)startColor
                                        endColor:(UIColor *)endColor
                                            size:(CGSize)size
                                      startPoint:(CGPoint)startPoint
                                        endPoint:(CGPoint)endPoint;

/**
 异步处理图片添加半透明遮罩

 @param image 图片
 @param alpha 透明度
 @param completion 处理完成事件
 */
+ (void)zbcore_addHalfAlphaCover:(UIImage *)image alpha: (CGFloat)alpha completion: (void (^)(UIImage *sourceImage, UIImage *resultImage))completion;

/**
 获取指定Bundle的图片
 */
+ (UIImage *)zbcore_bundleImageNamed:(NSString *)name bundleName: (NSString *)bundleName forClass: (Class)bundleClass;
+ (UIImage *)zbcore_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end
