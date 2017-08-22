//
//  ForthViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/17.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ForthViewController.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"
#import "SGPageView.h"
#import "BuyedGoodsViewController.h"
@interface ForthViewController ()<SGPageTitleViewDelegate>

@end

@implementation ForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    NSArray *titleArr=@[@"购买的商品",@"购买的视频"];
   // SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 35) delegate:self titleNames:titleArr];
    
    
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 35) delegate:self titleNames:titleArr isdouble:@"1"];
    pageTitleView.isdouble=@"1";
    pageTitleView.titleColorStateSelected=[UIColor colorWithHexString:@"0x59c5b7"];
    pageTitleView.indicatorColor=[UIColor colorWithHexString:@"0x59c5b7"];
    pageTitleView.selectedIndex = 0;
    pageTitleView.indicatorStyle=SGIndicatorTypeEqual;
    [self.view addSubview:pageTitleView];
}


- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex{
        for (UIViewController *controller in self.childViewControllers) {
            if([controller isKindOfClass:[BuyedGoodsViewController class]]){
            [controller removeFromParentViewController];
            [controller.view removeFromSuperview];
            }
        }

        BuyedGoodsViewController *bv;
        if (!bv) {
            bv=[[BuyedGoodsViewController alloc]init];
        }
        if (selectedIndex==0) {
            bv.isVideo=@"no";
        }else{
            bv.isVideo=@"yes";
        }

        [self addChildViewController:bv];
        [self.view addSubview:bv.view];
 
}


@end
