



#import <Foundation/Foundation.h>

@interface CheckBirthday : NSObject



/* 验证生日是否属于一个区间 birthdayStr:出生年月日 mintype：最小值类型  minvalue：最小值数据 */
+ (BOOL)setBirthday:(NSString *)birthdayStr
            MinType:(NSString *)mintype
           MinValue:(NSString *)minvalue
            MaxType:(NSString *)maxtype
           MaxValue:(NSString *)maxvalue;


@end
