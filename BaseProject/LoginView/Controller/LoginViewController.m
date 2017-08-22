//
//  LoginViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "CYRootTabViewController.h"
#import "ForgetPwdViewController.h"
#import "AppDelegate.h"
#import "BindaccountViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface LoginViewController ()
@property(nonatomic,strong)UIView *filter;
@property(nonatomic,strong)UILabel *loginTitle;
@property(nonatomic,strong)NSArray *permissions;
@property(nonatomic,strong)UITextField *phoneNumText;
@property(nonatomic,strong)UITextField *passwordText;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGifView];
   
}
-(void)setGifView{

    
    UIImageView *filter = [[UIImageView alloc] initWithFrame:self.view.bounds];
    filter.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1f];
    filter.image=[UIImage imageNamed:@"backImage"];
    filter.userInteractionEnabled=YES;
    self.filter=filter;
    [self.view addSubview:filter];

    UILabel *loginTitle=[[UILabel alloc]init];
    self.loginTitle=loginTitle;
    loginTitle.textAlignment=UITextAlignmentCenter;
    loginTitle.font=[UIFont systemFontOfSize:20];;
    loginTitle.text=@"与食有关的艺术空间";
    loginTitle.textColor=[UIColor whiteColor];
    [filter addSubview:loginTitle];
    [loginTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [loginTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [loginTitle autoSetDimensionsToSize:CGSizeMake(kScreen_Width, 25)];
    
     UIButton *backBtn=[[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
    [filter addSubview:backBtn];
    [backBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
    [backBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [backBtn autoSetDimensionsToSize:CGSizeMake(40, 40)];
    [backBtn addTarget:self action:@selector(dissBack) forControlEvents:UIControlEventTouchUpInside];
    [self setLoginUI];
    
}
- (void)dissBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLoginUI{
    /*账号框*/
    UITextField *phoneNumText = [[UITextField alloc]init];
    [self.filter addSubview:phoneNumText];
    phoneNumText.backgroundColor = [UIColor whiteColor];
    phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
     phoneNumText.layer.cornerRadius = 6.0;
    self.phoneNumText = phoneNumText;
    
    phoneNumText.placeholder = @"请输入手机号";
    UIView *phoneLeftView = [[UIView alloc]init];
    [phoneLeftView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    UIImageView *phoneImage = [[UIImageView alloc]init];
     [phoneImage autoSetDimensionsToSize:CGSizeMake(20, 20)];
//    phoneImage.center = phoneLeftView.center;
    [phoneLeftView addSubview:phoneImage];
    phoneImage.image = [UIImage imageNamed:@"shoujihaoma"];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    
    phoneNumText.leftView = phoneLeftView;
    phoneNumText.leftViewMode = UITextFieldViewModeAlways;
    phoneNumText.delegate = self;
    [phoneNumText autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-30)/8];
    [phoneNumText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [phoneNumText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneNumText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginTitle withOffset:25];

    
    /*密码框*/
    UITextField *passwordText = [[UITextField alloc]init];
    passwordText.layer.cornerRadius = 6.0;
    passwordText.secureTextEntry = YES;
    [self.filter addSubview:passwordText];
    passwordText.backgroundColor = [UIColor whiteColor];
    passwordText.placeholder = @"请输入密码";
    self.passwordText = passwordText;
    UIView *passLeftView = [[UIView alloc]init];
    [passLeftView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    UIImageView *passImage = [[UIImageView alloc]init];
      [passImage autoSetDimensionsToSize:CGSizeMake(20, 20)];
    passImage.image = [UIImage imageNamed:@"password"];
    [passLeftView addSubview:passImage];
    [passImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [passImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    passwordText.leftView = passLeftView;
    passwordText.leftViewMode = UITextFieldViewModeAlways;
    passwordText.delegate = self;
    [passwordText autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-30)/8];

    [passwordText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [passwordText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [passwordText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumText withOffset:20];
    /*登录按钮*/
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"0x59c5b7"]];
    [self.filter addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-30)/8];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:passwordText withOffset:30];
    /*注册*/
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.filter addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    [registerBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [registerBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:10];
    /*找回密码*/
    UIButton *backPasswordBtn = [[UIButton alloc]init];
    [backPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [backPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:backPasswordBtn];
    [backPasswordBtn addTarget:self action:@selector(backPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [backPasswordBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    [backPasswordBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [backPasswordBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:10];
    
       /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.filter addGestureRecognizer:tapGestureRecognizer];
  
    UIView *leftLine = [[UIView alloc]init];
    [leftLine setBackgroundColor:[UIColor whiteColor]];
    [self.filter addSubview:leftLine];
    [leftLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [leftLine autoSetDimensionsToSize:CGSizeMake(80, 1)];
    [leftLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:registerBtn withOffset:70];
       UIView *rightLine = [[UIView alloc]init];
    [rightLine setBackgroundColor:[UIColor whiteColor]];
    [self.filter addSubview:rightLine];
    [rightLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [rightLine autoSetDimensionsToSize:CGSizeMake(80, 1)];
    [rightLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:registerBtn withOffset:70];
    
    UILabel *ThirdLabel=[[UILabel alloc]init];
    ThirdLabel.text=@"第三方登录";
    [self.filter addSubview:ThirdLabel];
    ThirdLabel.textColor=[UIColor whiteColor];
    ThirdLabel.textAlignment=UITextAlignmentCenter;
    [ThirdLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftLine withOffset:0];
    [ThirdLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:rightLine withOffset:0];
    [ThirdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:registerBtn withOffset:60];
    [ThirdLabel autoSetDimension:ALDimensionHeight toSize:21];
    CGFloat jiange=kScreen_Width-90-160;
    NSArray *textArray=@[@"QQ",@"微信"];
    NSArray *imageNameArray=@[@"qq",@"weixin"];
    for (int i=0; i<textArray.count; i++) {
        UIButton *thirdBtn=[[UIButton alloc]init];
        [thirdBtn setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        [self.filter addSubview:thirdBtn];
        [thirdBtn autoSetDimensionsToSize:CGSizeMake(80, 80)];
        [thirdBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:i*(80+jiange)+45];
        [thirdBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:ThirdLabel withOffset:18];
        [thirdBtn addTarget:self action:@selector(thridLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *thirdtextLabel=[[UILabel alloc]init];
        thirdBtn.tag=i;
        thirdtextLabel.text=textArray[i];
        thirdtextLabel.textColor=[UIColor whiteColor];
        thirdtextLabel.textAlignment=UITextAlignmentCenter;
        [self.filter addSubview:thirdtextLabel];
        [thirdtextLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
        [thirdtextLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:i*(80+jiange)+45];
        [thirdtextLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:ThirdLabel withOffset:100];
  
    }

}
-(void)thridLogin:(UIButton *)sender{
    SSDKPlatformType type=SSDKPlatformTypeUnknown;
    if (sender.tag==0) {
        type=SSDKPlatformTypeQQ;
    }else if(sender.tag==1){
        type=SSDKPlatformTypeWechat;
    }else{
        type=SSDKPlatformTypeSinaWeibo;
    }
    [DEFAULTS setObject:[NSString stringWithFormat:@"%ld",sender.tag] forKey:@"LoginType"];
    [ShareSDK getUserInfo:type
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             [kNetManager authorizationLogin:user.uid type:[NSString stringWithFormat:@"%ld",sender.tag] Success:^(id responseObject) {
                 NSLog(@"是否授权%@",responseObject);
                 if ([responseObject[@"status"] integerValue]==100) {
                     [ZZLProgressHUD showHUDWithMessage:@"正在登录"];
                     [DEFAULTS setBool:YES forKey:@"isLoginToHome"];
                     [DEFAULTS setBool:YES forKey:@"isLogin"];
                     [DEFAULTS setObject:responseObject[@"datas"][@"userId"] forKey:@"userId"];
                     [self.delegate loginSuccess];
                     [self dismissViewControllerAnimated:NO completion:nil];
                     
//                     CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
//                     [self presentViewController:rootVC animated:NO completion:nil];

                 }else{
                     BindaccountViewController *BC=[[BindaccountViewController alloc]init];
                     BC.nickName=user.nickname;
                     BC.icon=user.icon;
                     BC.uid=user.uid;
                     BC.type=[NSString stringWithFormat:@"%ld",sender.tag];
                     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:BC];
                     
                     [self presentViewController:nav animated:NO completion:nil];

                 }
             } Failure:^(NSError *error) {
                  NSLog(@"%@",error);
             }];


         } else {
             NSLog(@"erro:%@",error); }
        }];
   
}
-(void)registerClick{
    RegistViewController *RC=[[RegistViewController alloc]init];
    [self presentViewController:RC animated:YES completion:nil];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;

    if (textField == self.phoneNumText) {
        if (string.length == 0)
            return YES;
              if (existedLength - selectedLength + replaceLength > 11) {
                  return NO;
              }
        
    }else{
        if (existedLength - selectedLength + replaceLength > 15) {
            return NO;
        }

    }
    return YES;
}
-(void)loginClick{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        showAlert(@"请输入手机号");
        return;
    }else if ([self.passwordText.text isEqualToString:@""]){
        showAlert(@"请输入密码");
        return;
    }
    if (![Check checkMobileNumber:self.phoneNumText.text]) {
        showAlert(@"手机号输入有误");
        return;
    }
    if (self.passwordText.text.length<6) {
        showAlert(@"密码必须不少于6位");
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [kNetManager getLogin:self.phoneNumText.text password:[self md5:self.passwordText.text] Success:^(id responseObject) {
            if ([responseObject[@"status"] integerValue]==100) {
                [DEFAULTS setBool:YES forKey:@"isLoginToHome"];
                [DEFAULTS setBool:YES forKey:@"isLogin"];
                [DEFAULTS setObject:responseObject[@"datas"][@"mobileLogin"][@"userId"] forKey:@"userId"];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
                [self.delegate loginSuccess];
                [self dismissViewControllerAnimated:NO completion:nil];
//                CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
//                [self presentViewController:rootVC animated:NO completion:nil];
               
            }else{
                [JRToast showWithText:responseObject[@"msgs"] duration:2.0f];
            }
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

-(void)backPasswordClick{
    ForgetPwdViewController *FC=[[ForgetPwdViewController alloc]init];
      UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:FC];
    
    [self presentViewController:nav animated:NO completion:nil];

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)viewWillDisappear:(BOOL)animated{
    [ZZLProgressHUD popHUD];
}
- (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
