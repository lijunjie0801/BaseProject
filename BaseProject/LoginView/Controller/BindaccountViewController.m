//
//  BindaccountViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "BindaccountViewController.h"
#import "CYRootTabViewController.h"
@interface BindaccountViewController ()
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UITextField *phoneNumText;
@property (nonatomic,strong) UITextField *passwordText;
@property (nonatomic,strong)NSString *sendCode;
@end

@implementation BindaccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"绑定账号";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    [self setUI];

}
-(void)setUI{
    UILabel *dearLab=[[UILabel alloc]init];
    dearLab.text=[NSString stringWithFormat:@"亲爱的用户:%@",self.nickName];
    dearLab.font=[UIFont systemFontOfSize:16];
    CGSize titleSize = [ dearLab.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    [self.view addSubview:dearLab];
    [dearLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [dearLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [dearLab autoSetDimensionsToSize:CGSizeMake(titleSize.width, 20)];
    
    UILabel *infoLab=[[UILabel alloc]init];
    infoLab.text=@"为了给您更好的服务，请绑定一个手机号";
    infoLab.font=[UIFont systemFontOfSize:16];
    CGSize infotitleSize = [infoLab.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    [self.view addSubview:infoLab];
    [infoLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [infoLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:dearLab withOffset:10];
    [infoLab autoSetDimensionsToSize:CGSizeMake(infotitleSize.width, 20)];
    
    UIView *sepLine=[[UIView alloc]init];
    sepLine.backgroundColor=RGB(241, 241, 241);
    [self.view addSubview:sepLine];
    [sepLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:infoLab withOffset:10];
    [sepLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [sepLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [sepLine autoSetDimension:ALDimensionHeight toSize:1];

    UILabel *quickLab=[[UILabel alloc]init];
    quickLab.text=@"快速绑定";
    quickLab.font=[UIFont systemFontOfSize:16];
    CGSize quicktitleSize = [quickLab.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    [self.view addSubview:quickLab];
    [quickLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [quickLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:sepLine withOffset:10];
    [quickLab autoSetDimensionsToSize:CGSizeMake(quicktitleSize.width, 20)];
    
    /*账号框*/
    UITextField *phoneNumText = [[UITextField alloc]init];
    self.phoneNumText=phoneNumText;
    [self.view addSubview:phoneNumText];
    phoneNumText.backgroundColor = [UIColor whiteColor];
    phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumText.layer.cornerRadius = 6.0;
    phoneNumText.layer.borderWidth=1;
    phoneNumText.layer.borderColor=RGB(241, 241, 241).CGColor;
    phoneNumText.placeholder = @"  输入手机号";
    phoneNumText.delegate = self;
    [phoneNumText autoSetDimensionsToSize:CGSizeMake(0, 50)];
    [phoneNumText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [phoneNumText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [phoneNumText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:quickLab withOffset:10];
    
    
    /*密码框*/
    UITextField *passwordText = [[UITextField alloc]init];
    passwordText.layer.cornerRadius = 6.0;
    passwordText.placeholder = @"  输入验证码";
    self.passwordText=passwordText;
    passwordText.layer.borderWidth=1;
    passwordText.layer.borderColor=RGB(241, 241, 241).CGColor;
    [self.view addSubview:passwordText];
    passwordText.delegate = self;
    [passwordText autoSetDimensionsToSize:CGSizeMake(0, 50)];
    [passwordText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [passwordText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:155];
    [passwordText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumText withOffset:20];
    //获取验证码
    UIButton *VerifiBtn = [[UIButton alloc]init];
    [VerifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [VerifiBtn setTitleColor:[UIColor colorWithHexString:@"0x59c5b7"] forState:UIControlStateNormal];
    VerifiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    VerifiBtn.layer.cornerRadius = 6.0;
    VerifiBtn.layer.borderWidth=1.0;
    VerifiBtn.layer.borderColor=[UIColor colorWithHexString:@"0x59c5b7"].CGColor;
    [VerifiBtn addTarget:self action:@selector(getVercodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VerifiBtn];
    [VerifiBtn autoSetDimension:ALDimensionHeight toSize:50];
    [VerifiBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [VerifiBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:passwordText withOffset:5];
    [VerifiBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumText withOffset:20];
    
    UIButton *bindBtn = [[UIButton alloc]init];
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    bindBtn.layer.cornerRadius = 6.0;
    [bindBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bindBtn setBackgroundColor:RGB(109, 168, 156)];
    [self.view addSubview:bindBtn];
    [bindBtn addTarget:self action:@selector(bandClick) forControlEvents:UIControlEventTouchUpInside];
    [bindBtn autoSetDimensionsToSize:CGSizeMake(0, 50)];
    [bindBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [bindBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [bindBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:VerifiBtn withOffset:30];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];


}
-(void)bandClick{
    if (self.phoneNumText.text.length==0) {
        [JRToast showWithText:@"手机号不能为空" duration:1.0];
        return;
    }else if(self.passwordText.text.length==0){
        [JRToast showWithText:@"验证码不能为空" duration:1.0];
        return;
    }else if (!self.sendCode||[self.sendCode isEqualToString:@""]){
        [JRToast showWithText:@"请获取验证码" duration:1.0];
        return;
    }
    [kNetManager authorizationRigst:self.uid type:self.type mobile:self.phoneNumText.text code:self.passwordText.text sendCode:self.sendCode nickName:self.nickName userImg:self.icon Success:^(id responseObject) {
        NSLog(@"授权注册%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [DEFAULTS setBool:YES forKey:@"isLoginToHome"];
            [DEFAULTS setBool:YES forKey:@"isLogin"];
            [DEFAULTS setObject:responseObject[@"datas"][@"userId"] forKey:@"userId"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
//            [self dismissViewControllerAnimated:NO completion:nil];
            CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
            [self presentViewController:rootVC animated:NO completion:nil];

        }else{
             [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {
         NSLog(@"授权注册%@",error);
    }];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
}

-(void)getVercodeClick:(UIButton *)sender{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        showAlert(@"请输入手机号");
        return;
    }else if (![Check checkMobileNumber:self.phoneNumText.text]) {
        showAlert(@"手机号输入有误");
        return;
    }
    sender.userInteractionEnabled=NO;
    [[HttpManagerPort sharedHttpManagerPort]getVerficode:self.phoneNumText.text type:@"1" Success:^(id responseObject) {
        NSLog(@"获取验证码%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            self.sendCode=responseObject[@"datas"][@"sendCode"][@"sendCode"];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2.0];
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
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
    [self dismissViewControllerAnimated:NO completion:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
