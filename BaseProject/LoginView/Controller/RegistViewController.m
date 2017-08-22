//
//  RegistViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "RegistViewController.h"
#import "CYRootTabViewController.h"
@interface RegistViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *filter;
@property(nonatomic,strong)UILabel *loginTitle;
@property(nonatomic,strong)UITextField *phoneNumText;
@property(nonatomic,strong)UITextField *setPwdText;
@property(nonatomic,strong)UITextField *vertifiText;
@property(nonatomic,strong)NSString *mdString;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGifView];
    
}
-(void)setGifView{
//    //得到图片的路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"loginWB" ofType:@"gif"];
//    //将图片转为NSData
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    //创建一个webView，添加到界面
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
//    [self.view addSubview:webView];
//    //自动调整尺寸
//    webView.scalesPageToFit = YES;
//    //禁止滚动
//    webView.scrollView.scrollEnabled = NO;
//    //设置透明效果
//    webView.backgroundColor = [UIColor clearColor];
//    webView.opaque = 0;
//    //加载数据
//    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    
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
        
    }else if(textField == self.vertifiText){
        if (existedLength - selectedLength + replaceLength > 8) {
            return NO;
        }
    }else{
        if (existedLength - selectedLength + replaceLength > 15) {
            return NO;
    }
        
    }
    return YES;
}
-(void)setLoginUI{
    
    /*账号框*/
    UITextField *phoneNumText = [[UITextField alloc]init];
    [self.filter addSubview:phoneNumText];
    phoneNumText.backgroundColor = [UIColor whiteColor];
    phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumText.layer.cornerRadius = 6.0;
    self.phoneNumText = phoneNumText;
    
    phoneNumText.placeholder = @"输入手机号";
    UIView *phoneLeftView = [[UIView alloc]init];
    [phoneLeftView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    UIImageView *phoneImage = [[UIImageView alloc]init];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(20, 20)];
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
    
    
    /*验证码框*/
    UITextField *vertifiText = [[UITextField alloc]init];
    vertifiText.layer.cornerRadius = 6.0;
    vertifiText.keyboardType = UIKeyboardTypeNumberPad;
    [self.filter addSubview:vertifiText];
    vertifiText.backgroundColor = [UIColor whiteColor];
    vertifiText.placeholder = @"输入验证码";
     self.vertifiText = vertifiText;
    UIView *passLeftView = [[UIView alloc]init];
    [passLeftView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    UIImageView *passImage = [[UIImageView alloc]init];
    [passImage autoSetDimensionsToSize:CGSizeMake(20, 20)];
    passImage.image = [UIImage imageNamed:@"yanzhengma"];
    [passLeftView addSubview:passImage];
    [passImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [passImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    vertifiText.leftView = passLeftView;
    vertifiText.leftViewMode = UITextFieldViewModeAlways;
    vertifiText.delegate = self;
    [vertifiText autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-30)/8];
    [vertifiText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [vertifiText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:145];

    [vertifiText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumText withOffset:20];
    //获取验证码
    UIButton *VerifiBtn = [[UIButton alloc]init];
    [VerifiBtn setBackgroundColor:RGB(159, 159, 159)];
    [VerifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [VerifiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    VerifiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.filter addSubview:VerifiBtn];
    VerifiBtn.layer.cornerRadius = 6.0;
    [VerifiBtn addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    [VerifiBtn autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-30)/8];
    [VerifiBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [VerifiBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:vertifiText withOffset:5];
    [VerifiBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumText withOffset:20];
    
    /*设置密码*/
    UITextField *setPwdText = [[UITextField alloc]init];
    [self.filter addSubview:setPwdText];
    setPwdText.backgroundColor = [UIColor whiteColor];
    _setPwdText=setPwdText;
    setPwdText.layer.cornerRadius = 6.0;
    setPwdText.secureTextEntry=YES;
    setPwdText.placeholder = @"设置登录密码";
    UIView *setpwdLeftView = [[UIView alloc]init];
    [setpwdLeftView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    UIImageView *setpwdImage = [[UIImageView alloc]init];
    [setpwdImage autoSetDimensionsToSize:CGSizeMake(20, 20)];
    [setpwdLeftView addSubview:setpwdImage];
    setpwdImage.image = [UIImage imageNamed:@"password"];
    [setpwdImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [setpwdImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    setPwdText.leftView = setpwdLeftView;
    setPwdText.leftViewMode = UITextFieldViewModeAlways;
    setPwdText.delegate = self;
    [setPwdText autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-30)/8];
    [setPwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [setPwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [setPwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:VerifiBtn withOffset:25];
//
    /*注册按钮*/
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"确认注册" forState:UIControlStateNormal];
    registerBtn.layer.cornerRadius = 6.0;
    [registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:[UIColor colorWithHexString:@"0x59c5b7"]];
    [self.filter addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-30)/8];
    [registerBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [registerBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [registerBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:setPwdText withOffset:30];
    /*注册*/
    UIButton *LoginBtn = [[UIButton alloc]init];
    [LoginBtn setTitle:@"已有账号,直接登录" forState:UIControlStateNormal];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    LoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.filter addSubview:LoginBtn];
    [LoginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [LoginBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width, 25)];
    [LoginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:registerBtn withOffset:20];
   
       /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.filter addGestureRecognizer:tapGestureRecognizer];
    
    
}
-(void)registClick{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        showAlert(@"请输入手机号");
        return;
    }else if ([self.vertifiText.text isEqualToString:@""]){
        showAlert(@"请输入验证码");
        return;
    }else if ([self.setPwdText.text isEqualToString:@""]){
        showAlert(@"请输入密码");
        return;
    }else if (self.setPwdText.text.length<6){
        showAlert(@"密码至少需要6位");
    }
    if (![Check checkMobileNumber:self.phoneNumText.text]) {
        showAlert(@"手机号输入有误");
        return;
    }
    if (!self.mdString||[self.mdString isEqualToString:@""]) {
        [JRToast showWithText:@"请获取验证码" duration:1.0];
        return;
    }
    [ZZLProgressHUD showHUDWithMessage:@"正在注册"];
    [[HttpManagerPort sharedHttpManagerPort] getRegistcode:self.phoneNumText.text password:[self md5:self.setPwdText.text] code:self.vertifiText.text sendCode:self.mdString Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            [DEFAULTS setBool:YES forKey:@"isLoginToHome"];
            [DEFAULTS setBool:YES forKey:@"isLogin"];
            [DEFAULTS setObject:responseObject[@"datas"][@"mobileRegister"][@"userId"] forKey:@"userId"];
            [ZZLProgressHUD popHUD];
            CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
            [self presentViewController:rootVC animated:NO completion:nil];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2.0f];
        }
        [SVProgressHUD dismiss];
    } Failure:^(NSError *error) {
        
    }];
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
-(void)sendClick:(UIButton *)sender{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        showAlert(@"请输入手机号");
        return;
    }else if (![Check checkMobileNumber:self.phoneNumText.text]) {
        showAlert(@"手机号输入有误");
        return;
    }
    sender.userInteractionEnabled=NO;
    [[HttpManagerPort sharedHttpManagerPort]getVerficode:self.phoneNumText.text type:@"1" Success:^(id responseObject) {
         NSLog(@"获取的验证码%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            self.mdString=[responseObject objectForKey:@"datas"][@"sendCode"][@"sendCode"];

        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2];
        }
        
    } Failure:^(NSError *error) {
         NSLog(@"失败了");
    }];
  
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            //int seconds = timeout % 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
              //  sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(void)loginClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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


@end
