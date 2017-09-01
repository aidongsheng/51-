//
//  UIButton+ZBExtension.h
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/9/5.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZbCoreUIButtonClickBlock)(UIButton *button);

@interface UIButton (ZbCoreExtension)

/**
 *  按钮标题
 */
@property(nonatomic, strong)NSString *zbcore_title;

/**
 *  标题颜色
 */
@property(nonatomic, strong)UIColor *zbcore_titleColor;

/**
 *  标题字体
 */
@property(nonatomic, strong)UIFont *zbcore_font;

/**
 *  按钮背景-以图片的形式
 */
@property(nonatomic, strong)UIColor *zbcore_backgroundColor;


/**
 *  block添加点击事件
 */
- (void)zbcore_addClickBlock: (ZbCoreUIButtonClickBlock) block;

/**
 扩大响应的边距
 */
@property (nonatomic) UIEdgeInsets zbcore_hitTestEdgeInsets;

@end
