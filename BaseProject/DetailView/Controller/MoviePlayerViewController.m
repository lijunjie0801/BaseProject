

#import "MoviePlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZFPlayer.h"
#import "UINavigationController+ZFFullscreenPopGesture.h"
#import "WebViewJS.h"
#import "YcKeyBoardView.h"
#import "AppDelegate.h"
@interface MoviePlayerViewController () <ZFPlayerDelegate,UIScrollViewDelegate,UIWebViewDelegate,WebViewJSDelegate,UIGestureRecognizerDelegate,YcKeyBoardViewDelegate,CustomeWebViewNoNavDelegate,AppdelDelegate>{
    NSInteger netStatus;
}
@property (nonatomic,strong)YcKeyBoardView *key;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@property (nonatomic,strong) NSString *commentType;
@property (nonatomic,strong)NSString *commentId;
@property (nonatomic,strong)NSString *replyId;
/** 播放器View的父视图*/
@property (strong, nonatomic)  UIView *playerFatherView;
@property (strong, nonatomic) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property(nonatomic,strong) UIWebView *webview;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) UIView *bottomView;
//@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic,strong)UIButton *bigBackBtn;
@property(nonatomic, strong)NSMutableArray *videoListArray;
@property(nonatomic, strong)AFNetworkReachabilityManager *manager;
@end

@implementation MoviePlayerViewController

- (void)dealloc {
    [self.manager stopMonitoring];
    NSLog(@"%@释放了",self.class);
    [self.playerView resetPlayer];
}
#pragma mark - Getter

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = self.shareTitle;
        _playerModel.videoURL         = self.videoURL;
        _playerModel.placeholderImageURLString = self.shareImgUrl;
        _playerModel.fatherView       = self.playerFatherView;
        _playerModel.isSave=self.isSave;
    }
    return _playerModel;
}
-(void)zf_playerHengping{
    [self.view endEditing:YES];
}
- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        [_playerView playerControlView:nil playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        self.playerView.playerPushedOrPresented = NO;
    }
   [self.rdv_tabBarController setTabBarHidden:YES];
   
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
  //  [_playerView resetPlayer];
//    _playerView 
   //self.rdv_tabBarController.interactivePopGestureRecognizer.enabled = YES;

    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        self.playerView.playerPushedOrPresented = YES;
    }
      [self.rdv_tabBarController setTabBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];
    self.zf_prefersNavigationBarHidden = YES;
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;
    [self.rdv_tabBarController setTabBarHidden:YES];
    self.playerFatherView = [[UIView alloc] init];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.trailing.mas_equalTo(0);
        // 这里宽高比16：9,可自定义宽高比
        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];

    [self setWebview];
    // 自动播放，默认不自动播放
    //[self.playerView autoPlayTheVideo];

    
    //禁止滑动返回
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
  //  [self setBottomView];
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    cv.delegate=self;
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appdelegate.delegate=self;
}


