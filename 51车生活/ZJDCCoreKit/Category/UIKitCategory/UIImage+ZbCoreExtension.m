//
//  UIImage+ZBExtension.m
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/8/29.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import "UIImage+ZbCoreExtension.h"
#import "NSBundle+ZbCoreExtension.h"

@implementation UIImage (ZbCoreExtension)

+ (UIImage *)zbcore_imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (UIImage *)zbcore_ImageWithColor:(UIColor *)color size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)zbcore_ImageWithColor:(UIColor *)color{
    CGSize imageSize = CGSizeMake(50, 50);
    return [UIImage zbcore_ImageWithColor: color size: imageSize];
}

+ (UIImage *)zbcore_ImageWithWord:(NSString *)word size:(CGSize)size fontSize:(CGFloat)fontSize{
    //获取颜色
    UIColor *color = [UIColor colorWithRed: 184/255.0 green:233/255.0 blue:134/255.0 alpha: 1];
    
    return [UIImage zbcore_ImageWithWord: word wordColor:[ UIColor whiteColor] size: size fontSize: fontSize imageColor:color];
}

+ (UIImage *)zbcore_ImageWithWord:(NSString *)word wordColor: (UIColor *)wordColor size:(CGSize)size fontSize:(CGFloat)fontSize imageColor: (UIColor *)imageColor{
    
    //设置画布大小
    CGRect colorRect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //填充颜色
    CGContextSetFillColorWithColor(context, [imageColor CGColor]);
    CGContextFillRect(context, colorRect);
    
    //设置文字大小
    UIFont *font = [UIFont boldSystemFontOfSize: fontSize];
    
    //设置文字位置
    CGRect rect = CGRectMake((size.width - font.pointSize * word.length) / 2.0,
                             (size.height - font.lineHeight) / 2.0,
                             font.pointSize * word.length,
                             font.lineHeight);
    //绘制文字
    [word drawInRect: rect withAttributes:@{
                                            NSFontAttributeName : font,
                                            NSForegroundColorAttributeName : wordColor,
                                            }];
    
    //生产图片
    UIImage *wordImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return wordImage;
}

+ (UIImage *)zbcore_ImageWithWord:(NSString *)word size: (CGSize) size{
    
    CGFloat width = size.width / [word length];
    if (width > size.height) {
        width = size.height;
    }
    return [UIImage zbcore_ImageWithWord: word size: size fontSize: width * 0.7];
    
}

+ (UIImage*)dottedLineWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth  Type:(dotted_line_Type)type{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [[UIColor clearColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lengths[] = { 3, 3 };
    CGContextSetLineDash(context, 3, lengths, 2);
    if (type == All) {
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, 0, size.height);
        CGContextAddLineToPoint(context, 0.0, 0.0);
    }else if(type == (Left | Right | Top)){
        CGContextMoveToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if(type == (Left | Right | Bottom)){
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, 0.0, size.height);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, size.width, 0);
    }else if (type == (Left | Top | Bottom)){
        CGContextMoveToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, 0.0, size.height);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if (type == (Right | Top | Bottom)){
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, 0.0, size.height);
    }else if (type == (Left | Top)){
        CGContextMoveToPoint(context, 0.0, size.height);
        CGContextAddLineToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
    }else if (type == (Left | Right)){
        CGContextMoveToPoint(context, 0.0, size.height);
        CGContextAddLineToPoint(context, 0.0, 0.0);
        CGContextMoveToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if (type == (Left | Bottom)){
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, 0.0, size.height);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if (type == (Top | Right)){
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if (type == (Top | Bottom)){
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
        CGContextMoveToPoint(context, 0.0, size.height);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if (type == (Right | Bottom)){
        CGContextMoveToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, 0.0, size.height);
    }else if (type == Right ){
        CGContextMoveToPoint(context, size.width, 0.0);
        CGContextAddLineToPoint(context, size.width, size.height);
    }else if (type == Left ){
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, 0.0, size.height);
    }else if (type == Top ){
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, size.width, 0.0);
    }else if (type == Bottom ){
        CGContextMoveToPoint(context, 0.0, size.height);
        CGContextAddLineToPoint(context, size.width, size.height);
    }
    CGContextStrokePath(context);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 裁剪图片为圆形

 @param sourceImage 原图片
 @param borderWidth 边框
 @param borderColor 边框颜色
 
 */
