//
//  VideoDetailViewController.m
//  SKOClass
//
//  Created by fyaex001 on 2017/4/1.
//  Copyright © 2017年 lei. All rights reserved.
//

#import "VideoDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Masonry.h"
#import "ZFPlayer.h"
#import "UINavigationController+ZFFullscreenPopGesture.h"
#import "SGPageView.h"
#import "BuyedGoodsViewController.h"
#import "WebViewJS.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface VideoDetailViewController ()<ZFPlayerDelegate,UIScrollViewDelegate,UIWebViewDelegate,WebViewJSDelegate,UIGestureRecognizerDelegate>{
    NSInteger netStatus;
}
@property (nonatomic, strong) UIView *playerFatherView;
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic,strong) NSArray *menuTitleArr;
@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) UIViewController *yunGoodsVC;
@property (nonatomic,strong) UIViewController *myGoodsVC;
@property (nonatomic,strong) UIViewController *importFormatVC;
@property(nonatomic,strong) NSString *stringUrl;
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *shareTitle;
@property(nonatomic,strong) NSString *shareUrl;
@property(nonatomic,strong) NSString *shareContent;
@property(nonatomic,strong) UIWebView *webview;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic,strong)UIButton *bigBackBtn;
@property(nonatomic, strong)NSMutableArray *videoListArray;
@end

@implementation VideoDetailViewController
-(NSMutableArray *)videoListArray{
    if (!_videoListArray) {
        _videoListArray=[NSMutableArray array];
    }
    return _videoListArray;
}
- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView ) {
       // self.isPlaying = NO;
        self.playerView.playerPushedOrPresented = NO;
    }
       self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self checkNet];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [ZZLProgressHUD popHUD];
    // push出下一级页面时候暂停
    [self.playerView resetPlayer];
    [self.playerView removeFromSuperview];
//    [self.webview removeFromSuperview];
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {

        self.playerView.playerPushedOrPresented = YES;
    }
    [self.rdv_tabBarController setTabBarHidden:NO];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;
    [self.rdv_tabBarController setTabBarHidden:YES];
   
    [self setUI];
    
    [self getClassVideoData];
     [self setWebview];
}
-(void)setWebview{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,kScreen_Width*9/16, kScreen_Width, kScreen_Height-kScreen_Width*9/16)];
    _webview=webview;
    webview.delegate=self;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    webview.scalesPageToFit = YES;
    webview.backgroundColor = [UIColor whiteColor];
    NSString *urlstr=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,self.classId,[DEFAULTS objectForKey:@"userId"]];
    NSURL* url = [NSURL URLWithString:urlstr];
    [ZZLProgressHUD showHUDWithMessage:@"正在加载"];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    webview.allowsInlineMediaPlayback = YES;
    webview.mediaPlaybackRequiresUserAction = NO;
   // [[[UIApplication sharedApplication ] keyWindow ] addSubview : webview];
    [self.view addSubview:webview];
}
-(void)setUI{
    self.zf_prefersNavigationBarHidden = YES;
    self.playerFatherView = [[UIView alloc] init];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.playerFatherView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.playerFatherView autoSetDimensionsToSize:CGSizeMake(kScreen_Width, kScreen_Width*9/16)];
  
    _playerModel                  = [[ZFPlayerModel alloc] init];
    _playerModel.title            = @"风格互换：原来你我相爱";
    _playerModel.videoURL         = [NSURL URLWithString:_stringUrl];
    _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
    _playerModel.fatherView       = self.playerFatherView;
    
    _playerView = [[ZFPlayerView alloc] init];
    [_playerView playerControlView:nil playerModel:self.playerModel];
   // [_playerView resetToPlayNewVideo:_playerModel];
    // 设置代理
    _playerView.delegate = self;
    _playerView.hasDownload    = YES;
    // 打开预览图
    self.playerView.hasPreviewView = YES;
    
    
    // 自动播放，默认不自动播放
    //[self.playerView autoPlayTheVideo];
    //[SVProgressHUD show];
  

}
-(void)getClassVideoData{
    [kNetManager getClass_infoData:self.classId userId:[DEFAULTS objectForKey:@"userId"]Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
           _stringUrl=responseObject[@"datas"][@"class_info"][@"classUrl"];
            _imageUrl= responseObject[@"datas"][@"class_info"][@"classImg"];
            _shareTitle=responseObject[@"datas"][@"class_info"][@"classTitle"];
            _shareContent=responseObject[@"datas"][@"class_info"][@"classDescription"];
            _shareUrl=responseObject[@"datas"][@"class_info"][@"classinfo_url"];
            NSArray *listArray= responseObject[@"datas"][@"class_info"][@"videoList"];
            //_playerModel                  = [[ZFPlayerModel alloc] init];
            _playerModel.title            = _shareTitle;
            _playerModel.videoURL         = [NSURL URLWithString:_stringUrl];
            _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
            _playerModel.fatherView       = self.playerFatherView;
            _playerModel.isSave=responseObject[@"datas"][@"class_info"][@"isSave"];
           // BOOL iswifi=[DEFAULTS boolForKey:@"isWifiShow"];
            if ([DEFAULTS boolForKey:@"isWifiShow"]==YES) {
                if (netStatus==2) {
                    [_playerView resetToPlayNewVideo:_playerModel];
//                    _playerView.isSave=@"000";
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您当前使用的是移动数据网络" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续观看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       [_playerView resetToPlayNewVideo:_playerModel];
                        
                    }];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [self dismissViewControllerAnimated:NO completion:nil];
                    }];
                    
                    [alertController addAction:okAction];
                    [alertController addAction:cancelAction];
                    
                    [self presentViewController:alertController animated:YES completion:nil];

                }else{
                   [_playerView resetToPlayNewVideo:_playerModel];                }

            }else{
                 [_playerView resetToPlayNewVideo:_playerModel];
            }

            
            NSMutableArray *mArray=[NSMutableArray array];
            for (int i=0; i<listArray.count; i++) {
                NSDictionary *dic=listArray[i];
                [mArray addObject:dic];
            }
            _videoListArray =[mArray mutableCopy];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2];
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)alertWifiShow{
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark - MenuViewDelegate

/**
 *点击菜单
 */

#pragma mark - UIScrollViewDelegate

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 这里设置横竖屏不同颜色的statusbar
     if (ZFPlayerShared.isLandscape) {
        return UIStatusBarStyleDefault;
     }
    return UIStatusBarStyleDefault;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [ZZLProgressHUD popHUD];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;

}

