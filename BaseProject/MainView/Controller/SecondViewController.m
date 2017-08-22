//
//  SecondViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/17.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SecondViewController.h"
#import "SGPageView.h"
#import "MLMSegmentManager.h"
#import "CourseListCell.h"
#import "CourseListViewController.h"
#import "NotCourListViewController.h"
#import "VideoDetailViewController.h"
@interface SecondViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@property(nonatomic,strong)NSMutableArray *categoryArray;
@property(nonatomic,strong)NSMutableArray *classCateIdArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong)NSString *index;
@end

@implementation SecondViewController


-(NSMutableArray *)categoryArray{
    if (!_categoryArray) {
        _categoryArray=[NSMutableArray array];
         }
    return _categoryArray;
}
-(NSMutableArray *)classCateIdArray{
    if (!_classCateIdArray) {
        _classCateIdArray=[NSMutableArray array];
    }
    return _classCateIdArray;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray=[NSMutableArray array];
    }
    return _titleArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"课程";
    NSArray *titleArr = @[@"课程", @"已购买", @"已收藏", @"已观看"];
 
 //   SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 45) delegate:self titleNames:titleArr];
   
    
    SGPageTitleView *pageTitleView=[SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 45) delegate:self titleNames:titleArr isdouble:@"0"];
    pageTitleView.isdouble=@"0";
    _pageTitleView=pageTitleView;
    pageTitleView.titleColorStateSelected=[UIColor colorWithHexString:@"0x59c5b7"];
    pageTitleView.indicatorColor=[UIColor colorWithHexString:@"0x59c5b7"];
    pageTitleView.selectedIndex = 0;
    pageTitleView.indicatorStyle=SGIndicatorTypeEqual;
    [self.view addSubview:pageTitleView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toSencondCtr:) name:@"toSencondCtr" object:nil];
  
    
    
    NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents = [array lastObject];
    NSString *documentPath = [documents stringByAppendingPathComponent:@"arrayXML.xml"];
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:documentPath];
    NSLog(@"%@", resultArray);
    NSMutableArray *titleArray=[NSMutableArray array];
    NSMutableArray *classCateIdArray=[NSMutableArray array];
    for (int i=0; i<resultArray.count; i++) {
        [titleArray addObject:resultArray[i][@"classCateName"]];
        [classCateIdArray addObject:resultArray[i][@"classCateId"]];
    }
    _classCateIdArray =[classCateIdArray mutableCopy];
    _titleArray=[titleArray mutableCopy];
//    
//    if (_classCateIdArray.count==0||_titleArray==0) {
//     
//    }
    if (_titleArray&&_titleArray.count!=0) {
         [self setSecondTopView];
    }else{
        [[HttpManagerPort sharedHttpManagerPort]getCategory:^(id responseObject) {
            if ([responseObject[@"status"] integerValue]==100) {
                NSArray *arr=responseObject[@"datas"][@"category"];
                NSMutableArray *tiarray=[NSMutableArray array];
                NSMutableArray *idarray=[NSMutableArray array];
                for (NSDictionary *dict in arr) {
                    [tiarray addObject:dict[@"classCateName"]];
                    [idarray addObject:dict[@"classCateId"]];
                }
                _classCateIdArray =[idarray mutableCopy];
                _titleArray=[tiarray mutableCopy];
                [self setSecondTopView];
            }
        } Failure:^(NSError *error) {
            
        }];
    }
  

}
-(void)toSencondCtr:(NSNotification *)notifi{
    NSString *index=notifi.userInfo[@"index"];
    self.index=index;
    if (_segHead&&_segScroll) {
        [_segHead removeFromSuperview];
        [_segScroll removeFromSuperview];
    }
   
    
    [self setSecondTopView];
    _pageTitleView.selectedIndex=0;
}


- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < count; i ++) {
        CourseListViewController *vc = [CourseListViewController new];
        vc.classCateId=_classCateIdArray[i];
        [arr addObject:vc];
    }
    return arr;
}
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex{

    if (selectedIndex==0) {

        [self.view addSubview:_segHead];
        [self.view addSubview:_segScroll];
        for (UIViewController *controller in self.childViewControllers) {
            if([controller isKindOfClass:[NotCourListViewController class]]){
                [controller removeFromParentViewController];
                [controller.view removeFromSuperview];
            }
        }
    }else{
        [_segHead removeFromSuperview];
        [_segScroll removeFromSuperview];
        for (UIViewController *controller in self.childViewControllers) {
            if([controller isKindOfClass:[NotCourListViewController class]]){
                [controller removeFromParentViewController];
                [controller.view removeFromSuperview];
            }
        }

        if (![DEFAULTS objectForKey:@"userId"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                LoginViewController *login = [[LoginViewController alloc]init];
                
                [self presentViewController:login animated:YES completion:nil];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];

        }else{
        NSArray *type=@[@"class_buy",@"class_collect",@"class_read"];
        NotCourListViewController *sv;
        if (!sv) {
            sv=[[NotCourListViewController alloc]init];
            sv.typeName=type[selectedIndex-1];
            [self addChildViewController:sv];
            [self.view addSubview:sv.view];
        }
        }
       
    }
}
-(void)setSecondTopView{
    NSLog(@"_classCateIdArray%@",_classCateIdArray);
    NSLog(@"分类标题数组%@",_titleArray);
    if (_titleArray.count!=0) {
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, 40) titles:_titleArray headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutDefault];
    _segHead.bottomLineHeight=0;
    _segHead.slideHeight = 30;
    _segHead.fontSize = 16;
    _segHead.slideScale = 0.7;
    _segHead.selectColor =  [UIColor whiteColor];
    _segHead.deSelectColor = [UIColor blackColor];
    _segHead.slideColor = [UIColor colorWithHexString:@"0x59c5b7"];
    _segHead.slideCorner=1;
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:_titleArray.count]];
    _segScroll.addTiming = SegmentAddScale;
    _segScroll.addScale = 0.1;
    _segScroll.loadAll = NO;
    
    
    
    [self.view addSubview:_segHead];
    [self.view addSubview:_segScroll];
    
    
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll contentChangeAni:NO completion:^{
        
            
            
    } selectEnd:^(NSInteger index) {
       
        NSLog(@"第%ld个视图,有什么操作?",index);
       
        
    }];
    NSInteger index=[[DEFAULTS valueForKey:@"selindex"] integerValue];
    NSMutableArray *btnArray=_segHead.btnArray;
    UIButton *btn=btnArray[index];
    [_segHead selectedHeadTitles:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)dealloc{
  //  [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
