//
//  CheckNumber.h
//  GUOHUALIFE
//
//  Created by allianture on 12-12-28.
//  Copyright (c) 2012年 zte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckNumber : NSObject


/* 校验是否为整数 */
+ (BOOL)checkIsInt:(NSString *)numStr;

/* 校验是否为 正 整数 */
+ (BOOL)checkIspositiveInt:(NSString *)numStr;

/* 校验是否为数字 */
+ (BOOL)checkIsNumber:(NSString *)numStr;

/* 校验是否能被整除 */
+ (BOOL)checkIsdivisible:(NSString *)numStr divisible:(NSInteger)divNum;

/* 校验是否为数字字母下划线 */
+ (BOOL)checkIsDLU:(NSString *)textStr;

/* 校验是否为邮箱 */
+ (BOOL)checkEmail:(NSString *)textStr;


/* 校验是否为电话号码 */
+ (BOOL)checkTEL:(NSString *)textStr;


/* 校验是否为姓名 */
+ (BOOL)checkNAME:(NSString *)textStr;

/* 校验是否为邮编 */
+ (BOOL)checkyoubian:(NSString *)textStr;

/* 校验url 格式*/
+ (BOOL)checkUrl:(NSString *)textStr;
@end
