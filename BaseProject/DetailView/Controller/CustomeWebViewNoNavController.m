//
//  CustomeWebViewNoNavController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/11.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "CustomeWebViewNoNavController.h"
#import "MoviePlayerViewController.h"
#import "CustomWebViewController.h"
@interface CustomeWebViewNoNavController ()<UIWebViewDelegate,WebViewJSDelegate,UIAlertViewDelegate,AppdelDelegate>
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) UINavigationItem * navigationBarTitle;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic, strong) NSString *location;
@end

@implementation CustomeWebViewNoNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rdv_tabBarController setTabBarHidden:YES];
    [ZZLProgressHUD showHUDWithMessage:@"正在加载"];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height)];
    _webview=webview;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    webview.scalesPageToFit = YES;
    webview.backgroundColor = [UIColor whiteColor];
    NSURL *url=[NSURL URLWithString:self.webUrl];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    webview.allowsInlineMediaPlayback = YES;
    webview.mediaPlaybackRequiresUserAction = NO;
    webview.delegate=self;
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appdelegate.delegate=self;
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];

    [self.view addSubview:webview];
}
-(void)goBackOfAppJS{
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }else{
        [self.webview removeFromSuperview];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [ZZLProgressHUD popHUD];
    [self.rdv_tabBarController setTabBarHidden:NO];
}

#pragma mark  ----WebviewDelegate-----
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [ZZLProgressHUD popHUD];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [ZZLProgressHUD popHUD];
    NSString *titles=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title =titles ;
    
    if ([titles isEqualToString:@"商品详情"]) {
        self.navigationController.navigationBar.hidden =YES;
        self.webview.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    }else{
        self.navigationController.navigationBar.hidden =NO;
      //  self.webview.frame=CGRectMake(0, 64, kScreen_Width, kScreen_Height-64);
    }
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;
   NSString *location= webView.request.URL.absoluteString;
    _location=location;
    
}
-(void)toAppPlayerJS:(NSString *)classId{
    NSLog(@"%@",classId);
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
    }else{
        MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
        vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,classId,[DEFAULTS objectForKey:@"userId"]];
        vc.classId=classId;
        [self.navigationController pushViewController:vc animated:NO];}}

-(void)checkJS:(NSString *)result{
    NSLog(@"%@",result);
   // [JRToast showWithText:result duration:2.0];
    [JRToast showWithText:result topOffset:150 duration:1.0];
    if ([result isEqualToString:@"密码修改成功"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
-(void)huidiao:(NSString *)index{
    NSLog(@"%@",index);
    NSString *msg;
    if ([index intValue]==0) {
        msg=@"恭喜您，支付成功";
        NSLog(@"成功");
    }else if ([index intValue]==-2){
        NSLog(@"取消");
        msg=@"已取消支付";
        
    }else{
        msg=@"支付失败";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"支付结果" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.webview reload];
        [self.webview goBack];
      //  [self dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    if ([self.webview canGoBack]) {
        if ([self.title isEqualToString:@"收货地址"]||[self.title isEqualToString:@"收到的评论"]||[self.title isEqualToString:@"学生的评论"]) {
             [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [self.webview goBack];
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)toAppAlipayJS:(NSString *)response{
    NSLog(@"%@",response);
    //   Order *order = [[Order alloc] init];
    [[AlipaySDK defaultService] payOrder:response fromScheme:@"alisdk" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslutlijunjie = %@",resultDic);
        
        NSString * strTitle = [NSString stringWithFormat:@"支付结果"];
        NSString *strMsg;
        
        //【callback处理支付结果】
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            
            strMsg = @"恭喜您，支付成功!";
            
        }else if([resultDic[@"resultStatus"] isEqualToString:@"6001"])
        {
            strMsg = @"已取消支付!";
            
        }else{
            strMsg = @"支付失败!";
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.delegate=self;
        
        [alert show];
    }];
}
-(void)toAppWeiPayJS:(NSString *)response{
    NSLog(@"%@",response);
    NSDictionary *dic=[self dictionaryWithJsonString:response];
    NSLog(@"dic=====%@",dic);
    PayReq *request = [[PayReq alloc] init];
    request.openID=dic[@"appid"];
    request.partnerId = dic[@"partnerid"];
    request.prepayId= dic[@"prepayid"];
    request.package = dic[@"package"];
    request.nonceStr= dic[@"noncestr"];
    request.timeStamp =[dic[@"timestamp"] intValue];
    request.sign=dic[@"sign"];
    BOOL bs = [WXApi isWXAppSupportApi];
    if (bs) {
        BOOL isok = [WXApi sendReq:request];
        if (isok) {
            NSLog(@"调用微信支付成功");
        }else{
            NSLog(@"调用微信支付失败");
        }
    }
    else{
        NSLog(@"微信版本过低，不支持支付");
    }
    
    
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(void)commentClassFromOrderJS:(NSString *)content{
    [self.delegate tocommentWeb];
    NSLog(@"%@",content);
    MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
    vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@&commentIndex=2",kBaseUrl,content,[DEFAULTS objectForKey:@"userId"]];

    vc.classId=content;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)alertLogin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        CATransition * animation = [CATransition animation];
        animation.duration = 0.5;    //  时间
        animation.type = @"pageCurl";
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self presentViewController:login animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.webview reload];
    [self.webview goBack];
   
    
}
-(void)toAppStoreJS:(NSString *)goodsId{
    CustomWebViewController *CV=[[CustomWebViewController alloc]init];
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
    CV.webUrl=[NSString stringWithFormat:@"%@/api.php/Shop/shopDetail?goodsId=%@&userId=%@",kBaseUrl,goodsId,user_id];
    [self.navigationController pushViewController:CV animated:NO];

}

@end
