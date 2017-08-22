//
//  CheckIDCard.h
//  IDCardClick
//
//  Created by allianture on 12-12-2.
//  Copyright (c) 2012年 allianture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckIDChard : NSObject



/* 校验身份证有效性 */
+ (BOOL)checkIDCard:(NSString *)str;

/* 获取性别 */
+ (NSString *)getSex:(NSString *)IDStr;

/* 获取生日 */
+ (NSString *)getBirthday:(NSString *)IDStr;


@end
