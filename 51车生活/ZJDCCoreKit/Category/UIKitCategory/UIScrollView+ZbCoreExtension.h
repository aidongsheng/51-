//
//  UITableView+ZbCoreExtension.h
//  Pods
//
//  Created by Prewindemon on 2017/5/18.
//
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZbCoreExtension)
/**
 滚动到顶部
 
 @param animated 是否动画
 */
- (void)zbcore_ScrollToTopAnimated:(BOOL)animated;

@end
