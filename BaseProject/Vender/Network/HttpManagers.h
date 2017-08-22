//
//  httpManagers.h
//  httpManager
//
//  Created by lei on 16/6/13.
//  Copyright © 2016年 lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkActivityIndicatorManager.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>



#define NetManagerShare [HttpManagers sharedNetManager]
NS_ASSUME_NONNULL_BEGIN



typedef void (^Success)(id responseObject);     // 成功Block
typedef void (^Failure)(NSError *error);        // 失败Blcok
typedef void (^Progress)(NSProgress *progress); // 上传或者下载进度Block
typedef NSURL * _Nullable (^ _Nullable Destination)(NSURL *targetPath, NSURLResponse *response); //返回URL的Block
typedef void (^ _Nullable DownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath); // 下载成功的Blcok
typedef NS_ENUM(NSUInteger, NetworkStatuses)
{
    /*! 未知网络 */
    NetworkStatusUnknown           = 0,
    /*! 没有网络 */
    NetworkStatusNotReachable,
    /*! 手机自带网络 */
    NetworkStatusReachableViaWWAN,
    /*! wifi */
    NetworkStatusReachableViaWiFi
};

@interface HttpManagers : NSObject

@property (nonatomic, assign)NetworkStatuses netWorkStatus;
/**
 *  上传图片大小(kb)
 */
@property (nonatomic, assign) NSUInteger picSize;

/**
 *  超时时间(默认20秒)
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;

/**
 *  封装的GET请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary * __nullable)parameters IsCache:(BOOL)isCache ShowMsg:(NSString * __nullable)msg success:(Success)success failure:(Failure)failure;

/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary * __nullable)parameters IsCache:(BOOL)isCache ShowMsg:(NSString * __nullable)msg success:(Success)success failure:(Failure)failure;



/**
 *  单例
 */
+ (instancetype)sharedNetManager;

/**
 *  判断网络
 */
+ (BOOL)isNetWorkConnectionAvailable;
/**
 *  监听网络
 */
- (void)startNotifierReachability;



@end

NS_ASSUME_NONNULL_END
