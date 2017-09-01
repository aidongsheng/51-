//
//  ZbCoreUserDefaults.m
//  Pods
//
//  Created by Prewindemon on 2017/5/26.
//
//

#import "ZbCoreUserDefaults.h"

NSString * const ZbCoreUserDefaultsChangingNotificaiton = @"com.zbjt.ZbCoreUserDefaultsChangingNotificaiton";

@implementation ZbCoreUserDefaults
/**
 获取UserDefault
 
 @param defaultName 名称
 @return 内容
 */
+ (id)objectForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] objectForKey: defaultName];
}
/**
 设置UserDefault
 
 @param value 值
 @param defaultName 键
 */
+ (void)setObject:(id)value forKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] setObject:value
                                              forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZbCoreUserDefaultsChangingNotificaiton
                                                        object:defaultName];
}
/**
 移除UserDefault
 
 @param defaultName 键
 */
+ (void)removeObjectForKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZbCoreUserDefaultsChangingNotificaiton
                                                        object:defaultName];
}

@end
