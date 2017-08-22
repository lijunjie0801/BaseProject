//
//  ZZLProgressHUD.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "ZZLProgressHUD.h"
#import "SVProgressHUD.h"
@implementation ZZLProgressHUD
+ (void)showSuccessMessage:(NSString *)msg
{
    [self setHubColor];
    [SVProgressHUD showSuccessWithStatus:msg];
}

+ (void)showWarningMessage:(NSString *)msg
{
    [self setHubColor];
    //    [SVProgressHUD showWithStatus:msg maskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:msg];
}

+ (void)showErrorMessage:(NSString *)msg
{
    [self setHubColor];
    [SVProgressHUD showErrorWithStatus:msg];
    
}


+ (void)showHUDWithMessage:(NSString *)msg
{
    [self setHubColor];
    [SVProgressHUD showWithStatus:msg];
}

+ (void)showProgress:(float)progress status:(NSString*)status
{
    [self setHubColor];
    [SVProgressHUD showProgress:progress status:status];
}

+ (void)popHUD
{
    
    [SVProgressHUD dismiss];
    
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    UIView *view = [window viewWithTag:100800];
    //    [view removeFromSuperview];
    //
    //    double delayInSeconds = 0.5;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        [SVProgressHUD popActivity];
    //    });
}
//设置指示器颜色
+ (void)setHubColor
{
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

@end
