//
//  CustomWebViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/10.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "CustomWebViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "AppDelegate.h"
@interface CustomWebViewController ()<UIWebViewDelegate,WebViewJSDelegate,UIAlertViewDelegate,AppdelDelegate>
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UIButton * gobackBtn;
@property (nonatomic,strong) UIWebView *webview;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@end

@implementation CustomWebViewController

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
  //  self.navigationController.barHideOnSwipeGestureRecognizer=NO;
    [self.navigationController.view addSubview:webview];

}
-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"111");
    [self.webview removeFromSuperview];
}
-(void)viewWillDisappear:(BOOL)animated{
    [ZZLProgressHUD popHUD];
    [self.rdv_tabBarController setTabBarHidden:NO];
    self.backBtn.hidden=YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES];

}

#pragma mark  ----WebviewDelegate-----
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void)goBackOfAppJS{
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }else{
        [self.webview removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [ZZLProgressHUD popHUD];
    NSString *titles=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title =titles ;

    if ([titles isEqualToString:@"商品详情"]) {
        self.webview.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    }else{
        self.navigationController.navigationBar.hidden =NO;
        self.webview.frame=CGRectMake(0, 64, kScreen_Width, kScreen_Height-64);
    }
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;

    
}
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.delegate respondsToSelector:@selector(payFinish)]) {
        [self.delegate payFinish];
    }
    [self.webview removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
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
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
        [_backBtn addTarget:self action:@selector(webGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (UIButton *)gobackBtn
{
    if (!_gobackBtn) {
        _gobackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
        [_gobackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_gobackBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        _gobackBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _gobackBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
        [_gobackBtn addTarget:self action:@selector(webGoBack) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _gobackBtn;
}
-(void)webGoBack{
    if ([self.title isEqualToString:@"选择地址"]) {
        JSContext *context=[self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext" ];
        context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
            NSLog(@"exception++exception：%@", exception);
            con.exception = exception;
        };
        NSString *alertJS=@"closeAddress()";
        [context evaluateScript:alertJS];
        return;
    }
    if ([self.webview canGoBack]) {
        
        [self.webview goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)toAppClassJS:(NSString *)classId{
    NSLog(@"%@",classId);
    MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
    vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,classId,[DEFAULTS objectForKey:@"userId"]];

    vc.classId=classId;
    [self.navigationController pushViewController:vc animated:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        if ([self.delegate respondsToSelector:@selector(payFinish)]) {
            [self.delegate payFinish];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)toLoginJS{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        [self presentViewController:login animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    

}
-(void)checkJS:(NSString *)result{
    [JRToast showWithText:result];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(void)TodeilJS:(NSString *)content{
//    NSLog(@"%@",content);
//}
-(void)getTitleJS:(NSString *)content{
    self.title=content;
}
@end

