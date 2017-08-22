//
//  CustomWebViewController.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/10.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomWebViewDelegate<NSObject>
-(void)payFinish;
@end
@interface CustomWebViewController : UIViewController
@property(nonatomic,strong)NSString *webUrl;
@property(nonatomic, weak)id<CustomWebViewDelegate>delegate;
@end
