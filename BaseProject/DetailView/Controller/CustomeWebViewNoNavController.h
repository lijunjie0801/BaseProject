//
//  CustomeWebViewNoNavController.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/11.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomeWebViewNoNavDelegate<NSObject>
-(void)tocommentWeb;
@end
@interface CustomeWebViewNoNavController : UIViewController
@property(nonatomic,strong)NSString *webUrl;
@property(nonatomic, weak)id<CustomeWebViewNoNavDelegate>delegate;
@end