-(void)getdata{
    [_playerView autoPlayTheVideo];
    [kNetManager getClass_infoData:self.classId userId:[DEFAULTS objectForKey:@"userId"]Success:^(id responseObject) {
        NSLog(@"videoinfo%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            NSLog(@"classinfo:%@",responseObject);
            _playerModel.videoURL=[NSURL URLWithString:responseObject[@"datas"][@"class_info"][@"classUrl"]];
            _playerModel.placeholderImageURLString= responseObject[@"datas"][@"class_info"][@"classXImg"];
            _playerModel.title=responseObject[@"datas"][@"class_info"][@"classTitle"];
            self.shareImgUrl=responseObject[@"datas"][@"class_info"][@"classImg"];
            self.shareTitle=responseObject[@"datas"][@"class_info"][@"classTitle"];
            self.shareContent=responseObject[@"datas"][@"class_info"][@"classDescription"];
            self.shareUrl=responseObject[@"datas"][@"class_info"][@"classinfo_url"];
    
            _listArray= responseObject[@"datas"][@"class_info"][@"videoList"];
            _playerModel.isSave=responseObject[@"datas"][@"class_info"][@"isSave"];
            [_playerView playerControlView:nil playerModel:self.playerModel];
           //[self checkNet];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2];
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}
-(void)setWebview{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,kScreen_Width*9/16, kScreen_Width, kScreen_Height-kScreen_Width*9/16)];
    _webview=webview;
    [ZZLProgressHUD showHUDWithMessage:@"正在加载"];

    webview.delegate=self;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    webview.scalesPageToFit = YES;
    webview.backgroundColor = [UIColor whiteColor];
//    NSString *urlstr=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
    NSURL* url = [NSURL URLWithString:self.webUrl];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    webview.allowsInlineMediaPlayback = YES;
    webview.mediaPlaybackRequiresUserAction = NO;
    // [[[UIApplication sharedApplication ] keyWindow ] addSubview : webview];
    [self.view addSubview:webview];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [ZZLProgressHUD popHUD];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;
    
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
      return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return ZFPlayerShared.isStatusBarHidden;
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction {
   
   [_playerView resetPlayer];
    self.isPlaying = NO;
    self.playerView.playerPushedOrPresented = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    
//    [self.key removeFromSuperview];
//     [self.view endEditing:YES];
}

- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {

}


- (void)zf_playerDownload:(NSString *)url {
    NSLog(@"分享");
    
    UIButton *bigBackBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+64+20)];
    bigBackBtn.backgroundColor=RGBA(42, 42, 42, 0.7);
    self.bigBackBtn=bigBackBtn;
    [[[UIApplication sharedApplication ] keyWindow ] addSubview : bigBackBtn];
    
    [bigBackBtn addTarget:self action:@selector(clickEmpt) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.userInteractionEnabled=YES;
    bgView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [bigBackBtn addSubview:bgView];
    bgView.frame=CGRectMake(0, kScreen_Height-200, kScreen_Width, 200);
    
    
    for (int i=0; i<3; i++) {
        UILabel *PromptLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        PromptLabel.text=@"选择要分享到的平台";
        PromptLabel.textAlignment=UITextAlignmentCenter;
        [bgView addSubview:PromptLabel];
        UIButton *shareBtn=[[UIButton alloc]init];
        NSArray *imageArray=@[@"wechatIcon",@"pengyouquan",@"qqIcon"];
        NSArray *titleArray=@[@"微信好友",@"朋友圈",@"手机QQ"];
        shareBtn.tag=i;
        [shareBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareCliCk:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:shareBtn];
        shareBtn.frame=CGRectMake((kScreen_Width-240)/4*(i+1)+80*i, 50, 80, 80);
        
        
        
        UILabel *shareLabel=[[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-240)/4*(i+1)+80*i, 130, 80, 20)];
        shareLabel.font=[UIFont systemFontOfSize:15];
        shareLabel.text=titleArray[i];
        shareLabel.textAlignment=UITextAlignmentCenter;
        [bgView addSubview:shareLabel];
        
        
        
    }
    
}
-(void)shareCliCk:(UIButton *)sender{
    [self.bigBackBtn removeFromSuperview];
    SSDKPlatformType sharetype=SSDKPlatformTypeUnknown;
    if (sender.tag==0) {
        sharetype=SSDKPlatformSubTypeWechatSession;
    }else if(sender.tag==1){
        sharetype=SSDKPlatformSubTypeWechatTimeline;
    }else{
        sharetype=SSDKPlatformSubTypeQQFriend;
    }
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImgUrl]]];
//    UIImage *image=[UIImage imageNamed:@"buyed"];
    UIImage *newImage=[self thumbnailWithImageWithoutScale:image size:CGSizeMake(200, 200)];
    NSArray *imgArr=@[newImage];
    NSURL *shareUrl=[NSURL URLWithString:self.shareUrl];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.shareContent
                                     images:imgArr
                                        url:shareUrl
                                      title:self.shareTitle
                                       type:SSDKContentTypeAuto];
    [ShareSDK share:sharetype
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
     {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 NSLog(@"分享成功");
                 break;
             }
             case SSDKResponseStateFail:
             {
                 NSLog(@"分享失败");
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 NSLog(@"分享取消");
                 break;
             }
             default:
                 break;
         }}];
}

