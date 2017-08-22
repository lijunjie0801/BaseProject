//
//  SignUpViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/4.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UITextField *phonePwdTex;
@property (nonatomic,strong) UITextField *namePwdText;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"线下报名";
    [self.rdv_tabBarController setTabBarHidden:YES];
    [self setUI];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
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
-(void)goBack{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setUI{
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.text=@"姓名：";
    nameLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [nameLabel autoSetDimensionsToSize:CGSizeMake(80, 35)];
    
    /*姓名框*/
    UITextField *namePwdText = [[UITextField alloc]init];
    namePwdText.layer.cornerRadius = 6.0;
   // namePwdText.secureTextEntry = YES;
    self.namePwdText=namePwdText;
    [self.view addSubview:namePwdText];
    namePwdText.backgroundColor = [UIColor whiteColor];
    namePwdText.placeholder = @"请输入您的姓名";
    //namePwdText.leftViewMode = UITextFieldViewModeAlways;
    namePwdText.delegate = self;
    [namePwdText autoSetDimensionsToSize:CGSizeMake(0, 35)];
    [namePwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [namePwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [namePwdText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    
    UIView *confirmPwdline=[[UIView alloc]init];
    confirmPwdline.backgroundColor=[UIColor lightGrayColor];
    [namePwdText addSubview:confirmPwdline];
    [confirmPwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [confirmPwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [confirmPwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [confirmPwdline autoSetDimension:ALDimensionHeight toSize:0.5];
    
    
    
    UILabel *phoneLabel=[[UILabel alloc]init];
    phoneLabel.text=@"手机号：";
    phoneLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:phoneLabel];
    [phoneLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameLabel withOffset:20];
    [phoneLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [phoneLabel autoSetDimensionsToSize:CGSizeMake(80, 35)];
    
    /*号码框*/
    UITextField *phonePwdText = [[UITextField alloc]init];
    phonePwdText.layer.cornerRadius = 6.0;
    self.phonePwdTex=phonePwdText;
    phonePwdText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phonePwdText];
    phonePwdText.backgroundColor = [UIColor whiteColor];
    phonePwdText.placeholder = @"请输入您的手机号";
    phonePwdText.leftViewMode = UITextFieldViewModeAlways;
    phonePwdText.delegate = self;
    [phonePwdText autoSetDimensionsToSize:CGSizeMake(0, 35)];
    [phonePwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [phonePwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phonePwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameLabel withOffset:20];
    
    UIView *phoneline=[[UIView alloc]init];
    phoneline.backgroundColor=[UIColor lightGrayColor];
    [phonePwdText addSubview:phoneline];
    [phoneline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [phoneline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [phoneline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [phoneline autoSetDimension:ALDimensionHeight toSize:0.5];

    /*报名按钮*/
    UIButton *confirmBtn = [[UIButton alloc]init];
    [confirmBtn setTitle:@"确认报名" forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 6.0;
    [confirmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor colorWithHexString:@"0x59c5b7"]];
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn autoSetDimensionsToSize:CGSizeMake(0, 40)];
    [confirmBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [confirmBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [confirmBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phonePwdText withOffset:30];
    
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:line];
    [line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:confirmBtn withOffset:30];    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
    
    UILabel *bottomLabel=[[UILabel alloc]init];
    bottomLabel.text=@"留下电话后，有线下免费课程会及时与您联系";
    bottomLabel.textColor=[UIColor lightGrayColor];
    bottomLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:bottomLabel];
    [bottomLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line withOffset:20];
    [bottomLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [bottomLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [bottomLabel autoSetDimension:ALDimensionHeight toSize:30];

    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:NO];
    [super viewWillDisappear:animated];
    
}
- (void)confirmClick{
    if ([self.namePwdText.text isEqualToString:@""]) {
        showAlert(@"请输入姓名");
        return;
    }else if ([self.phonePwdTex.text isEqualToString:@""]) {
        showAlert(@"请输入手机号");
        return;
    }else if (![Check checkMobileNumber:self.phonePwdTex.text]) {
        showAlert(@"手机号输入有误");
        return;
    }
    [kNetManager offline_apply:self.phonePwdTex.text realName:self.namePwdText.text Success:^(id responseObject) {
         NSLog(@"responseObject:%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [JRToast showWithText:@"报名成功" duration:2];
            [self.navigationController popViewControllerAnimated:NO];
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
    if (textField == self.phonePwdTex) {
        if (string.length == 0)
            return YES;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }else{
        if (existedLength - selectedLength + replaceLength > 8) {
            return NO;
        }

    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
