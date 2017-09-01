//
//  UIView+ZBFrame.h
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/8/27.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MASConstraintMaker;
//获取视图中心点。
CGPoint CGRectGetCenter(CGRect rect);

//视图当前点，移动至中心点。返回cgrect
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ZbCoreExtension)

@property CGPoint zbcore_origin;

@property CGSize zbcore_size;

@property CGFloat zbcore_height;

@property CGFloat zbcore_width;

@property CGFloat zbcore_x;

@property CGFloat zbcore_y;

@property CGFloat zbcore_bottom;

@property CGFloat zbcore_right;

@property CGFloat zbcore_centerX;

@property CGFloat zbcore_centerY;

@property (readonly) CGPoint zbcore_bottomLeft;

@property (readonly) CGPoint zbcore_bottomRight;

@property (readonly) CGPoint zbcore_topRight;

/**
 *  移动某个距离
 *
 *  @param size 大小
 */
- (void) zbcore_moveBy: (CGSize) size;
/**
 *  放大缩小
 *
 *  @param scaleFactor 比例
 */
- (void) zbcore_scaleBy: (CGFloat) scaleFactor;
/**
 *  适应大小
 *
 *  @param aSize 大小
 */
- (void) zbcore_fitInSize: (CGSize) aSize;

#pragma mark =========================动画Extension=========================

/**
 显示动画悬浮字体

 @param word 内容
 @param textFont 字体
 @param textColor 字体颜色
 @param mas_block 字体布局，决定了字体停留位置
 */
- (void)zbcore_showAnimationWord:(NSString *)word textFont:(UIFont *)textFont textColor:(UIColor *)textColor constrants:(void(^)(MASConstraintMaker *make))mas_block;


/**
 显示动画悬浮字体
 
 @param word 内容
 @param textFont 字体
 @param textColor 字体颜色
 @param mas_block 字体布局，决定了字体停留位置
 @param animation 动画
 */
- (void)zbcore_showAnimationWord:(NSString *)word textFont:(UIFont *)textFont textColor:(UIColor *)textColor constrants:(void(^)(MASConstraintMaker *make))mas_block animation:(CAAnimation *)animation;


#pragma mark =========================控制器相关=========================


/**
 获取该View存在的Controller
 */
- (UIViewController *)zbcore_currentContainedController;

@end