//退出时显示

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction {

        [self dismissViewControllerAnimated:YES completion:nil];
    //  [self.navigationController popViewControllerAnimated:NO];
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
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]];
    NSArray *imgArr=@[image];
    NSURL *shareUrl=[NSURL URLWithString:_shareUrl];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:_shareContent
                                     images:imgArr
                                        url:shareUrl
                                      title:_shareTitle
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
-(void)zf_playerShare{
    [kNetManager class_collect_act:[DEFAULTS objectForKey:@"userId"] classId:self.classId Success:^(id responseObject) {//  NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {
        NSLog(@"错误信息%@",error);
    }];

}
-(void)clickEmpt
{
    [self.bigBackBtn removeFromSuperview];
}

- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
  
}

- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }

    [kNetManager class_read_act:user_id classId:self.classId Success:^(id responseObject) {
        NSLog(@"resp%@",responseObject);
    } Failure:^(NSError *error) {
         NSLog(@"resp:%@",error);
    }];
}
-(void)checkNet{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
     [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                netStatus=0;
                [NSObject showHudTipStr:@"未识别的网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                netStatus=1;
                [NSObject showHudTipStr:@"未连接网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netStatus=2;
                [JRToast showWithText:@"当前使用的是数据流量" topOffset:kScreen_Width*9/32 duration:3.0];
                NSLog(@"2G,3G,4G...的网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netStatus=3;
                //[NSObject showHudTipStr:@"2G,3G,4G...的网络"];
                NSLog(@"wifi的网络");
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}


-(void)sendVideoIndex:(NSString *)index{
     NSLog(@"播放第%@",index);
    NSLog(@"列表%@",_videoListArray);
    NSDictionary *videodic=_videoListArray[[index integerValue]];
    _playerModel.videoURL  =[NSURL URLWithString:videodic[@"VideoUrl"]];
    _playerModel.title=videodic[@"VideoTitle"];
    _playerModel.placeholderImageURLString=@"http://oo9xh65gr.bkt.clouddn.com/14941494415786";
   [_playerView resetToPlayNewVideo:_playerModel];
    
}
-(void)zf_playerFull{
    self.webview.hidden=YES;
}
-(void)zf_playerBack{
    self.webview.hidden=NO;
}


@end
