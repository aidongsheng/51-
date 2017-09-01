//
//  ZJDCHud.h
//  Pods
//
//  Created by aidongsheng on 2017/8/15.
//
//

#import <Foundation/Foundation.h>

@interface ZJDCHud : NSObject


/**
 hud 模块单例类方法

 @return DCACHud 单例对象
 */
+ (ZJDCHud *)shareHud;


- (void)showIndeterminate;

- (void)showLabel;

- (void)showDetailsLabel;

- (void)showWindow;

- (void)showDeterminate;

- (void)showDeterminateNSProgress;

- (void)showAnnularDeterminate;

- (void)showBarDeterminate;

- (void)showCustomView;

- (void)showText;

- (void)showCancelAction;

- (void)showModeSwitching;

- (void)showNetworking ;

- (void)showDimBackground;

- (void)showColor;


@end
