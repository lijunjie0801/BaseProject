//
//  UserGuideViewController.m
//  DecorateTogether
//
//  Created by lijunjie on 15/12/18.
//  Copyright © 2015年 Aiken. All rights reserved.
//

#import "UserGuideViewController.h"
#import "CYRootTabViewController.h"
#import "AppDelegate.h"
#define kLoginStatus @"login_status"
@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
         [self initGuide];   //加载新用户指导页面
}
- (void)initGuide
 {
     UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
     scrollView.bounces=NO;
     scrollView.pagingEnabled=YES;
         [scrollView setContentSize:CGSizeMake(kScreen_Width*4, 0)];
         [scrollView setPagingEnabled:YES];  //视图整页显示
         //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    
     for (int i=0; i<4; i++) {
         UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreen_Width, 0, kScreen_Width, kScreen_Height)];
         NSString *img = [NSString stringWithFormat:@"tutorial_%d.png",i+1];
         [imageview setImage:[UIImage imageNamed:img]];
         [scrollView addSubview:imageview];
         imageview.userInteractionEnabled=YES;
         if (i==3) {
             UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
             button.frame = CGRectMake((kScreen_Width-120)/2, kScreen_Height-30-20, 120, 30);
             
             [button setImage:[UIImage imageNamed:@"tutorial_enter"] forState:UIControlStateNormal];
             [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
             [imageview addSubview:button];
             
             
         }

     }
     
     
         [self.view addSubview:scrollView];
        // [scrollView release];
     }
- (void)firstpressed
 {
  
     AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     CYRootTabViewController *rootView=[[CYRootTabViewController alloc]init];
     [appdelegate.window setRootViewController:rootView];
     
    
}
     

     


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
