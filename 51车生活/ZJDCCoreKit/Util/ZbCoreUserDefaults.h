//
//  ZbCoreUserDefaults.h
//  Pods
//
//  Created by Prewindemon on 2017/5/26.
//
//

#import <Foundation/Foundation.h>


//设置UserDefault时，会发送该通知
extern NSString *const ZbCoreUserDefaultsChangingNotificaiton;

@interface ZbCoreUserDefaults : NSObject


/**
 获取UserDefault

 @param defaultName 名称
 @return 内容
 */
+ (id)objectForKey:(NSString *)defaultName;


/**
 设置UserDefault

 @param value 值
 @param defaultName 键
 */
+ (void)setObject:(id)value forKey:(NSString *)defaultName;


/**
 移除UserDefault

 @param defaultName 键
 */
+ (void)removeObjectForKey:(NSString *)defaultName;

@end
