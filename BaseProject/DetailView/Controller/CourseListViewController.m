//
//  CourseListViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/24.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "CourseListViewController.h"
#import "MLMSegmentManager.h"
#import "CourseListCell.h"
#import "VideoDetailViewController.h"
#import "MoviePlayerViewController.h"
@interface CourseListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,CourseListCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@end

@implementation CourseListViewController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource =[NSMutableArray array];
    }
    return _dataSource;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor redColor]];
    NSLog(@"classCateId___%@",self.classCateId);
    NSLog(@"userId____%@",[DEFAULTS objectForKey:@"userId"]);
   
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 10;
    //上下间距
    flowlayout.minimumLineSpacing = 0;
      flowlayout.sectionInset= UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 ,0, kScreen_Width, kScreen_Height-200) collectionViewLayout:flowlayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    //        [_collectionView setContentOffset:CGPointMake(0,1500) animated:YES];
    //注册cell
    [_collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    self.collectionView.header.stateHidden=YES;
    self.collectionView.header.updatedTimeHidden=YES;
    [_collectionView registerClass:[CourseListCell class] forCellWithReuseIdentifier:@"listCell"];

    [self.view addSubview:_collectionView];
    [self getAllData];
}

-(void)getAllData{
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
   [kNetManager getOnecate_classlist:user_id cate_id:self.classCateId Success:^(id responseObject) {
       if ([responseObject[@"status"] integerValue]==100) {
           NSArray *list=responseObject[@"datas"][@"onecate_classlist"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
           for (NSDictionary *dic in list) {
               CourseModel *model = [[CourseModel alloc]init];
               [model setValuesForKeysWithDictionary:dic];
               [homeModelArray addObject:model];
           }
           _dataSource=[homeModelArray mutableCopy];
           [self.collectionView reloadData];
       }else{
           [JRToast showWithText:responseObject[@"msgs"] duration:2];
       }
       NSLog(@"repcon:%@",responseObject);
   } Failure:^(NSError *error) {
       NSLog(@"%@",error);
   }];
    NSLog(@"_dataSource****%@",_dataSource);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (void)headerRereshing{
    //[self.tableView addLegendHeaderWithRefreshingBlock:^{
    //    _count = 0;
       [self getAllData];
    [_collectionView headerEndRefreshing];
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
       NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
    }else{
         CourseModel *model=self.dataSource[indexPath.row];
        MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
        vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,model.classId,[DEFAULTS objectForKey:@"userId"]];

        vc.classId=model.classId;
        [self.navigationController pushViewController:vc animated:NO];
       
       
    }

    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    cell.delegate=self;
    cell .userInteractionEnabled = YES;
    CourseModel *model=self.dataSource[indexPath.row];
    [cell updateWithModel:model];
    cell.indexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreen_Width-30)/ 2, (kScreen_Width - 6) / 2 + 65);
    
    
}

-(void)selectSaveBtnAction:(NSString *)indexRow{
    NSLog(@"index++++%@",indexRow);
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    CourseModel *model=self.dataSource[[indexRow integerValue]];
    [kNetManager class_collect_act:user_id classId:model.classId Success:^(id responseObject) {
        //  NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            NSLog(@"%@",responseObject);
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {
        NSLog(@"错误信息%@",error);
    }];

    }
   
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
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