-(void)clickEmpt
{
    [self.bigBackBtn removeFromSuperview];
}
-(void)zf_playerShare{
    [kNetManager class_collect_act:[DEFAULTS objectForKey:@"userId"] classId:self.classId Success:^(id responseObject) {
          NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {
        NSLog(@"错误信息%@",error);
    }];
    
}
-(void)sendVideoIndex:(NSString *)index{
     NSDictionary *videodic=_listArray[[index integerValue]];
    if ([index integerValue]==0) {
        _playerModel.videoURL  =[NSURL URLWithString:videodic[@"VideoUrl"]];
        _playerModel.title=videodic[@"VideoTitle"];
        self.isPlaying = YES;
        self.playerView.playerPushedOrPresented = YES;
        [self.playerView resetToPlayNewVideo:self.playerModel];

    }else{
        [kNetManager class_Permission:[DEFAULTS objectForKey:@"userId"] classId:self.classId Success:^(id responseObject) {
            NSLog(@"权限%@",responseObject);
            
            if ([responseObject[@"status"] intValue]==100) {
                if ([responseObject[@"datas"][@"class_Permission"] integerValue]==1) {
                   
                    _playerModel.videoURL  =[NSURL URLWithString:videodic[@"VideoUrl"]];
                    _playerModel.title=videodic[@"VideoTitle"];
                    self.isPlaying = YES;
                    self.playerView.playerPushedOrPresented = YES;
                    [self.playerView resetToPlayNewVideo:self.playerModel];
                }else{
                    [self toBuyAlert];
                }
            }
        } Failure:^(NSError *error) {
            
        }];
        

    }
    
}
-(void)toBuyAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你尚未购买该课程，是否购买" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MoviewToWebViewController *CV=[[MoviewToWebViewController alloc]init];
        NSString *urlstring=[NSString stringWithFormat:@"%@/api.php/Shop/submitOrder?classId=%@&userId=%@&newOrder=1&more=0&orderType=2",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
        CV.webUrl=[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.navigationController pushViewController:CV animated:NO];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}
-(void)checkNet{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    self.manager=manager;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            NSLog(@"未识别的网络");
           // netStatus=0;
            [NSObject showHudTipStr:@"未识别的网络"];
            break;
            
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"不可达的网络(未连接)");
            [NSObject showHudTipStr:@"未连接网络"];
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:
            [_playerView pause];
            [self wifiActe];
//            [JRToast showWithText:@"当前使用的是数据流量" duration:1.0];
            NSLog(@"2G,3G,4G...的网络");
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
          //  netStatus=3;
//            [_playerView playerControlView:nil playerModel:self.playerModel];
//            [_playerView autoPlayTheVideo];
            //[self getdata];
            break;
        default:
            break;
    }
}];
//开始监听
    [manager startMonitoring];
}
-(void)zf_player3GPlay{
    [self wifiAct];
}
-(void)zf_playerwifiPlay{
    [self checkNet];
}
-(void)wifiAct{
    
        [_playerView playerControlView:nil playerModel:self.playerModel];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您当前使用的是移动数据网络" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续观看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                [_playerView autoPlayTheVideo];
              
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [_playerView pause];
            }];
            
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            

}
-(void)wifiActe{
    if ([DEFAULTS boolForKey:@"isWifiShow"]==YES) {
        [_playerView playerControlView:nil playerModel:self.playerModel];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您当前使用的是移动数据网络" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续观看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_playerView play];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [_playerView pause];
        }];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        [_playerView autoPlayTheVideo];
    }
}
#pragma mark - Action
-(void)checkJS:(NSString *)result{
    [JRToast showWithText:result duration:1.0];
}
-(void)zf_playerFull{
//    self.playerView.hasDownload=NO;
}
-(void)toBuyClassJS{
    MoviewToWebViewController *CV=[[MoviewToWebViewController alloc]init];
    NSString *urlstring=[NSString stringWithFormat:@"%@/api.php/Shop/submitOrder?classId=%@&userId=%@&newOrder=1&more=0&orderType=2",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
    CV.webUrl=[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.navigationController pushViewController:CV animated:NO];

}
-(void)keyupJS{
    self.commentType=@"1";
    [self startComment];
}

-(void)replyCommentJS:(NSString *)commentId{
    self.commentType=@"2";
    self.commentId=commentId;
    [self startComment];
}
-(void)replyToJS:(NSString *)replyId{
     self.commentType=@"3";
    self.replyId=replyId;
    [self startComment];

}
-(void)startComment{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kScreen_Height-44, kScreen_Width, 44)];
        
        }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    [self.view addSubview:self.key];

}
-(void)sendClassComment{
        [self.key.textView resignFirstResponder];
        if ([self.commentType isEqualToString:@"1"]) {
            [self classReply:self.key.textView.text];
        }else if([self.commentType isEqualToString:@"2"]){
            [self commentReply:self.key.textView.text];
        }else{
            [self replyto:self.key.textView.text];
        }

}
-(void)keyboardShow:(NSNotification *)note
{
    if ([self.commentType isEqualToString:@"1"]) {
        self.key.label.text=@"请输入对此课程的评价";
    }else if([self.commentType isEqualToString:@"2"]){
        self.key.label.text=@"请输入回复内容";
    }else{
        self.key.label.text=@"请输入回复内容";
    }

    _playerView.iskey = YES;
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    _playerView.iskey = NO;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
    
}
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    
    [contentView resignFirstResponder];
