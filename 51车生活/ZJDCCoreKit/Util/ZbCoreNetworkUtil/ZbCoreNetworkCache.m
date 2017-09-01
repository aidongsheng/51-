//
//  ZBNetworkCache.m
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/9/9.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import "ZbCoreNetworkCache.h"
#import <YYCache/YYCache.h>

@implementation ZbCoreNetworkCache

static NSString *const ZBNetworkResponseCache = @"com.zbjt.ZbCoreNetworkResponseCache";
static YYCache *_dataCache;


+ (void)initialize
{
    _dataCache = [YYCache cacheWithName: ZBNetworkResponseCache];
}

+ (void)zbcore_saveHttpCache:(id)httpCache forKey:(NSString *)key
{
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpCache forKey:key withBlock:nil];
}

+ (id)zbcore_getHttpCacheForKey:(NSString *)key
{
    return [_dataCache objectForKey:key];
}

+ (NSInteger)zbcore_getAllHttpCacheSize
{
    return [_dataCache.diskCache totalCost];
}

+ (void)zbcore_removeAllHttpCache
{
    [_dataCache.diskCache removeAllObjects];
}

@end
