//
//  httpManagers.m
//  httpManager
//
//  Created by lei on 16/6/13.
//  Copyright © 2016年 lei. All rights reserved.
//

#import "HttpManagers.h"

@interface HttpManagers()
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@end

@implementation HttpManagers

  static HttpManagers *manager = nil;
+(instancetype)sharedNetManager{
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        
    });
    return manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
        
    });
    return manager;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
        self.sessionManager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
//        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 60);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    }
    return self;
}


/**
 *  封装的get请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters IsCache:(BOOL)isCache ShowMsg:(NSString *)msg success:(Success)success failure:(Failure)failure
{
    
    
    if ([HttpManagers isNetWorkConnectionAvailable]==YES) {
        
        if (msg.length) {
            
        }
        
        [self.sessionManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            if (success)
            {
               NSLog(@"接口地址:%@ \n 参数:%@ \n",URLString,parameters);
                success(responseObject);
            }
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
          
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure)
            {
              
                failure(error);
            }
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
          
        }];
        
    }else{
       
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
        [JRToast showWithText:@"无网络连接,请检查网络" duration:3.f];
    }
}

/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters IsCache:(BOOL)isCache ShowMsg:(NSString *)msg success:(Success)success failure:(Failure)failure
{
    
    
    
    if ([HttpManagers isNetWorkConnectionAvailable]==YES) {
        
        
        if (msg.length) {
           
        }
        
        [self.sessionManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            if (success)
            {
                NSLog(@"接口地址:%@ \n 参数:%@ \n",URLString,parameters);
                
                success(responseObject);
            }
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
            
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure)
            {
              
                failure(error);
            }
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
            
        }];
        
    }else{
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        [JRToast showWithText:@"无网络连接,请检查网络" duration:3.f];
    }
    
}

+ (BOOL)isNetWorkConnectionAvailable
{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.zds-shop.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"%@",NotReachable);
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            NSLog(@"3G/4G");
            break;
    }
    return isExistenceNetwork;
    
    
    
}

-(void)startNotifierReachability{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    // 2.设置网络状态改变后的处理
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                NetManagerShare.netWorkStatus = NetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                NetManagerShare.netWorkStatus = NetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                NetManagerShare.netWorkStatus = NetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                NetManagerShare.netWorkStatus = NetworkStatusReachableViaWiFi;
                
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
}

- (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"zds-shop" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

@end
