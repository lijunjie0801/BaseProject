//
//  PubDefine.h
//  MiaoPurchase
//
//  Created by Echo on 16/10/12.
//  Copyright © 2016年 dlb. All rights reserved.
//

#ifndef PubDefine_h
#define PubDefine_h


//区分开发环境和生产环境的参数
#ifdef DEBUG

#define JPush_Tag @"test"
#define JPush_isProduction  NO

#else

#define JPush_Tag @"product"
#define JPush_isProduction YES


#endif
//极光Appkey
#define Jpush_AppKey @""

//接口基础地址
//#define Http_Base_Url @"http://www.tlsesc.com"

#define LoginInfoBool
#define User_id  @"User_Id"
#define User_pwd @"User_pwd"

//图片接口
#define Http_Base_UrlPic @"http://www.tlsesc.com"




//设备信息
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
//[NSUserDefaults standardUserDefaults]
#define DEFAULTS [NSUserDefaults standardUserDefaults]

//每页多少数量
#define PageSize 20

#define numberHeight 45


//项目配置
#define textFieldHeight 72
//常用颜色设置
#define WindowTintColor [UIColor colorWithHexString:@"#e72a2a"]
#define WindColor [UIColor colorWithHexString:@"#e72a2a"]
#define DefaultBackgroundColor [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]
#define DefauiltColor  [UIColor colorWithHexString:@"#333333"]
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define btnBackColor [UIColor colorWithHexString:@"#f67a77"]
//字体大小
#define Font_9 [UIFont systemFontOfSize:9]
#define Font_10 [UIFont systemFontOfSize:10]
#define Font_11 [UIFont systemFontOfSize:11]
#define Font_12 [UIFont systemFontOfSize:12]
#define Font_13 [UIFont systemFontOfSize:13]
#define Font_14 [UIFont systemFontOfSize:14]
#define Font_15 [UIFont systemFontOfSize:15]
#define Font_16 [UIFont systemFontOfSize:16]
#define Font_17 [UIFont systemFontOfSize:17]
#define Font_18 [UIFont systemFontOfSize:18]
#define Font_19 [UIFont systemFontOfSize:19]
#define Font_20 [UIFont systemFontOfSize:20]

#define RGBS(R,G,B) [UIColor colorWithRed:R green:G blue:B alpha:1]

//是否是ipad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define ISIOS7_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.99)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_8_4_BEFORE    ([[[UIDevice currentDevice] systemVersion] floatValue] <= 10.0f)

// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH_Ipad (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.width : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width))

// 屏幕高度，会根据横竖屏的变化而变化
#define SCREEN_HEIGHT_Ipad (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.height : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height))
#endif /* PubDefine_h */