//    [self.webview reload];
    if ([self.commentType isEqualToString:@"1"]) {
        [self classReply:contentView.text];
    }else{
        [self commentReply:contentView.text];
    }
    
}
-(void)classReply:(NSString *)content{
    if(self.key.textView.text.length==0){
        [JRToast showWithText:@"您未输入任何内容" duration:1.0];
    }else{
    [kNetManager classComment:[DEFAULTS objectForKey:@"userId"] classId:self.classId content:content Success:^(id responseObject) {
//        [JRToast showWithText:[NSString stringWithFormat:@"%@",responseObject] duration:3.0];
        NSString *urlstr=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@&commentIndex=2",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
        NSURL* url = [NSURL URLWithString:urlstr];
        [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    } Failure:^(NSError *error) {
        [JRToast showWithText:[NSString stringWithFormat:@"%@",error] duration:3.0];
    }];
    }
}
-(void)replyto:(NSString *)content{
    if(self.key.textView.text.length==0){
        [JRToast showWithText:@"您未输入任何内容" duration:1.0];
    }else{
        [kNetManager replyToReply:[DEFAULTS objectForKey:@"userId"] replyId:self.replyId content:content Success:^(id responseObject) {
            NSLog(@"回复回复%@",responseObject);
            NSString *urlstr=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@&commentIndex=2",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
            NSURL* url = [NSURL URLWithString:urlstr];
            [self.webview loadRequest:[NSURLRequest requestWithURL:url]];

        } Failure:^(NSError *error) {
            
        }];
    }

}
-(void)commentReply:(NSString *)content{
    if(self.key.textView.text.length==0){
        [JRToast showWithText:@"您未输入任何内容" duration:1.0];
    }else{
    [kNetManager classReply:[DEFAULTS objectForKey:@"userId"] commentId:self.commentId content:content Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *urlstr=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@&commentIndex=2",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
        NSURL* url = [NSURL URLWithString:urlstr];
        [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    } Failure:^(NSError *error) {
        
    }];
    }
}

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image)
        
    {
        
        newimage = nil;
        
    } else {
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height)
            
        {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        } else {
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}
-(void)viewDidAppear:(BOOL)animated{
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
    
    [kNetManager class_read_act:user_id classId:self.classId Success:^(id responseObject) {
        NSLog(@"resp观看%@",responseObject);
    } Failure:^(NSError *error) {
        NSLog(@"resp:%@",error);
    }];
}
-(void)tocommentWeb{
    NSString *urlstr=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@&commentIndex=2",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
    NSURL* url = [NSURL URLWithString:urlstr];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}
-(void)stopVideo{
//    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
//    {
        self.isPlaying = NO;
        self.playerView.playerPushedOrPresented = NO;
 //   }

}
-(void)toGoodsJS:(NSString *)goodsId{
    NSLog(@"goosid:%@",goodsId);
    MoviewToWebViewController *CV=[[MoviewToWebViewController alloc]init];
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
