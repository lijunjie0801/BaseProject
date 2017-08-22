//
//  AppDelegate.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/17.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "AppDelegate.h"
#import "CYRootTabViewController.h"
#import "LoginViewController.h"
#import "UserGuideViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <Bugly/Bugly.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "FirstOpenViewController.h"
//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
@interface AppDelegate ()<WXApiDelegate,QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:2.0];
    [self getCateData];
   
      [DEFAULTS setObject:@"0" forKey:@"selindex"];
    UINavigationBar *naviGationBar = [UINavigationBar appearance];
    naviGationBar.translucent = NO;
    [naviGationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [naviGationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    FirstOpenViewController *openVC = [[FirstOpenViewController alloc]init];
    if (![DEFAULTS boolForKey:@"first"]) {
        [DEFAULTS setBool:YES forKey:@"isLoginToHome"];
        [DEFAULTS setBool:YES forKey:@"first"];
        [DEFAULTS setBool:YES forKey:@"isWifiShow"];
        [self.window setRootViewController:openVC];
    }else{
        [self.window setRootViewController:rootVC];
    }
    [self.window makeKeyAndVisible];

    [Bugly startWithAppId:@"99c3f9c711"];
    [ShareSDK registerApp:@"a1031310f563"
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSinaWeibo),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];

                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"2452979128"
                                           appSecret:@"090d8c0e85dd75c7b277fa213448b251"
                                         redirectUri:@"https://api.weibo.com/oauth2/default.html"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx0727f2b6b7a9e1e1"
                                       appSecret:@"9f6d3fc5ffbb573661c1127ee1ec6335"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106046309"
                                      appKey:@"8fhOG36ZeQQ25guv"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
    [WXApi registerApp:@"wx0727f2b6b7a9e1e1"];
    return YES;
}
-(void)getCateData{
//    NSFileManager* fileManager=[NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documents = [paths lastObject];
//    NSString *documentPath = [documents stringByAppendingPathComponent:@"arrayXML.xml"];
//    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:documentPath];
//    if (!blHave) {
//        NSLog(@"no  have");
//        return ;
//    }else {
//        NSLog(@" have");
//        BOOL blDele= [fileManager removeItemAtPath:documentPath error:nil];
//        if (blDele) {
//            NSLog(@"dele success");
//            
//        }else {
//            NSLog(@"dele fail");
//        }
//    }
    [[HttpManagerPort sharedHttpManagerPort]getCategory:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *arr=responseObject[@"datas"][@"category"];
                NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documents = [array lastObject];
                NSString *documentPath = [documents stringByAppendingPathComponent:@"arrayXML.xml"];
                [arr writeToFile:documentPath atomically:YES];
           
        }  
    } Failure:^(NSError *error) {
        
    }];
    
}

//- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options {
//    // 因为在我们的应用中可能不止实现一种分享途径，可能还有微信啊 微博啊这些，所以在这里最好判断一下。
//    // QQAPPID:是你在QQ开放平台注册应用时候的AppID
//    if ([url.scheme isEqualToString:@"wx3429c79dea710c6f"]) {
//         NSLog(@"lijunjie..%@",[WXApi handleOpenURL:url delegate:self]?@"yes":@"no");
//        return [WXApi handleOpenURL:url delegate:self];
//    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",@"1105290946"]]) {
//        NSLog(@"lijunjie..%@",[QQApiInterface handleOpenURL:url delegate:self]?@"yes":@"no");
//        return [QQApiInterface handleOpenURL:url delegate:self];
//    }else {
//        return YES;
//    }
//}
-(void)checkNet{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //return status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                 [NSObject showHudTipStr:@"未识别的网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                [NSObject showHudTipStr:@"未连接网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
             //   [NSObject showHudTipStr:@"2G,3G,4G...的网络"];
                NSLog(@"2G,3G,4G...的网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //[NSObject showHudTipStr:@"2G,3G,4G...的网络"];
                NSLog(@"wifi的网络");
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self]||[TencentOAuth HandleOpenURL:url];
}

