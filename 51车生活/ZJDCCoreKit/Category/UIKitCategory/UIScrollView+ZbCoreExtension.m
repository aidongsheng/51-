//
//  UITableView+ZbCoreExtension.m
//  Pods
//
//  Created by Prewindemon on 2017/5/18.
//
//

#import "UIScrollView+ZbCoreExtension.h"

@implementation UIScrollView (ZbCoreExtension)

/**
 滚动到顶部

 @param animated 是否动画
 */
- (void)zbcore_ScrollToTopAnimated:(BOOL)animated;{
    [self setContentOffset:CGPointMake(0, 0) animated:animated];
}
@end
