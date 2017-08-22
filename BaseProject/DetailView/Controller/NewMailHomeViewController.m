//
//  NewMailHomeViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/6/19.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "NewMailHomeViewController.h"

#import "MailNotHomeListCell.h"
#import "MailNotHomeModel.h"
#import "CustomWebViewController.h"
#import "SDCycleScrollView.h"
@interface NewMailHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,SDCycleScrollViewDelegate>{
    NSInteger _count;
    NSInteger _morecount;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong)SDCycleScrollView *sdc;
@property (nonatomic,strong)NSString *topImageUrl;
@property(nonatomic,strong)NSMutableArray *bannalIds;
@property(nonatomic,strong)NSMutableArray *bannalImgs;
@property (nonatomic,strong)UIView *topView;

@end

@implementation NewMailHomeViewController
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame=CGRectMake(0, 35, kScreen_Width, kScreen_Height-60);
    [self setMyCollectionView];
    _count=1;
   // [self getData];
    [self getIndexData];
    
}
-(void)getIndexData{
    [kNetManager getShopIndexData:^(id responseObject) {
        NSLog(@"SHANGCHENG:%@",responseObject);
        NSArray *bannalArray=responseObject[@"datas"][@"shopIndex"][@"bannel"];
        NSMutableArray *bannals=[NSMutableArray array];
        NSMutableArray *bannalIds=[NSMutableArray array];
        for (NSDictionary *dic in bannalArray) {
            NSString* strUrl = dic[@"bannerImg"];
            [bannals addObject:strUrl];
            [bannalIds addObject:dic[@"bannerstorId"]];
        }
        _bannalIds=[bannalIds mutableCopy];
        _bannalImgs=[bannals mutableCopy];
        _sdc.imageURLStringsGroup=bannals;
        
        NSArray *goodsArray=responseObject[@"datas"][@"shopIndex"][@"hotGoods"];
        NSMutableArray *homeModelArray=[NSMutableArray array];
        for (NSDictionary *dic in goodsArray) {
            MailNotHomeModel *model = [[MailNotHomeModel alloc]initWithShopDict:dic];
      //      [model initWithShopDict:dic];
            [homeModelArray addObject:model];
        }
        _dataSource =[homeModelArray mutableCopy];
        [_collectionView reloadData];
    } Failure:^(NSError *error) {
        
    }];
}
-(void)setMyCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 10;
    //上下间距
    flowlayout.minimumLineSpacing = 0;
    //设置collectionView头视图的大小
    flowlayout.headerReferenceSize=CGSizeMake(kScreen_Width, 240);
    flowlayout.sectionInset= UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 ,0, kScreen_Width, kScreen_Height-150) collectionViewLayout:flowlayout];
    [_collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    self.collectionView.header.stateHidden=YES;
    self.collectionView.header.updatedTimeHidden=YES;
  //  [_collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerClass:[MailNotHomeListCell class] forCellWithReuseIdentifier:@"listCell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewIdentifier"];
    [self.view addSubview:_collectionView];
    
}
- (void)headerRereshing{
    _count=1;
    [self getIndexData];
    [_collectionView headerEndRefreshing];
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MailNotHomeModel *model=_dataSource[indexPath.row];
    NSString *selectGoodsId=model.goodsId;
    CustomWebViewController *CV=[[CustomWebViewController alloc]init];
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
    CV.webUrl=[NSString stringWithFormat:@"%@/api.php/Shop/shopDetail?goodsId=%@&userId=%@",kBaseUrl,selectGoodsId,user_id];
    [self.navigationController pushViewController:CV animated:NO];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MailNotHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    // cell.model = self.dataSource[indexPath.row];
    MailNotHomeModel *model=self.dataSource[indexPath.row];
    [cell updateWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreen_Width-30)/ 2, (kScreen_Width - 6) / 2 + 70);
    
    
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerViewIdentifier" forIndexPath:indexPath];
        //添加头视图的内容
        [self addContent];
        //头视图添加view
        [header addSubview:self.topView];
        return header;
    }
    
    return nil;
}
/*
 *  补充头部内容
 */
-(void)addContent
{
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 240)];
    self.topView=topview;
   // topview.backgroundColor=[UIColor greenColor];
    
    SDCycleScrollView *scr=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 200) imageNamesGroup:nil];
    _sdc=scr;
    scr.showPageControl=YES;
    scr.pageDotImage=[UIImage imageNamed:@"circleNormal"];
    scr.currentPageDotImage=[UIImage imageNamed:@"circleSelect"];
    scr.delegate=self;
    scr.autoScrollTimeInterval=3;
    NSLog(@"bannals:%@",_bannalImgs);
    _sdc.imageURLStringsGroup=_bannalImgs;
    [topview addSubview:scr];
    
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 210, kScreen_Width-10, 30)];
    titleLab.text=@"推荐商品";
    [topview addSubview:titleLab];
    
}
- (void)footerRereshing {
    
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        _count += 1;
        [self getIndexData];
        [self.collectionView.footer endRefreshing];
    }];
    
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    CustomWebViewController *CV=[[CustomWebViewController alloc]init];
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
    CV.webUrl=[NSString stringWithFormat:@"%@/api.php/Shop/shopDetail?goodsId=%@&userId=%@",kBaseUrl,_bannalIds[index],user_id];
    [self.navigationController pushViewController:CV animated:NO];
    
}

@end
