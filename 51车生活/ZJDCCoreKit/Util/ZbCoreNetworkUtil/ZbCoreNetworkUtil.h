//
//  ZBNetworkUtil.h
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/9/9.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZbCoreNetworkCache.h"
#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSUInteger, ZbCoreNetworkStatusEnum) {
    /** 未知网络*/
    ZBNetworkStatusUnknown,
    /** 无网络*/
    ZBNetworkStatusNotReachable,
    /** 手机网络*/
    ZBNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    ZBNetworkStatusReachableViaWiFi
};


/** 请求成功的Block */
typedef void(^ZbCoreHttpRequestSuccessBlock)(NSURLSessionDataTask *task,id responseObject);

/** 请求失败的Block */
typedef void(^ZbCoreHttpRequestFailedBlock)(NSURLSessionDataTask *task,NSError *error);

/** 缓存的Block */
typedef void(^ZbCoreHttpRequestCacheBlock)(id responseCache);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^ZbCoreHttpProgressBlock)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^ZbCoreNetworkStatusBlock)(ZbCoreNetworkStatusEnum status);

@interface ZbCoreNetworkUtil : NSObject
/**
 *  开始监听网络状态(此方法在整个项目中只需要调用一次)
 */
+ (void)zbcore_startMonitoringNetwork;

/**
 *  通过Block回调实时获取网络状态
 */
+ (void)zbcore_checkNetworkStatusWithBlock: (ZbCoreNetworkStatusBlock)status;

/**
 *  获取当前网络状态,有网YES,无网:NO
 */
+ (BOOL)zbcore_currentNetworkStatus;

/**
 获取当前网络状态
 
 @return ZbCoreNetworkStatusEnum
 */
+ (ZbCoreNetworkStatusEnum)zbcore_currentNetworkStatusEnum;

/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)zbcore_get:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                           success:(ZbCoreHttpRequestSuccessBlock)success
                           failure:(ZbCoreHttpRequestFailedBlock)failure;

/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)zbcore_get:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                     responseCache:(ZbCoreHttpRequestCacheBlock)responseCache
                           success:(ZbCoreHttpRequestSuccessBlock)success
                           failure:(ZbCoreHttpRequestFailedBlock)failure;

/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)zbcore_post:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                            success:(ZbCoreHttpRequestSuccessBlock)success
                            failure:(ZbCoreHttpRequestFailedBlock)failure;

/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)zbcore_post:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                      responseCache:(ZbCoreHttpRequestCacheBlock)responseCache
                            success:(ZbCoreHttpRequestSuccessBlock)success
                            failure:(ZbCoreHttpRequestFailedBlock)failure;


/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)zbcore_downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(ZbCoreHttpProgressBlock)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(ZbCoreHttpRequestFailedBlock)failure;

/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager,原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (AFHTTPSessionManager *)zbcore_createAFHTTPSessionManager;
@end
