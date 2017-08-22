//
//  UILog.h
//  ZDSApp
//
//  Created by lei on 16/6/18.
//  Copyright © 2016年 lei. All rights reserved.
//

#import <Foundation/Foundation.h>


void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);


@interface UILog : NSObject

/*! NSLog 仅在调试模式 */
#ifdef DEBUG
#define UILog(args ...) ExtendNSLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args);
#define UILogString [BALog logString]
#define UILogClear [BALog clearLog]
#else
#define UILog(args ...)
#define UILogString
#define UILogClear
#endif

/**
 *  清除日志字符串.
 *  可以用BALogClear宏调用它
 */
+ (void)clearLog;

/**
 *  获取日志字符串.
 *  可以用STLogString宏调用它
 */
+ (NSString *)logString;




@end