// this happens while we are running ( in the background, or from within our own app )
// only valid if HelloCordova-Info.plist specifies a protocol to handle
//- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
//{
//
////    if ([url.scheme isEqualToString:@"wx3429c79dea710c6f"]) {
////        NSLog(@"lijunjie..%@",[WXApi handleOpenURL:url delegate:self]?@"yes":@"no");
////        return [WXApi handleOpenURL:url delegate:self];
////    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",@"1105290946"]]) {
////        return [QQApiInterface handleOpenURL:url delegate:self];
////    }else {
////        return YES;
////    }
//    if (!url) {
//        return NO;
//    }

//    
//    if ([sourceApplication isEqualToString:@"com.tencent.xin"]) {
//        return  [WXApi handleOpenURL:url delegate:self];
//    }
//    if ([url.host isEqualToString:@"safepay"]) {
//        NSLog(@"支付宝返回url_2： = %@", url);
//        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//        }];
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//
//            NSLog(@"支付宝返回： = %@", resultDic);
//            NSString *resultStatus=resultDic[@"resultStatus"];
//            if ([resultStatus isEqualToString:@"9000"]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//                
//                
//            }else{
//                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//                
//            }
//        }];
//        
//        
//    };
//    return YES;
//    
//
//  
//}

- (void)onResp:(BaseResp *)resp {
    NSLog(@"回调");
//    NSString * strTitle = [NSString stringWithFormat:@"支付结果"];
//    NSString *strMsg;
//    if (resp.errCode==0) {
//        strMsg=@"恭喜你，支付成功";
//    }else if (resp.errCode==-2){
//        strMsg = @"已取消支付!";
//    }else{
//        strMsg = @"支付失败!";
//    }
    if ([self.delegate respondsToSelector:@selector(huidiao:)]) {
        [self.delegate huidiao:[NSString stringWithFormat:@"%d",resp.errCode]];
    }

}






- (void)getWeiXinCodeFinishedWithResp:(BaseResp *)resp
{
    
    if (resp.errCode == 0)
    {
        
        
        SendAuthResp * sendResp = (SendAuthResp *)resp;
        
        
        if(![resp isKindOfClass:[SendMessageToWXResp class]])
            
        {
            [self getWeChatLoginCode:sendResp.code];
        }
        
        
        
        
        return;
        
    }else if (resp.errCode == -4)
    {
        return;
    }else if (resp.errCode == -2)
    {
        return;
    }
}
- (void)getWeChatLoginCode:(NSString *)code {
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx3429c79dea710c6f",@"65129c5f2eb588be6bc2a1bf6b1fae41",code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                _access_token = [dic objectForKey:@"access_token"];
                _openid = [dic objectForKey:@"openid"];
                [self getUserInfo];
            }
        });
    });
}

-(void)getUserInfo
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",_access_token,_openid];
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"BaseProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"pay"])
        
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //一般只需要调用这一个方法即可
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result1 == %@",resultDic);
        }];
        
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             NSLog(@"result2 = %@",resultDic);
                                             NSString *resultStr = resultDic[@"result"];
                                             NSLog(@"result3 = %@",resultStr);
                                         }];
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result4 = %@",resultDic);
        }];
    }
    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if ([url.host isEqualToString:@"pay"])
        
    {
        return [WXApi handleOpenURL:url delegate:self];
    }

    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"resultw = %@",resultDic);
        }];
        
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             NSLog(@"resulte = %@",resultDic);
                                             NSString *resultStr = resultDic[@"result"];
                                             NSLog(@"resultr = %@",resultStr);
                                         }];
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"resultq = %@",resultDic);
        }];
    }
    return YES;
}
//当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application {
     [self saveContext];
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (void)applicationDidBecomeActive:(UIApplication *)application

{
//    [self.delegate stopVideo];
    NSLog(@"\n ===> 程序重新激活 !");
    
}
@end
