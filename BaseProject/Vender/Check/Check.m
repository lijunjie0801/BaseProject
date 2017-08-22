

#import "Check.h"

#import "CheckBirthday.h"
#import "CheckNumber.h"
#import "CheckIDChard.h"


@implementation Check

/* 验证生日 */
/* 验证生日是否属于一个区间 birthdayStr:出生年月日 mintype：最小值类型  minvalue：最小值数据 */
+ (BOOL)setBirthday:(NSString *)birthdayStr
            MinType:(NSString *)mintype
           MinValue:(NSString *)minvalue
            MaxType:(NSString *)maxtype
           MaxValue:(NSString *)maxvalue
{
    return [CheckBirthday setBirthday:birthdayStr MinType:mintype MinValue:minvalue MaxType:maxtype MaxValue:maxvalue];
}



/* 验证数字 */
/* 校验是否为 整数 */
+ (BOOL)checkIsInt:(NSString *)numStr
{
    return [CheckNumber checkIsInt:numStr];
}

/* 校验是否为 正 整数 */
+ (BOOL)checkIspositiveInt:(NSString *)numStr
{
    return [CheckNumber checkIspositiveInt:numStr];
}

/* 校验是否为 数字 */
+ (BOOL)checkIsNumber:(NSString *)numStr
{
    return [CheckNumber checkIsNumber:numStr];
}

/* 校验是否能被整除 */
+ (BOOL)checkIsdivisible:(NSString *)numStr divisible:(NSInteger)divNum
{
    return [CheckNumber checkIsdivisible:numStr divisible:divNum];
}

/* 校验是否为数字字母下划线 */
+ (BOOL)checkIsDLU:(NSString *)textStr
{
    return [CheckNumber checkIsDLU:textStr];
}


/* 校验是否为邮箱 */
+ (BOOL)checkEmail:(NSString *)textStr
{
    return [CheckNumber checkEmail:textStr];
}
// 校验是否为电话
+(BOOL)checkTelNumber:(NSString *)number
{
    return [CheckNumber checkTEL:number];
}

// 校验是否姓名
+(BOOL)checkNAME:(NSString *)number
{
    return [CheckNumber checkNAME:number];
}

// 校验是否为邮编
+(BOOL)checkyoubianNumber:(NSString *)youbianNum
{
    return [CheckNumber checkyoubian:youbianNum];
}


// 校验是否为手机号码
+(BOOL)checkMobileNumber:(NSString *)mobileNum
{
    if (![mobileNum isKindOfClass:[NSString class]])
    {
        return NO;
    }
    if (STRING_ISNIL(mobileNum))
    {
        return NO;
    }
    if ([mobileNum hasPrefix:@"86"])
    {
        NSMutableString *phoneStr = [[NSMutableString alloc]initWithFormat:@"%@",mobileNum];
        mobileNum = [phoneStr substringFromIndex:2];
    }
    
    //手机号以13,15,17,18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
    
// //   NSLog(@"%@",mobileNum);
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    //NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSString * MOBILE = @"^1(3[4-9]|47|5[012789]|8[78])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,181,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

/* 验证身份证 */
/* 校验身份证有效性 */
+ (BOOL)checkIDCard:(NSString *)str
{

    if (str == nil || [str isEqualToString:@""])
    {
        return NO;
    }
    
    return [CheckIDChard checkIDCard:str];
}
/* 检查url */
+ (BOOL)checkUrl:(NSString *)str
{
    if (str == nil || [str isEqualToString:@""])
    {
        return NO;
    }
    
    return [CheckNumber checkUrl:str];
}
/* 获取性别 */
+ (NSString *)getSex:(NSString *)IDStr
{
    return [CheckIDChard getSex:IDStr];
}

/* 获取生日 */
+ (NSString *)getBirthday:(NSString *)IDStr
{
    return [CheckIDChard getBirthday:IDStr];
}

/*  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于6位
 2. 密码中必须同时包含数字和字母
 */
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}


@end
