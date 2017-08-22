//
//  ForgetPwdViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/25.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UITextField *phoneNumText;
@property (nonatomic,strong)UITextField *vertifyText;
@property (nonatomic,strong)UITextField *changePwdText;
@property (nonatomic,strong)UITextField *confirmPwdText;
@property (nonatomic,strong)NSString *sendCode;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLoginUI];
    self.navigationItem.title =@"忘记密码";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setLoginUI{
    UILabel *phoneNumLabel=[[UILabel alloc]init];
    phoneNumLabel.text=@"手机号：";
    phoneNumLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:phoneNumLabel];
    [phoneNumLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [phoneNumLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [phoneNumLabel autoSetDimensionsToSize:CGSizeMake(80, 35)];
    
    /*账号框*/
    UITextField *phoneNumText = [[UITextField alloc]init];
    _phoneNumText=phoneNumText;
    [self.view addSubview:phoneNumText];
    phoneNumText.font = [UIFont systemFontOfSize:18];
    phoneNumText.backgroundColor = [UIColor whiteColor];
    phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumText.layer.cornerRadius = 6.0;
    phoneNumText.placeholder = @"请输入手机号";
    phoneNumText.leftViewMode = UITextFieldViewModeAlways;
    phoneNumText.delegate = self;
    [phoneNumText autoSetDimensionsToSize:CGSizeMake(0, 35)];
    [phoneNumText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
    [phoneNumText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [phoneNumText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    
    UIView *phoneline=[[UIView alloc]init];
    phoneline.backgroundColor=[UIColor lightGrayColor];
    [phoneNumText addSubview:phoneline];
    [phoneline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [phoneline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [phoneline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [phoneline autoSetDimension:ALDimensionHeight toSize:0.5];
    
    UILabel *verfityLabel=[[UILabel alloc]init];
    verfityLabel.text=@"验证码：";
    verfityLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:verfityLabel];
    [verfityLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumLabel withOffset:10];
    [verfityLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [verfityLabel autoSetDimensionsToSize:CGSizeMake(80, 35)];

    /*验证码框*/
    UITextField *vertifyText = [[UITextField alloc]init];
    vertifyText.layer.cornerRadius = 6.0;
    _vertifyText=vertifyText;
    vertifyText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:vertifyText];
    vertifyText.backgroundColor = [UIColor whiteColor];
    vertifyText.placeholder = @"请输入验证码";
    vertifyText.leftViewMode = UITextFieldViewModeAlways;
    vertifyText.delegate = self;
    [vertifyText autoSetDimensionsToSize:CGSizeMake(0, 35)];
    [vertifyText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:80];
    [vertifyText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:120];
    [vertifyText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumText withOffset:10];
    
    
    UIView *vertifyline=[[UIView alloc]init];
    vertifyline.backgroundColor=[UIColor lightGrayColor];
    [vertifyText addSubview:vertifyline];
    [vertifyline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [vertifyline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [vertifyline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [vertifyline autoSetDimension:ALDimensionHeight toSize:0.5];

    
    UIButton *VerifiBtn = [[UIButton alloc]init];
   // [VerifiBtn setBackgroundColor:RGB(159, 159, 159)];
    [VerifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [VerifiBtn setTitleColor:[UIColor colorWithHexString:@"0x59c5b7"] forState:UIControlStateNormal];
    VerifiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:VerifiBtn];
    VerifiBtn.layer.cornerRadius = 6.0;
    VerifiBtn.layer.borderWidth=1.0;
    VerifiBtn.layer.borderColor=[UIColor colorWithHexString:@"0x59c5b7"].CGColor;
    [VerifiBtn addTarget:self action:@selector(getVercodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [VerifiBtn autoSetDimension:ALDimensionHeight toSize:35];
    [VerifiBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [VerifiBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:vertifyText withOffset:5];
    [VerifiBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumText withOffset:10];

    /*分割线*/
    UIView *sepView=[[UIView alloc]init];
    sepView.backgroundColor=RGB(241, 241, 241);
    [self.view addSubview:sepView];
    [sepView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:vertifyText withOffset:15];
    [sepView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [sepView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [sepView autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    UILabel *changePwdLabel=[[UILabel alloc]init];
    changePwdLabel.text=@"修改密码：";
    changePwdLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:changePwdLabel];
    [changePwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:sepView withOffset:15];
    [changePwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [changePwdLabel autoSetDimensionsToSize:CGSizeMake(80, 35)];
    
    
    UITextField *changePwdText = [[UITextField alloc]init];
    _changePwdText=changePwdText;
    changePwdText.delegate=self;
    [self.view addSubview:changePwdText];
   // changePwdText.font = [UIFont systemFontOfSize:15];
    changePwdText.backgroundColor = [UIColor whiteColor];
    changePwdText.layer.cornerRadius = 6.0;
    changePwdText.placeholder = @"请输入新密码";
    changePwdText.secureTextEntry = YES;
    changePwdText.leftViewMode = UITextFieldViewModeAlways;
    [changePwdText autoSetDimensionsToSize:CGSizeMake(0, 35)];
    [changePwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [changePwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [changePwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:sepView withOffset:15];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor lightGrayColor];
    [changePwdText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:0.5];

    
//    UIView *line=[[UIView alloc]init];
//    line.backgroundColor=[UIColor lightGrayColor];
//    [phoneNumText addSubview:line];
    
    
    UILabel *confirmPwdLabel=[[UILabel alloc]init];
    confirmPwdLabel.text=@"确认密码：";
    confirmPwdLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:confirmPwdLabel];
    [confirmPwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:changePwdLabel withOffset:10];
    [confirmPwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [confirmPwdLabel autoSetDimensionsToSize:CGSizeMake(80, 35)];
    
    /*密码框*/
    UITextField *confirmPwdText = [[UITextField alloc]init];
    _confirmPwdText=confirmPwdText;
    confirmPwdText.layer.cornerRadius = 6.0;
    confirmPwdText.secureTextEntry = YES;
    [self.view addSubview:confirmPwdText];
    confirmPwdText.backgroundColor = [UIColor whiteColor];
    confirmPwdText.placeholder = @"请再输入密码";
    confirmPwdText.leftViewMode = UITextFieldViewModeAlways;
    confirmPwdText.delegate = self;
    [confirmPwdText autoSetDimensionsToSize:CGSizeMake(0, 35)];
    [confirmPwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [confirmPwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [confirmPwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:changePwdLabel withOffset:10];
    
    UIView *confirmPwdline=[[UIView alloc]init];
    confirmPwdline.backgroundColor=[UIColor lightGrayColor];
    [confirmPwdText addSubview:confirmPwdline];
    [confirmPwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [confirmPwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [confirmPwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [confirmPwdline autoSetDimension:ALDimensionHeight toSize:0.5];

    

    
    /*登录按钮*/
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"0x59c5b7"]];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimensionsToSize:CGSizeMake(0, 40)];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:confirmPwdText withOffset:30];
   
    
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
   }
-(void)confirmClick{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        showAlert(@"请输入手机号");
        return;
    }else if ([self.vertifyText.text isEqualToString:@""]){
        showAlert(@"请输入验证码");
        return;
    }else if ([self.changePwdText.text isEqualToString:@""]||[self.confirmPwdText.text isEqualToString:@""]){
        showAlert(@"请输入密码");
        return;
    }else if (self.changePwdText.text.length<6||self.confirmPwdText.text.length<6){
        showAlert(@"密码至少需要6位");
        return;
    }else if(![self.changePwdText.text isEqualToString:self.confirmPwdText.text]){
        showAlert(@"两次密码输入不同")
        return;
    }
    
    else if (![Check checkMobileNumber:self.phoneNumText.text]) {
        showAlert(@"手机号输入有误");
        return;
    }
    if (!self.sendCode||[self.sendCode isEqualToString:@""]) {
        [JRToast showWithText:@"请获取验证码" duration:1.0];
        return;
    }

    [kNetManager changePassword:self.phoneNumText.text code:self.vertifyText.text sendCode:self.sendCode password:self.changePwdText.text Success:^(id responseObject) {
        NSLog(@"修改密码结果%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }

        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (textField == self.vertifyText) {
        if (string.length == 0)
            return YES;
        if (existedLength - selectedLength + replaceLength > 8) {
            return NO;
        }
        
    }else if (textField == self.changePwdText||textField == self.confirmPwdText){
        if (existedLength - selectedLength + replaceLength > 15) {
            return NO;
        }
    }
    else{
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
        
    }
    return YES;
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
     [self.view endEditing:YES];
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
        [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)getVercodeClick:(UIButton *)sender{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        showAlert(@"请输入手机号");
        return;
    }else if (![Check checkMobileNumber:self.phoneNumText.text]) {
        showAlert(@"手机号输入有误");
        return;
    }
    sender.userInteractionEnabled = NO;
    [[HttpManagerPort sharedHttpManagerPort]getVerficode:self.phoneNumText.text type:@"6" Success:^(id responseObject) {
        NSLog(@"获取验证码%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            self.sendCode=responseObject[@"datas"][@"sendCode"][@"sendCode"];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    sender.userInteractionEnabled=NO;
    sender.titleLabel.font=[UIFont systemFontOfSize:12];
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

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
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
