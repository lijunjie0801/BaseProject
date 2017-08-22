//
//  ZZLProgressHUD.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZLProgressHUD : NSObject
/**
 *  成功提示消息
 *
 *  @param msg 消息
 */
+ (void)showSuccessMessage:(NSString *)msg;


/**
 *  等待提示消息
 *
 *  @param msg 消息
 */
+ (void)showWarningMessage:(NSString *)msg;

/**
 *  错误提示
 *
 *  @param msg 消息
 */
+ (void)showErrorMessage:(NSString *)msg;

/**
 *  提示消息
 *
 *  @param msg 消息
 */
+ (void)showHUDWithMessage:(NSString *)msg;


+ (void)showProgress:(float)progress status:(NSString*)status;


/**
 *  取消提示
 *
 *
 */
+ (void)popHUD;

@end
