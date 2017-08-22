//
//  MoviewToWebViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/18.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MoviewToWebViewController.h"

@interface MoviewToWebViewController ()<UIWebViewDelegate,WebViewJSDelegate,UIAlertViewDelegate,AppdelDelegate>
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) UINavigationItem * navigationBarTitle;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@end

@implementation MoviewToWebViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
            navigationBar.tintColor = [UIColor whiteColor];;
            //创建UINavigationItem
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@""];
    _navigationBarTitle=navigationBarTitle;
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];
            //创建UIBarButton 可根据需要选择适合自己的样式
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, kScreen_Width-100, 64)];
    self.titleLab=titleLab;
    titleLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
    
    [self.view addSubview:_backBtn];

    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,64, kScreen_Width, kScreen_Height-64)];
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
    [self.view addSubview:webview];
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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"支付结果" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];    }];
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
    self.titleLab.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;
    
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 12, 30, 40)];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_backBtn addTarget:self action:@selector(webGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
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
            [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)webGoBack{
    if ([ self.titleLab.text isEqualToString:@"选择地址"]) {
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

   // [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)checkJS:(NSString *)result{
    [JRToast showWithText:result];
}
-(void)getTitleJS:(NSString *)content{
    self.titleLab.text=content;
}

@end
