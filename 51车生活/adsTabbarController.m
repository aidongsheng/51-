//
//  adsTabbarController.m
//  Pods
//
//  Created by aidongsheng on 2017/8/31.
//
//

#import "adsTabbarController.h"

@interface adsTabbarController ()

@end

@implementation adsTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;

}

- (void)setRootControllers:(NSArray *)rootControllers
{
    if (rootControllers.count) {
        UINavigationController * indexNaviController = [self navControllerWithTabbarItemTitle:@"首页"
                                                                         tabbarItemImageNamed:@"ads_tabbar_index"
                                                                   tabbarItemSelectImageNamed:@"ads_tabbar_index_select"
                                                                               rootController:rootControllers[0] ? rootControllers[0] : nil];
        UINavigationController * rescueNaviController = [self navControllerWithTabbarItemTitle:@"51救援"
                                                                          tabbarItemImageNamed:@"ads_tabbar_rescue"
                                                                    tabbarItemSelectImageNamed:@"ads_tabbar_rescue_select"
                                                                                rootController:rootControllers[1] ? rootControllers[1] : nil];
        UINavigationController * carLifeNaviController = [self navControllerWithTabbarItemTitle:@"51车生活"
                                                                           tabbarItemImageNamed:@"ads_tabbar_carlife"
                                                                     tabbarItemSelectImageNamed:@"ads_tabbar_carlife_select"
                                                                                 rootController:rootControllers[2] ? rootControllers[2] : nil];
        UINavigationController * exploreNaviController = [self navControllerWithTabbarItemTitle:@"发现"
                                                                           tabbarItemImageNamed:@"ads_tabbar_explore"
                                                                     tabbarItemSelectImageNamed:@"ads_tabbar_explore_select"
                                                                                 rootController:rootControllers[3] ? rootControllers[3] : nil];
        UINavigationController * mineNaviController = [self navControllerWithTabbarItemTitle:@"我的"
                                                                        tabbarItemImageNamed:@"ads_tabbar_mine"
                                                                  tabbarItemSelectImageNamed:@"ads_tabbar_mine_select"
                                                                              rootController:rootControllers[4] ? rootControllers[4] : nil];
        
        self.viewControllers = @[indexNaviController,rescueNaviController,carLifeNaviController,exploreNaviController,mineNaviController];
    }
}

/**
 生成导航控制器

 @param title tabbarcontroller 的标题
 @param imageName 默认状态的 tabbaritem 的图片名
 @param selectImageName 选中状态的 tabbaritem 的图片名
 @param controller UInavigationcontroller 的根控制器
 @return 导航控制器
 */
- (UINavigationController *)navControllerWithTabbarItemTitle:(NSString *)title
                                        tabbarItemImageNamed:(NSString *)imageName
                                  tabbarItemSelectImageNamed:(NSString *)selectImageName
                                              rootController:(UIViewController *)controller
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [bundle pathForResource:@"adsTabbarController" ofType:@"bundle"];
    
    UIImage * image, * selectImage;
    
    if (bundlePath) {
        bundle = [NSBundle bundleWithPath:bundlePath];
        image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil ];
        selectImage = [UIImage imageNamed:selectImageName inBundle:bundle compatibleWithTraitCollection:nil ];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
    UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:title
                                                       image:image
                                               selectedImage:selectImage];
        // 设置选中 tabbaritem 字体属性
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:18/255.0 green:150/255.0 blue:219/255.0 alpha:1],NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:10]} forState:UIControlStateSelected];
        // 设置非选中 tabbaritem 字体属性
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1],NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:10]} forState:UIControlStateNormal];
    
    nav.tabBarItem = item;
    nav.navigationBar.translucent = NO;
    return nav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
