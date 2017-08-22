//
//  LoginViewController.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginDelegate<NSObject>
-(void)loginSuccess;
@end
@interface LoginViewController : UIViewController
@property(nonatomic,weak)id<LoginDelegate>delegate;
@end