+ (UIImage *)zbcore_circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    CGFloat imageWidth = sourceImage.size.width + 2 * borderWidth;
    
    CGFloat imageHeight = sourceImage.size.height + 2 * borderWidth;
    
    //判定是否为正方形，防止截出椭圆
    if (imageWidth < imageHeight) {
        imageHeight = imageWidth;
    }else{
        imageWidth = imageHeight;
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0.0);
    
    UIGraphicsGetCurrentContext();
    
    CGFloat radius = (sourceImage.size.width < sourceImage.size.height?sourceImage.size.width:sourceImage.size.height)*0.5;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth * 0.5, imageHeight * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    bezierPath.lineWidth = borderWidth;
    
    [borderColor setStroke];
    
    [bezierPath stroke];
    
    [bezierPath addClip];
    
    [sourceImage drawInRect:CGRectMake(borderWidth, borderWidth, sourceImage.size.width, sourceImage.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

/**
 裁剪图片为圆形
 
 @param sourceImage 原图片
 
 */
+ (UIImage *)zbcore_circleImageWithImage:(UIImage *)sourceImage;{
    return [UIImage zbcore_circleImageWithImage: sourceImage borderWidth: 0.f borderColor: nil];
}
/**
 绘制圆点

 @param pointColor 圆点颜色
 @param pointSize  圆点大小

 @return 圆点
 */
+ (UIImage *)zbcore_circlePointImageWithColor: (UIColor *)pointColor size: (CGSize)pointSize{
    UIImage *colorImage = [UIImage zbcore_ImageWithColor: pointColor size: pointSize];
    
    return [UIImage zbcore_circleImageWithImage: colorImage borderWidth: 0 borderColor:0];
}
/**
 绘制圆点
 
 @param pointColor 圆点颜色
 @param pointSize  圆点大小
 
 @return 圆点
 */
+ (UIView *)zbcore_circlePointViewWithColor: (UIColor *)pointColor size: (CGSize)pointSize{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, pointSize.width, pointSize.height)];
    imageView.image = [UIImage zbcore_circlePointImageWithColor: pointColor size: pointSize];
    return imageView;
}

#define Mask8(x) ( (x) & 0xFF)
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )
/**
 处理图片添加半透明遮罩
 
 @param image 图片
 @param alpha 遮罩透明渡
 */
+ (UIImage *)zbcore_addHalfAlphaCover:(UIImage *)image alpha: (CGFloat)alpha{
    
    //1.获得图片的像素 以及上下文
    UInt32 *inputPixels;
    CGImageRef inputCGImage = [image CGImage];
    size_t w = CGImageGetWidth(inputCGImage);
    size_t h = CGImageGetHeight(inputCGImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSInteger bytesPerPixel = 4;//每个像素的字节数
    NSInteger bitsPerComponent = 8;//每个组成像素的 位深
    NSInteger bitmapBytesPerRow = w * bytesPerPixel;//每行字节数
    
    inputPixels = (UInt32 *)calloc(w * h , sizeof(UInt32));//通过calloc开辟一段连续的内存空间
    
    CGContextRef context = CGBitmapContextCreate(inputPixels, w, h, bitsPerComponent, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), inputCGImage);
    
    //2操作像素
    for (NSInteger j = 0; j < h; j ++) {
        for (NSInteger i = 0 ; i < w; i ++) {
            UInt32 *currentPixel = inputPixels + (w * j) + i;
            UInt32 color = *currentPixel;
            
            CGFloat k = 1 - alpha;
            
            if (A(color)) {
                UInt32 r = R(color) * k + 0 * k;
                UInt32 g = G(color) * k + 0 * k;
                UInt32 b = B(color) * k + 0 * k;
                //灰度图（举例）
                *currentPixel = RGBAMake(r, g, b, A(color));
            }
        }
    }
    //3从上下文中取出
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //4释放
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(inputPixels);
    
    return newImage;

    
}



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
                                        endPoint:(CGPoint)endPoint;{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //设置画布大小
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat locations[2] = {0.0,1.0};
#pragma clang diagnostic push
    
#pragma clang diagnostic ignored"-Wincompatible-pointer-types"
    
    UIColor *values[] = {startColor.CGColor, endColor.CGColor};
    
#pragma clang diagnostic pop
    
    
    CFArrayRef arrayRef = CFArrayCreate(kCFAllocatorDefault, (void *)values, (CFIndex)2, NULL);
    
    CGGradientRef gradient=CGGradientCreateWithColors(colorSpace, arrayRef, locations);
    
    CGRect rect[1] = {
        CGRectMake(0, 0, size.width, size.height)
    };
    CGContextClipToRects(context, rect, 1);
    //绘制渐变
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    //释放对象
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



/**
 异步处理图片添加半透明遮罩
 
 @param image 图片
 @param alpha 透明度
 @param completion 处理完成事件
 */
+ (void)zbcore_addHalfAlphaCover:(UIImage *)image alpha: (CGFloat)alpha completion: (void (^)(UIImage *sourceImage, UIImage *resultImage))completion;{
    dispatch_queue_t queue = dispatch_queue_create("com.zbjt.asysqueue.imagehandle", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        UIImage *resultImage = [UIImage zbcore_addHalfAlphaCover: image alpha: alpha];
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion(image, resultImage);
        });
        
    });
}


/**
 获取指定Bundle的图片
 */
+ (UIImage *)zbcore_bundleImageNamed:(NSString *)name bundleName: (NSString *)bundleName forClass: (Class)bundleClass{
    return [self zbcore_imageNamed:name inBundle:[NSBundle zbcore_myLibraryBundle: bundleName forClass: bundleClass]];
}

+ (UIImage *)zbcore_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
#else
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
    }
#endif
}
@end
