//
//  UIView+ZBFrame.m
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/8/27.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import "UIView+ZbCoreExtension.h"
#import "Masonry.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (ZbCoreExtension)

// Retrieve and set the origin
- (CGPoint) zbcore_origin{
    return self.frame.origin;
}
- (void)setZbcore_origin:(CGPoint)zbcore_origin{
    CGRect newframe = self.frame;
    newframe.origin = zbcore_origin;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) zbcore_size{
    return self.frame.size;
}

-(void)setZbcore_size:(CGSize)zbcore_size{
    CGRect newframe = self.frame;
    newframe.size = zbcore_size;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) zbcore_bottomRight{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) zbcore_bottomLeft{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) zbcore_topRight{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

- (CGFloat) zbcore_height{
    return self.frame.size.height;
}
- (void)setZbcore_height:(CGFloat)zbcore_height{
    CGRect newframe = self.frame;
    newframe.size.height = zbcore_height;
    self.frame = newframe;
}

- (CGFloat) zbcore_width{
    return self.frame.size.width;
}
- (void)setZbcore_width:(CGFloat)zbcore_width{
    CGRect newframe = self.frame;
    newframe.size.width = zbcore_width;
    self.frame = newframe;
}

- (CGFloat) zbcore_y{
    return self.frame.origin.y;
}
- (void)setZbcore_y:(CGFloat)zbcore_y{
    CGRect newframe = self.frame;
    newframe.origin.y = zbcore_y;
    self.frame = newframe;
}

- (CGFloat) zbcore_x{
    return self.frame.origin.x;
}

- (void) setZbcore_x:(CGFloat)zbcore_x{
    CGRect newframe = self.frame;
    newframe.origin.x = zbcore_x;
    self.frame = newframe;
}

- (CGFloat) zbcore_bottom{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setZbcore_bottom:(CGFloat)zbcore_bottom{
    CGRect newframe = self.frame;
    newframe.origin.y = zbcore_bottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) zbcore_right{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setZbcore_right:(CGFloat)zbcore_right{
    CGFloat delta = zbcore_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (CGFloat)zbcore_centerX{
    return self.center.x;
}

- (void)setZbcore_centerX:(CGFloat)zbcore_centerX{
    CGPoint newPoint = self.center;
    newPoint.x = zbcore_centerX;
    self.center = newPoint;
}

- (CGFloat)zbcore_centerY{
    return self.center.y;
}

- (void)setZbcore_centerY:(CGFloat)zbcore_centerY{
    CGPoint newPoint = self.center;
    newPoint.y = zbcore_centerY;
    self.center = newPoint;
}

// Move via offset
- (void) zbcore_moveBy: (CGSize) size{
    CGPoint newcenter = self.center;
    newcenter.x += size.width;
    newcenter.y += size.height;
    self.center = newcenter;
}

// Scaling
- (void) zbcore_scaleBy: (CGFloat) scaleFactor{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) zbcore_fitInSize: (CGSize) aSize{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;	
}

#pragma mark =========================动画Extension=========================
/**
 显示动画悬浮字体
 
 @param word 内容
 @param textFont 字体
 @param textColor 字体颜色
 @param mas_block 字体布局，决定了字体停留位置
 @param animation 动画
 */
- (void)zbcore_showAnimationWord:(NSString *)word textFont:(UIFont *)textFont textColor:(UIColor *)textColor constrants:(void(^)(MASConstraintMaker *make))mas_block animation:(CAAnimation *)animation;{
    if (!self.window) {
        NSLog(@"视图不再Window中");
        return;
    }
    /** 生成文字视图 */
    UILabel *wordLabel = [UILabel new];
    wordLabel.font = textFont;
    wordLabel.textColor = textColor;
    wordLabel.textAlignment = NSTextAlignmentCenter;
    wordLabel.text = word;
    wordLabel.layer.opacity = 0.f;
    
    [self.window addSubview:wordLabel];
    
    [wordLabel mas_makeConstraints:mas_block];
    
    [wordLabel.layer addAnimation:animation forKey:@"zbcore_word_show_animation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wordLabel.layer removeAllAnimations];
        [wordLabel removeFromSuperview];
    });
}
/**
 显示动画悬浮字体
 
 @param word 内容
 @param textFont 字体
 @param textColor 字体颜色
 @param mas_block 字体布局，决定了字体停留位置
 */
- (void)zbcore_showAnimationWord:(NSString *)word textFont:(UIFont *)textFont textColor:(UIColor *)textColor constrants:(void(^)(MASConstraintMaker *make))mas_block;{
    if (!self.window) {
        NSLog(@"视图不再Window中");
        return;
    }
    
    CGFloat height = self.zbcore_height;
    if (height <= 0) {
        height = 30.f;
    }
    /** 透明度动画 */
    CAKeyframeAnimation *animationOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animationOpacity.values = @[@(0),@(1),@(1),@(0)];
    
    /** 位置大小动画 */
    CAKeyframeAnimation *animationTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animationTransform.values = @[
                                  [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(0.0, 0.0, 1.0),CATransform3DMakeTranslation(0.f, height * 0.8, 0.f))],
                                  [NSValue valueWithCATransform3D:CATransform3DIdentity],
                                  [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(1.0, 1.0, 1.0),CATransform3DMakeTranslation(0.f, -height * 0.2, 0.f))],
                                  [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1.0),CATransform3DMakeTranslation(0.f, -height * 0.7, 0.f))]
                                  ];
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animationOpacity, animationTransform];
    animationGroup.duration = 2.f;
    
    [self zbcore_showAnimationWord:word textFont:textFont textColor:textColor constrants:mas_block animation:animationGroup];
}

#pragma mark =========================控制器相关=========================

/**
 获取该View存在的Controller
 */
- (UIViewController *)zbcore_currentContainedController;{
    id responder = self;;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
    }
    return responder;
}

@end
