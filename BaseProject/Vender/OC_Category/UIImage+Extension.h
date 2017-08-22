//
//  UIImage+Extension.h
//  TALib
//
//  Created by 天安 on 16/10/14.
//  Copyright © 2016年 天安. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
#pragma mark 返回拉伸好的图片
+ (UIImage *)resizeImage:(NSString *)imgName;

- (UIImage *)resizeImage;

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 *  生成一个带圆环的图片
 *
 *  @param name   图片的名称
 *  @param border 圆环的宽度
 *  @param color  圆环的颜色
 *
 */
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;

/**
 *  截屏
 *
 *  @param view 需要截屏的视图
 *
 */
+ (instancetype)imageWithCaptureView:(UIView *)view;

/**
 *  将图片进行base64转码
 *
 *  @param image 图片
 *
 *  @return base64编码的图片
 */
+ (NSString *)encodeToBase64String:(UIImage *)image;
/**
 *  base64格式图片解码
 *
 *  @param strEncodeData base64字符串
 *
 *  @return 图片
 */
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;
@end
