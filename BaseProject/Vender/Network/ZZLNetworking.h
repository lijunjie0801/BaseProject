//
//  ZZLNetworking.h
//  networking
//
//  Created by lei on 16/7/26.
//  Copyright © 2016年 lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifdef DEBUG
#define LAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define LAppLog(s, ... )
#endif


typedef NS_ENUM(NSUInteger, ZZLAFNetworkReachabilityStatus) {
    ZZLAFNetworkReachabilityStatusUnkonw             = -1,   // 未知网络
    ZZLAFNetworkReachabilityStatusNotReachable       = 0,    // 网络无法链接
    ZZLAFNetworkReachabilityStatusReachableViaWWAN   = 1,    // 2，3，4G
    ZZLAFNetworkReachabilityStatusReachableViaWiFi   = 2     // WIFI
};


typedef NS_ENUM(NSUInteger, ZZLServerRequestsStatus) {
    ZZLServerRequestsStatusFail              = 0,        // 请求失败
    ZZLServerRequestsStatusSuccess           = 1,        // 请求成功
    ZZLServerRequestsStatusNotConnected      = 2,        // 无法连接
    ZZLServerRequestsStatusconnectedTimeOut  = 3         // 请求超时
};

typedef NS_ENUM(NSUInteger, ZZLResponseType) {
    ZZLResponseTypeJSON = 1,         // 默认
    ZZLResponseTypeXML  = 2,         // XML
    ZZLResponseTypeData = 3          // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
};

typedef NS_ENUM(NSUInteger, ZZLRequestType) {
    ZZLRequestTypeJSON       = 1,    // 默认
    ZZLRequestTypePlainText  = 2     // 普通text/html
};

typedef NSURLSessionTask ZZLURLSessionTask;

typedef void(^ZZLResponseSuccess)(ZZLServerRequestsStatus status, ZZLAFNetworkReachabilityStatus reachability,  id response);

typedef void(^ZZLResponseFail)(ZZLServerRequestsStatus status, ZZLAFNetworkReachabilityStatus reachability, id response, NSError *error);


typedef void(^ZZLLoadProgress)(int_fast64_t bytesRead, int_fast64_t totalBytesRead);


@interface ZZLNetworking : NSObject

/**
 *  更新请求接口基础url（如果服务器地址有多个）
 *  @param baseUrl 请求接口基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;


/**
 *  配置公共的请求头，用于区分请求来源，需要与服务器约定好
 *  @param httpHeaders      如@{"client" : "iOS"}
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;


/**
 *  GET请求接口
 *  @param url          访问地址路径，如/user/index/login
 *  @param refreshCache 是否刷新缓存，YES
 *  @param params       需要传的参数，如@{@"user_id" :@(80011)}
 *  @param progress     进度回调，
 *  @param success      接口请求响应成功回调
 *  @param fail         接口请求响应失败回调
 *  @return             NSURLSessionTask
 */
+ (ZZLURLSessionTask *)getWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                          params:(NSDictionary *)params
                        progress:(ZZLLoadProgress)progress
                         success:(ZZLResponseSuccess)success
                            fail:(ZZLResponseFail)fail;

/**
 *  POST请求接口
 *  @param url          访问地址路径，如/user/index/login
 *  @param refreshCache 是否刷新缓存，YES
 *  @param params       需要传的参数，如@{@"user_id" :@(80011)}
 *  @param progress     进度回调，
 *  @param success      接口请求响应成功回调
 *  @param fail         接口请求响应失败回调
 *  @return             NSURLSessionTask
 */
+ (ZZLURLSessionTask *)postWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                         progress:(ZZLLoadProgress)progress
                          success:(ZZLResponseSuccess)success
                             fail:(ZZLResponseFail)fail;


/**
 *  图片上传接口
 *  @param imageArray        图片数组
 *  @param url          上传图片路径，如/user/images
 *  @param parameters   需要传的参数，如@{@"user_id" :@(80011)}
 *  @param progress     上传进度回调
 *  @param success      上传成功回调
 *  @param fail         上传失败回调
 *  @return             NSURLSessionTask
 */
+ (ZZLURLSessionTask *)uploadWithImageArray:(NSArray *)imageArray
                                  url:(NSString *)url
                           parameters:(NSDictionary *)parameters
                             progress:(ZZLLoadProgress)progress
                              success:(ZZLResponseSuccess)success
                                 fail:(ZZLResponseFail)fail;


/**
 *  上传文件
 *  @param url              上传文件路径，如/user/images
 *  @param uploadingFile    待上传文件路径，如/user/images
 *  @param progress         进度回调
 *  @param success          上传成功回调
 *  @param fail             上传失败回调
 *  @return                 NSURLSessionTask
 */
+ (ZZLURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                               progress:(ZZLLoadProgress)progress
                                success:(ZZLResponseSuccess)success
                                   fail:(ZZLResponseFail)fail;


/**
 *  下载文件
 *  @param url              下载文件URL
 *  @param saveToPath       下载到那个路径下
 *  @param progress         下载进度
 *  @param success          下载成功后的回调
 *  @param fail             下载失败后的回调
 *  @return NSURLSessionTask
 */
+ (ZZLURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(ZZLLoadProgress)progress
                              success:(ZZLResponseSuccess)success
                                 fail:(ZZLResponseFail)fail;






@end


























