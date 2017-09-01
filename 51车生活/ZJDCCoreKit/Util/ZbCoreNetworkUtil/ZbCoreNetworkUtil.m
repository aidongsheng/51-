//
//  ZBNetworkUtil.m
//  ZBCocoaPod
//
//  Created by Prewindemon on 16/9/9.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import "ZbCoreNetworkUtil.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "ZBCoreKit.h"

@implementation ZbCoreNetworkUtil
static ZbCoreNetworkStatusBlock _status;
static BOOL _isNetwork;
static ZbCoreNetworkStatusEnum _netStatus;

#pragma mark - 开始监听网络
+ (void)zbcore_startMonitoringNetwork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                _status ? _status(ZBNetworkStatusUnknown) : nil;
                _isNetwork = NO;
                _netStatus = ZBNetworkStatusUnknown;
                ZBLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _status ? _status(ZBNetworkStatusNotReachable) : nil;
                _isNetwork = NO;
                _netStatus = ZBNetworkStatusNotReachable;
                ZBLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _status ? _status(ZBNetworkStatusReachableViaWWAN) : nil;
                _isNetwork = YES;
                _netStatus = ZBNetworkStatusReachableViaWWAN;
                ZBLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _status ? _status(ZBNetworkStatusReachableViaWiFi) : nil;
                _isNetwork = YES;
                _netStatus = ZBNetworkStatusReachableViaWiFi;
                ZBLog(@"WIFI");
                break;
        }
    }];
    [manager startMonitoring];
    
}

+ (void)zbcore_checkNetworkStatusWithBlock: (ZbCoreNetworkStatusBlock)status
{
    status ? _status = status : nil;
}

+ (BOOL)zbcore_currentNetworkStatus
{
    return _isNetwork;
}

+ (ZbCoreNetworkStatusEnum)zbcore_currentNetworkStatusEnum{
    return _netStatus;
}

#pragma mark - GET请求无缓存

+ (NSURLSessionTask *)zbcore_get:(NSString *)URL
               parameters:(NSDictionary *)parameters
                  success:(ZbCoreHttpRequestSuccessBlock)success
                  failure:(ZbCoreHttpRequestFailedBlock)failure
{
    return [self zbcore_get:URL parameters:parameters responseCache:nil success:success failure:failure];
}


#pragma mark - POST请求无缓存

+ (NSURLSessionTask *)zbcore_post:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(ZbCoreHttpRequestSuccessBlock)success
                   failure:(ZbCoreHttpRequestFailedBlock)failure
{
    return [self zbcore_post:URL parameters:parameters responseCache:nil success:success failure:failure];
}


#pragma mark - GET请求自动缓存

+ (NSURLSessionTask *)zbcore_get:(NSString *)URL
               parameters:(NSDictionary *)parameters
            responseCache:(ZbCoreHttpRequestCacheBlock)responseCache
                  success:(ZbCoreHttpRequestSuccessBlock)success
                  failure:(ZbCoreHttpRequestFailedBlock)failure{
    //设置key值
    __block NSString *cacheKey = [NSString stringWithFormat: @"%@?", URL];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        cacheKey = [NSString stringWithFormat: @"%@%@=%@&", cacheKey, [key isKindOfClass: [NSString class]] ? key : [key stringValue], [obj isKindOfClass: [NSString class]] ? obj : [obj stringValue]];
    }];

    
    //读取缓存
    responseCache ? responseCache([ZbCoreNetworkCache zbcore_getHttpCacheForKey: cacheKey]) : nil;
    
    AFHTTPSessionManager *manager = [self zbcore_createAFHTTPSessionManager];
    return [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(task, responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [ZbCoreNetworkCache zbcore_saveHttpCache:responseObject forKey: cacheKey] : nil;
        
//        ZBLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(task, error) : nil;
//        ZBLog(@"error = %@",error);
        
    }];
}


#pragma mark - POST请求自动缓存

+ (NSURLSessionTask *)zbcore_post:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(ZbCoreHttpRequestCacheBlock)responseCache
                   success:(ZbCoreHttpRequestSuccessBlock)success
                   failure:(ZbCoreHttpRequestFailedBlock)failure{
    //设置key值
    __block NSString *cacheKey = [NSString stringWithFormat: @"%@?", URL];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        cacheKey = [NSString stringWithFormat: @"%@%@=%@&", cacheKey, [key isKindOfClass: [NSString class]] ? key : [key stringValue], [obj isKindOfClass: [NSString class]] ? obj : [obj stringValue]];
    }];
    
    //读取缓存
    responseCache ? responseCache([ZbCoreNetworkCache zbcore_getHttpCacheForKey: cacheKey]) : nil;
    
    AFHTTPSessionManager *manager = [self zbcore_createAFHTTPSessionManager];
    return [manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(task, responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [ZbCoreNetworkCache zbcore_saveHttpCache:responseObject forKey: cacheKey] : nil;
        
//        ZBLog(@"responseObject = %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(task, error) : nil;
//        ZBLog(@"error = %@",error);
    }];
    
}


#pragma mark - 下载文件
+ (NSURLSessionTask *)zbcore_downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(ZbCoreHttpProgressBlock)progress
                              success:(void(^)(NSString *))success
                              failure:(ZbCoreHttpRequestFailedBlock)failure
{
    AFHTTPSessionManager *manager = [self zbcore_createAFHTTPSessionManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        progress ? progress(downloadProgress) : nil;
//        ZBLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
//        ZBLog(@"downloadDir = %@",downloadDir);
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(failure && error) {failure(nil, error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
    
}


#pragma mark - 设置AFHTTPSessionManager相关属性
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager,原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (AFHTTPSessionManager *)zbcore_createAFHTTPSessionManager
{
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    static AFHTTPSessionManager *manager;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        //设置请求参数的类型:HTTP (AFJSONRequestSerializer,AFHTTPRequestSerializer)
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //设置请求的超时时间
        manager.requestSerializer.timeoutInterval = 30.f;
        //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        
    });
    
    return manager;
}
@end
