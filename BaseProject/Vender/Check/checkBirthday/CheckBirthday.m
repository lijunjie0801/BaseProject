//
//  CheckBirthday.m
//  GUOHUALIFE
//
//  Created by allianture on 12-12-29.
//  Copyright (c) 2012年 zte. All rights reserved.
//

#import "CheckBirthday.h"

@implementation CheckBirthday


/* 验证生日是否属于一个区间 birthdayStr:出生年月日 mintype：最小值类型(Y M D)  minvalue：最小值数据 */
+ (BOOL)setBirthday:(NSString *)birthdayStr
            MinType:(NSString *)mintype
           MinValue:(NSString *)minvalue
            MaxType:(NSString *)maxtype
           MaxValue:(NSString *)maxvalue
{
    /* 字符串替换 去除' - '字符 */
    birthdayStr = [birthdayStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSInteger biryear = 0;
    NSInteger birmonth = 0;
    NSInteger birday = 0;
    
    if (birthdayStr.length == 8)
    {
        biryear = [[birthdayStr substringWithRange:NSMakeRange(0,4)] intValue];
        birmonth = [[birthdayStr substringWithRange:NSMakeRange(4,2)] intValue];
        birday = [[birthdayStr substringWithRange:NSMakeRange(6,2)] intValue];
        
        //   NSLog(@"%d,%d,%d",biryear,birmonth,birday);
    }
    else
    {
        return NO;
    }
    
    /* 设置时间 */
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    [components setYear:biryear];
    [components setMonth:birmonth];
    [components setDay:birday];
    
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    NSDate *birthdayDate = [gregorian dateFromComponents:components];
    
    /* 当前时间 */
    NSDate *today = [NSDate date];
    
    /* 获取时间差 */
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components1 = [gregorian components:unitFlags fromDate:birthdayDate toDate:today options:0];
    
    NSInteger year = [components1 year];
    NSInteger months = [components1 month];
    NSInteger days = [components1 day];
    
    /* 判定区间 */
    NSInteger allDays = (365 * year) + (months * 30) + days;
    NSInteger minInt = minvalue.intValue;
    NSInteger maxInt = maxvalue.intValue;
    
    if ([mintype isEqualToString:@"Y"])
    {
        minInt = minInt * 365;
    }
    else if ([mintype isEqualToString:@"M"])
    {
        minInt = minInt * 30;
    }
    
    if ([maxtype isEqualToString:@"Y"])
    {
        maxInt = (maxInt + 1) * 365;
    }
    else if ([maxtype isEqualToString:@"M"])
    {
        maxInt = (maxInt + 1) * 30;
    }
    
    if (allDays >= minInt && allDays <= maxInt)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    return NO;
}



@end
