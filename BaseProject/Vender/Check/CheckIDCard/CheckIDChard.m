
/*
 15位身份证号码：第7、8位为出生年份（两位数），第9、10位为出生月份，第11、12位代表出生日期，第15位代表性别，奇数为男，偶数为女。
 
 18位身份证号码：第7、8、9、10位为出生年份（四位数），第11、第12位为出生月份，第13、14位代表出生日期，第17位代表性别，奇数为男，偶数为女。
 
 
 //（1）15位的身份证号码：
 //1~6位为地区代码，
 //7~8位为出生年份(2位)，（19xx）
 //9~10位为出生月份，
 //11~12位为出生日期，
 //第13~15位为顺序号，并能够判断性别，奇数为男，偶数为女。
 
 //（2）18位的身份证号码：
 //1~6位为地区代码，
 //7~10位为出生年份(4位)，
 //11~12位为出生月份，
 //13~14位为出生日期，
 //第15~17位为顺序号， 并能够判断性别，奇数为男，偶数为女。
 //18位为效验位
 
 */


#import "CheckIDChard.h"


@interface CheckIDChard ()

int checkIDfromchar (const char *sPaperId);

@end


@implementation CheckIDChard


int checkIDfromchar (const char *sPaperId)
{
    long lSumQT =0;
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };   //加权因子
    char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};  //校验码
    if( 18 != strlen(sPaperId)) return 0;  //检验长度
    //校验数字
    for (int i=0; i<18; i++){
        if ( !isdigit(sPaperId[i]) && !(('X' == sPaperId[i] || 'x' == sPaperId[i]) && 17 == i) ) {
            return 0;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)  {
        lSumQT += (sPaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != sPaperId[17] ){
        return 0;
    }
    return 1;
}


/* 校验身份证有效性 */
+ (BOOL)checkIDCard:(NSString *)str{
    return checkIDfromchar((char *)[str UTF8String]);
}


/* 获取性别 */
+ (NSString *)getSex:(NSString *)IDStr
{
    NSString *sexStr = nil;
    
    if (18 == IDStr.length)
    {
        /* 18位 */
        sexStr = [IDStr substringFromIndex:14]; //截取第x位之后字符串
        sexStr = [sexStr substringToIndex:3];   //截取第x位之前字符串
        
        if ([sexStr intValue] % 2 == 0)
        {
            sexStr = @"1"; //女
        }
        else
        {
            sexStr = @"0"; //男
        }
        
    }
    else if (15 == IDStr.length)
    {
        /* 15位 */
        sexStr = [IDStr substringFromIndex:12]; //截取第x位之后字符串
        sexStr = [sexStr substringToIndex:3];   //截取第x位之前字符串
        
        if ([sexStr intValue] % 2 == 0)
        {
            sexStr = @"1";  //女
        }   
        else
        {
            sexStr = @"0";  //男
        }
        
    }
    
    
    return sexStr;
}


/* 获取生日 */
+ (NSString *)getBirthday:(NSString *)IDStr
{
    NSString *birthdayStr = nil;
    
    NSString *yearStr = nil;
    NSString *monthStr = nil;
    NSString *dayStr = nil;
    
    if (18 == IDStr.length)
    {
        /* 18位 */
        yearStr = [IDStr substringFromIndex:6]; //截取第x位之后字符串
        yearStr = [yearStr substringToIndex:4];   //截取第x位之前字符串
        
        monthStr = [IDStr substringFromIndex:10];
        monthStr = [monthStr substringToIndex:2];
        
        dayStr = [IDStr substringFromIndex:12];
        dayStr = [dayStr substringToIndex:2];
        
        birthdayStr = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
        
    }
    else if (15 == IDStr.length)
    {
        /* 15位 */
        yearStr = [IDStr substringFromIndex:6]; //截取第x位之后字符串
        yearStr = [yearStr substringToIndex:2];   //截取第x位之前字符串
        
        monthStr = [IDStr substringFromIndex:8];
        monthStr = [monthStr substringToIndex:2];
        
        dayStr = [IDStr substringFromIndex:10];
        dayStr = [dayStr substringToIndex:2];
        
        birthdayStr = [NSString stringWithFormat:@"19%@-%@-%@",yearStr,monthStr,dayStr];
    }
    
    return birthdayStr;
}


/* 获取年龄 单位：天 */



@end
