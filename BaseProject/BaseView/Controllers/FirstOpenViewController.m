//
//  FirstOpenViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/21.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FirstOpenViewController.h"
#import "CYRootTabViewController.h"
@interface FirstOpenViewController ()

@end

@implementation FirstOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //得到图片的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"open" ofType:@"gif"];
        //将图片转为NSData
        NSData *gifData = [NSData dataWithContentsOfFile:path];
        //创建一个webView，添加到界面
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:webView];
        //自动调整尺寸
        webView.scalesPageToFit = YES;
        //禁止滚动
        webView.scrollView.scrollEnabled = NO;
        //设置透明效果
        webView.backgroundColor = [UIColor clearColor];
        webView.opaque = 0;
        //加载数据
        [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:self.view.bounds];
    [btn addTarget:self action:@selector(toAppHome) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:btn];
}
-(void)toAppHome{
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];
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
