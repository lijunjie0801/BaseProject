//
//  Check.h
//  GUOHUALIFE
//
//  Created by allianture on 12-12-29.
//  Copyright (c) 2012年 zte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Check : NSObject


/* 验证生日 */
/* 验证生日是否属于一个区间 birthdayStr:出生年月日 mintype：最小值类型  minvalue：最小值数据 */
+ (BOOL)setBirthday:(NSString *)birthdayStr
            MinType:(NSString *)mintype
           MinValue:(NSString *)minvalue
            MaxType:(NSString *)maxtype
           MaxValue:(NSString *)maxvalue;



/* 验证数字 */
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
//*验证电话
+(BOOL)checkTelNumber:(NSString *)number;
//*验证姓名
+(BOOL)checkNAME:(NSString *)number;

// 校验是否为邮编
+(BOOL)checkyoubianNumber:(NSString *)youbianNum;


//*验证手机号
+(BOOL)checkMobileNumber:(NSString *)mobileNum;
//* 验证身份证 */
//* 校验身份证有效性 */
+ (BOOL)checkIDCard:(NSString *)str;

/* 检查url */
+ (BOOL)checkUrl:(NSString *)str;

/* 获取性别 */
+ (NSString *)getSex:(NSString *)IDStr;

/* 获取生日 */
+ (NSString *)getBirthday:(NSString *)IDStr;

//校验密码是否为数字字母组合大于6位
+(BOOL)judgePassWordLegal:(NSString *)pass;
@end
