//
//  AppDelegate.m
//  51车生活
//
//  Created by aidongsheng on 2017/8/29.
//  Copyright © 2017年 aidongsheng. All rights reserved.
//

#import "AppDelegate.h"
#import "adsTabbarController.h"
#import "ZJDCIndexViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupRootControllers];
    
    return YES;
}

/**
 设定项目根控制器
 */
- (void)setupRootControllers
{
    adsTabbarController * tabbar_controller = [[adsTabbarController alloc]init];
    ZJDCIndexViewController * indexController = [[ZJDCIndexViewController alloc]init];
    
    tabbar_controller.rootControllers = @[indexController];
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = tabbar_controller;
    [_window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
