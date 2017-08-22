/*
 
 验证数字的正则表达式集
 验证数字：^[0-9]*$
 验证n位的数字：^\d{n}$
 验证至少n位数字：^\d{n,}$
 验证m-n位的数字：^\d{m,n}$
 验证零和非零开头的数字：^(0|[1-9][0-9]*)$
 验证有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
 验证有1-3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
 验证非零的正整数：^\+?[1-9][0-9]*$
 验证非零的负整数：^\-[1-9][0-9]*$
 验证非负整数（正整数 + 0）  ^\d+$
 验证非正整数（负整数 + 0）  ^((-\d+)|(0+))$
 验证长度为3的字符：^.{3}$
 验证由26个英文字母组成的字符串：^[A-Za-z]+$
 验证由26个大写英文字母组成的字符串：^[A-Z]+$
 验证由26个小写英文字母组成的字符串：^[a-z]+$
 验证由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$
 验证由数字、26个英文字母或者下划线组成的字符串：^\w+$
 验证用户密码:^[a-zA-Z]\w{5,17}$ 正确格式为：以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 验证是否含有 ^%&',;=?$\" 等字符：[^%&',;=?$\x22]+
 验证汉字：^[\u4e00-\u9fa5],{0,}$
 验证Email地址：^\w+[-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$
 验证InternetURL：^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$
 验证电话号码：^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$：--正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX。
 验证身份证号（15位或18位数字）：^\d{15}|\d{}18$
 验证一年的12个月：^(0?[1-9]|1[0-2])$ 正确格式为：“01”-“09”和“1”“12”
 验证一个月的31天：^((0?[1-9])|((1|2)[0-9])|30|31)$    正确格式为：01、09和1、31。
 整数：^-?\d+$
 非负浮点数（正浮点数 + 0）：^\d+(\.\d+)?$
 正浮点数   ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
 非正浮点数（负浮点数 + 0） ^((-\d+(\.\d+)?)|(0+(\.0+)?))$
 负浮点数  ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
 浮点数  ^(-?\d+)(\.\d+)?
 
 
 */



#import "CheckNumber.h"

@interface CheckNumber ()

/* 正则 phoneRegex:校验规则  DataString:待校验字符串 */
+ (BOOL)getNSPredicate:(NSString *)phoneRegex DataString:(NSString *)dataStr;

@end


@implementation CheckNumber


/* 校验是否为整数 */
+ (BOOL)checkIsInt:(NSString *)numStr
{
    NSString *phoneRegex = @"^-?\[0-9]+$";
  
    return [self getNSPredicate:phoneRegex DataString:numStr];
}


/* 校验是否为 正 整数 */
+ (BOOL)checkIspositiveInt:(NSString *)numStr
{
    NSString *phoneRegex = @"^\?[1-9][0-9]*$";
   
    return [self getNSPredicate:phoneRegex DataString:numStr];
}


/* 校验是否为数字 */
+ (BOOL)checkIsNumber:(NSString *)numStr
{
    NSString *phoneRegex = @"^(-?\[0-9]+)(\\.\[0-9]+)?";
    
    return [self getNSPredicate:phoneRegex DataString:numStr];
}


/* 校验是否能被整除 */
+ (BOOL)checkIsdivisible:(NSString *)numStr
               divisible:(NSInteger)divNum
{
    BOOL isDiv = YES;
    
    isDiv = [self checkIspositiveInt:numStr];
    
    if (isDiv == NO)
    {
        return isDiv;
    }
    
    if ([numStr intValue] % divNum != 0)
    {
        isDiv = NO;
    }
    
    return isDiv;
}



#pragma -
#pragma mark - 数字 字母 下划线
/* 校验是否为数字字母 6-20个 */
+ (BOOL)checkIsDLU:(NSString *)textStr
{
    NSString *phoneRegex = @"[a-zA-Z0-9]{6,20}$";
    
    return [self getNSPredicate:phoneRegex DataString:textStr];
}


#pragma -
#pragma mark - 邮箱
/* 校验是否为邮箱 */
+ (BOOL)checkEmail:(NSString *)textStr
{
//    NSString *phoneRegex = @"^\\w+[-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
//    
//    return [self getNSPredicate:phoneRegex DataString:textStr];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:textStr];

}

#pragma -
#pragma mark - 电话
/* 校验是否为电话号码 */
+ (BOOL)checkTEL:(NSString *)textStr
{
    
//    NSString *telRegex = @"[0-9]{3,4}|[0-9]{3,4}-[0-9]{7,8}";
     NSString *telRegex = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [telTest evaluateWithObject:textStr];
    
}


#pragma -
#pragma mark - 姓名
/* 校验是否为姓名 */
+ (BOOL)checkNAME:(NSString *)textStr
{
    //NSString *nameRegex = @"^[\u4e00-\u9fa5],{0,}$";
    //NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    NSString *strss = textStr;
    for(int i=0; i< [strss length];i++)
    {
        int a = [strss characterAtIndex:i];
        
        if( a > 0x4e00 && a < 0x9fff)
        {
            
        }
        else
        {
            return NO;
        }

    }
    return YES;
    
}

#pragma -
#pragma mark - 邮编
/* 校验是否为邮编 */
+ (BOOL)checkyoubian:(NSString *)textStr
{
    NSString *telRegex = @"[0-9]{6}";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [telTest evaluateWithObject:textStr];
    
}
#pragma -
#pragma mark - url
/* 校验url 格式*/
+ (BOOL)checkUrl:(NSString *)textStr
{
    NSString *telRegex = @"^(http://)?(https://)?(www.)?([A-Za-z0-9])+(\\.[a-zA-Z]{2,4})+[/\\S]*$";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [telTest evaluateWithObject:textStr];
}

#pragma -
#pragma mark - 正则使用方式
/* 正则 phoneRegex:校验规则  DataString:待校验字符串 */
+ (BOOL)getNSPredicate:(NSString *)phoneRegex DataString:(NSString *)dataStr
{
    BOOL predicate = YES;
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if (![phoneTest evaluateWithObject:dataStr])
    {
        predicate = NO;
    }
    
    return predicate;
}



@end
