//
//  SettingViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SettingViewController.h"
#import "CYRootTabViewController.h"
#import "CustomeWebViewNoNavController.h"
@interface SettingViewController ()
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UISwitch *mySwitch;;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
    navigationBar.tintColor = [UIColor whiteColor];;
    //创建UINavigationItem
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"设置"];
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];
    //创建UIBarButton 可根据需要选择适合自己的样式
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
    navigationBarTitle.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];

    [self setUI];
}
-(void)setUI{
   // self.view.backgroundColor=[UIColor whiteColor];
    UILabel *wifiLab=[[UILabel alloc]init];
    wifiLab.text=@"仅WIFI环境下看视频";
    wifiLab.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:wifiLab];
    [wifiLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:94];
    [wifiLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [wifiLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [wifiLab autoSetDimension:ALDimensionHeight toSize:30];
    
    _mySwitch = [[UISwitch alloc]init];
    if([DEFAULTS boolForKey:@"isWifiShow"]==YES){
        _mySwitch.on=YES;
          [_mySwitch setThumbTintColor:[UIColor colorWithHexString:@"0x59c5b7"]];
    }else{
        _mySwitch.on=NO;
    }
    //[_mySwitch setOn:YES animated:YES];
    [self.view addSubview:_mySwitch];
    [_mySwitch autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:18];
    [_mySwitch autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:94];
    [_mySwitch autoSetDimensionsToSize:CGSizeMake(50, 30)];
    //设置开启状态的风格颜色
    [_mySwitch setOnTintColor:RGB(241, 241, 241)];
    
    //设置开关圆按钮的风格颜色
  
    _mySwitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [_mySwitch setTintColor:RGB(241, 241, 241)];
    [_mySwitch addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
    
    for (int i=0; i<4; i++) {
        UIView *sepView=[[UIView alloc]init];
        sepView.backgroundColor=RGB(241, 241, 241);
        [self.view addSubview:sepView];
        [sepView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50*i+94+40];
        [sepView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [sepView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [sepView autoSetDimension:ALDimensionHeight toSize:1];
    }
    NSArray *titilearray=@[@"修改密码",@"收货地址",@"关于我们"];
//    CGSize titleSize = [ titilearray[0] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    for (int i=0; i<3; i++) {
        UIButton *titleLab=[[UIButton alloc]init];
        [titleLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleLab.tag=i;
        [titleLab addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleLab setTitle:titilearray[i] forState:UIControlStateNormal];
        titleLab.titleLabel.font=[UIFont systemFontOfSize:17];
        titleLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:titleLab];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50*(i+1)+94];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [titleLab autoSetDimension:ALDimensionHeight toSize:30];

    }
    UIButton *logoutBtn = [[UIButton alloc]init];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutBtn.layer.cornerRadius = 6.0;
    [logoutBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:[UIColor colorWithHexString:@"0x59c5b7"]];
    [self.view addSubview:logoutBtn];
    [logoutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn autoSetDimension:ALDimensionHeight toSize:40];
    [logoutBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [logoutBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [logoutBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:400];

}
-(void)loginOut{
    NSLog(@"%@",[DEFAULTS objectForKey:@"LoginType"]);
    if ([[DEFAULTS objectForKey:@"LoginType"]integerValue]==0) {
         [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    }else{
        [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    }
   
    [DEFAULTS removeObjectForKey:@"isLogin"];
    [DEFAULTS removeObjectForKey:@"userId"];
    [DEFAULTS removeObjectForKey:@"LoginType"];
    [DEFAULTS setBool:YES forKey:@"isLoginToHome"];
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];
}
- (void) swChange:(UISwitch*) sw{
    
    if(sw.on==YES){
        NSLog(@"开关被打开");
        [_mySwitch setThumbTintColor:[UIColor colorWithHexString:@"0x59c5b7"]];
        [DEFAULTS setBool:YES forKey:@"isWifiShow"];
    }else{
           NSLog(@"开关被关闭");
        [DEFAULTS setBool:NO forKey:@"isWifiShow"];
        [_mySwitch setThumbTintColor:RGB(241, 241, 241)];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_backBtn addTarget:self action:@selector(webGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)webGoBack{
        [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)cellClick:(UIButton *)sender{
    CustomeWebViewNoNavController *CV=[[CustomeWebViewNoNavController alloc]init];
    if (sender.tag==0) {
        CV.webUrl=[NSString stringWithFormat:@"%@/api.php/user/editPwd?userId=%@",kBaseUrl,[DEFAULTS objectForKey:@"userId"]];
    }else if (sender.tag==1){
        CV.webUrl=[NSString stringWithFormat:@"%@/api.php/User/address?userId=%@",kBaseUrl,[DEFAULTS objectForKey:@"userId"]];
    }else if (sender.tag==2){
        CV.webUrl=[NSString stringWithFormat:@"%@/api.php/user/aboutUs",kBaseUrl];
    }
    
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:CV];
    
    [self presentViewController:nav_third animated:NO completion:nil ];

}

@end
