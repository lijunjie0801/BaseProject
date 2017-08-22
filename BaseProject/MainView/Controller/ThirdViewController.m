//
//  ThirdViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/17.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ThirdViewController.h"
#import "SGPageView.h"
#import "MLMSegmentManager.h"
#import "MailHomeViewController.h"
#import "MailNotHomeViewController.h"
#import "NewMailHomeViewController.h"
@interface ThirdViewController ()
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property (nonatomic, strong) NSMutableArray *catesMutableArray;
@property (nonatomic, strong) NSMutableArray *cateIdMutableArray;
@end

@implementation ThirdViewController
-(NSMutableArray *)catesMutableArray{
    if (!_catesMutableArray) {
        _catesMutableArray =[NSMutableArray array];
    }
    return _catesMutableArray;
}
-(NSMutableArray *)cateIdMutableArray{
    if (!_cateIdMutableArray) {
        _cateIdMutableArray =[NSMutableArray array];
    }
    return _cateIdMutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商城";
  
    [kNetManager getGoodsCateData:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSMutableArray *goodCateNameArray=[NSMutableArray array];
            NSMutableArray *goodCateIdArray=[NSMutableArray array];
            NSLog(@"分类数据%@",responseObject);
            NSArray *goodCateArray=responseObject[@"datas"][@"getGoodsCate"];
             NSLog(@"分类数据11%@",goodCateArray);
            for (NSDictionary *goodCate in goodCateArray) {
                [goodCateNameArray addObject:goodCate[@"goodsCateName"]];
                [goodCateIdArray addObject: goodCate[@"goodsCateId"]];
            }
            
            _catesMutableArray =[goodCateNameArray copy];
            _cateIdMutableArray=[goodCateIdArray copy];
            NSLog(@"分类数据123%@",_catesMutableArray);
            [self setTopViewWithArray:_catesMutableArray];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2.0];
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    UIButton *searchbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 33, 33)];
    searchbtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [searchbtn setImage:[UIImage imageNamed:@"shouye_search"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchbtn];

}
-(void)setTopViewWithArray:(NSMutableArray *)list{
    
   // NSArray *list = @[@"首页",@"美食",@"烘焙",@"糖艺",@"蜡烛",@"手绘",@"摄影"];
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)  titles:list headStyle:SegmentHeadStyleLine layoutStyle:MLMSegmentLayoutCenter];
    _segHead.bottomLineHeight=1;
  //  _segHead.bottomLineColor=[UIColor colorWithName:@"0xf2f2f2"];
    _segHead.lineScale=0.5;
    _segHead.fontSize = 16;
    _segHead.lineHeight = 0.8;
    _segHead.lineColor=[UIColor colorWithHexString:@"0x59c5b7"];
    _segHead.selectColor =   [UIColor colorWithHexString:@"0x59c5b7"];
    _segHead.deSelectColor = [UIColor blackColor];
    
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame)+5, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:list.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    
    [self.view addSubview:_segHead];
    [self.view addSubview:_segScroll];
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll contentChangeAni:NO completion:^{
        
        
        
    } selectEnd:^(NSInteger index) {
        
        NSLog(@"第%ld个视图,有什么操作?",index);
        
        
    }];
    
    

}
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
        if (i==0) {
            MailHomeViewController *vc = [MailHomeViewController new];
            [arr addObject:vc];
        }else{
            MailNotHomeViewController *mc=[MailNotHomeViewController new];
            mc.cateId=_cateIdMutableArray[i];
            [arr addObject:mc];
        }
    }
    return arr;
}
- (void)rightBarClick{
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    cv.webUrl=[NSString stringWithFormat:@"%@/api.php/shop/goodsSearch",kBaseUrl] ;
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:cv];
    
    [self presentViewController:nav_third animated:NO completion:nil ];
//     [self.navigationController pushViewController:cv animated:NO];
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
