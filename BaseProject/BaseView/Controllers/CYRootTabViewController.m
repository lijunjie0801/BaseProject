//
//  CYRootTabViewController.m
//  IOSFramework
//
//  Created by xu on 16/3/14.
//
//

#import "CYRootTabViewController.h"
#import "RDVTabBarItem.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "LoginViewController.h"
#import "FifthViewController.h"
@interface CYRootTabViewController ()<LoginDelegate>

@end

@implementation CYRootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];

    [self setupViewControllers];
    
    [self customizeTabBarForController];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toSencondCtr:) name:@"toSencondCtr" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toThirdCtr:) name:@"toThirdCtr" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)toSencondCtr:(NSNotification *)notifi{
    self.selectedIndex=1;
}
-(void)toThirdCtr:(NSNotification *)notifi{
    self.selectedIndex=3;
}
- (void)toSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点了底下第几个%ld",index);
}
- (void)setupViewControllers {
    
    FirstViewController *firstCtr = [[FirstViewController alloc] init];
   
    UINavigationController *nav_First = [[UINavigationController alloc] initWithRootViewController:firstCtr];
    
    SecondViewController *secondCtr = [[SecondViewController alloc] init];
    UINavigationController *nav_second = [[UINavigationController alloc] initWithRootViewController:secondCtr];
    
    
    ThirdViewController *thirdCtr = [[ThirdViewController alloc] init];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:thirdCtr];
    
    ForthViewController *fourthCtr = [[ForthViewController alloc] init];
    UINavigationController *nav_fourth = [[UINavigationController alloc] initWithRootViewController:fourthCtr];
    
    FifthViewController *fifthCtr=[[FifthViewController alloc]init];
        UINavigationController *nav_fifth = [[UINavigationController alloc] initWithRootViewController:fifthCtr];
    [self setViewControllers:@[nav_First, nav_second, nav_third, nav_fourth,fifthCtr]];
    
}
-(void)loginSuccess{
    [self showMessage:@"登录成功"];
}
- (void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    showview.frame = CGRectMake((kScreen_Width - 90 )/2, (kScreen_Height-90)/2.0 , 90, 90);
    [window addSubview:showview];
    
    UIImageView *_imageView = [[UIImageView alloc]init];
    [_imageView setFrame:CGRectMake((90 - 30)/2.0, 20, 30, 30)];
    _imageView.image = [UIImage imageNamed:@"toast_success"];
    [showview addSubview:_imageView];
    
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 60, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    
    [UIView animateWithDuration:2 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished)
     {
         [showview removeFromSuperview];
    
     }];
}

- (BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index{
//    NSLog(@"yuyu%ld",index);
    if ([DEFAULTS boolForKey:@"isLogin"]!=YES) {
        if (index==3||index==4) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                LoginViewController *login = [[LoginViewController alloc]init];
                login.delegate=self;
                CATransition * animation = [CATransition animation];
                animation.duration = 0.5;    //  时间
                animation.type = @"pageCurl";
                animation.type = kCATransitionPush;
                animation.subtype = kCATransitionFromRight;
                
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self presentViewController: login animated:YES completion:nil];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            return NO;
            
        }

    }
    
    return YES;
}
- (void)customizeTabBarForController {
    NSArray *tabBarItemImages = @[@"homePage", @"search", @"progress",@"shoppingcart", @"me"];
    NSArray *tabBarItemTitles = @[@"首页", @"课程", @"商城", @"购物车",@"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
         item.titlePositionAdjustment = UIOffsetMake(0, 3.0);
//        item.imagePositionAdjustment=UIOffsetMake(0, 2.0);
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}


@end
