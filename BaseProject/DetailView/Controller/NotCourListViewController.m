//
//  NotCourListViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/25.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "NotCourListViewController.h"
#import "CourseListCell.h"
#import "VideoDetailViewController.h"
@interface NotCourListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,CourseListCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation NotCourListViewController



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    CourseModel *model=self.dataSource[indexPath.row];
    [cell updateWithModel:model];
    cell.delegate=self;
    cell.indexRow=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
-(void)selectSaveBtnAction:(NSString *)indexRow{
    NSLog(@"index++++%@",indexRow);
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreen_Width-30)/ 2, (kScreen_Width - 6) / 2 + 60);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.typeName isEqualToString:@"class_buy"]) {
        [self getBuyClass];
    }else if([self.typeName isEqualToString:@"class_collect"]){
        [self getCollectClass];
    }else if([self.typeName isEqualToString:@"class_read"]){
        [self getReadClass];
    }
   
    //self.view.backgroundColor=[UIColor greenColor];
    self.view.frame=CGRectMake(0, 50, kScreen_Width, kScreen_Height-45);
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 0;
    //上下间距
    flowlayout.minimumLineSpacing = 0;
    flowlayout.sectionInset= UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 ,0, kScreen_Width, kScreen_Height-160) collectionViewLayout:flowlayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    //        [_collectionView setContentOffset:CGPointMake(0,1500) animated:YES];
    //注册cell
    // [_collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    [_collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [_collectionView registerClass:[CourseListCell class] forCellWithReuseIdentifier:@"listCell"];
    self.collectionView.header.stateHidden=YES;
    self.collectionView.header.updatedTimeHidden=YES;
    
    [self.view addSubview:_collectionView];
}
-(void)getBuyClass{
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }

    [kNetManager getClass_buyList:user_id Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *list=responseObject[@"datas"][@"class_buy"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in list) {
                CourseModel *model = [[CourseModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            _dataSource=[homeModelArray mutableCopy];
            [self.collectionView reloadData];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
        NSLog(@"repcon:%@",responseObject);
    } Failure:^(NSError *error) {
        NSLog(@"已购买%@",error);
    }];
}
-(void)getCollectClass{
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }

    [kNetManager getClass_collectList:user_id Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *list=responseObject[@"datas"][@"class_save"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in list) {
                CourseModel *model = [[CourseModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            _dataSource=[homeModelArray mutableCopy];
            [self.collectionView reloadData];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
        NSLog(@"已收藏repcon:%@",responseObject);
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getReadClass{
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
    
    [kNetManager getClass_readList:user_id Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *list=responseObject[@"datas"][@"class_readsave"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in list) {
                CourseModel *model = [[CourseModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            _dataSource=[homeModelArray mutableCopy];
            [self.collectionView reloadData];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
        NSLog(@"已阅读repcon:%@",responseObject);
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CourseModel *model=_dataSource[indexPath.row];
    NSString *classId=model.classId;
    MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
    vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,model.classId,[DEFAULTS objectForKey:@"userId"]];

    vc.classId=classId;
    [self.navigationController pushViewController:vc animated:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)headerRereshing{
    //[self.tableView addLegendHeaderWithRefreshingBlock:^{
    //    _count = 0;
    //    [self getdata];
    if ([self.typeName isEqualToString:@"class_buy"]) {
        [self getBuyClass];
    }else if([self.typeName isEqualToString:@"class_collect"]){
        [self getCollectClass];
    }else if([self.typeName isEqualToString:@"class_read"]){
        [self getReadClass];
    }

    [_collectionView headerEndRefreshing];
    
}
- (void)footerRereshing {
    [_collectionView addLegendFooterWithRefreshingBlock:^{
        //        _count += 20;
        //        [self getdata];
        [_collectionView footerEndRefreshing];
    }];
    
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
