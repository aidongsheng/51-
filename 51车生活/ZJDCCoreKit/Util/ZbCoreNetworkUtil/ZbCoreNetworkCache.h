//
//  ZBNetworkCache.h
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/9/9.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZbCoreNetworkCache : NSObject

/**
 *  缓存网络数据
 *
 *  @param httpCache 服务器返回的数据
 *  @param key           缓存数据对应的key值,推荐填入请求的URL
 */
+ (void)zbcore_saveHttpCache:(id)httpCache forKey:(NSString *)key;

/**
 *  取出缓存的数据
 *
 *  @param key 根据存入时候填入的key值来取出对应的数据
 *
 *  @return 缓存的数据
 */
+ (id)zbcore_getHttpCacheForKey:(NSString *)key;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)zbcore_getAllHttpCacheSize;


/**
 *  删除所有网络缓存,
 */
+ (void)zbcore_removeAllHttpCache;

@end
