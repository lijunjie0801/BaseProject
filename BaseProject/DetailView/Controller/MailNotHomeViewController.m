//
//  MailNotHomeViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/26.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MailNotHomeViewController.h"
#import "MailNotHomeListCell.h"
#import "MailNotHomeModel.h"
#import "CustomWebViewController.h"
@interface MailNotHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    NSInteger _count;
    NSInteger _morecount;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)NSString *topImageUrl;

@end

@implementation MailNotHomeViewController
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
    [self getData];
  
}
-(void)getData{
    [kNetManager getShopCateData:self.cateId page:[NSString stringWithFormat:@"%ld",(long)_count] Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            if (!_count||_count==1) {
                [_dataSource removeAllObjects];
            }

            NSLog(@"该分类商品数据：%@",responseObject);
            _topImageUrl=responseObject[@"datas"][@"shopCate"][@"cateImg"];
            NSArray *goodsArray=responseObject[@"datas"][@"shopCate"][@"goods"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in goodsArray) {
                MailNotHomeModel *model = [[MailNotHomeModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            
           
                [_dataSource addObjectsFromArray:homeModelArray];
                [_collectionView reloadData];
            _morecount=[responseObject[@"datas"][@"shopCate"][@"more"] integerValue];
            
            
           
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
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
    flowlayout.headerReferenceSize=CGSizeMake(kScreen_Width, 210);
    flowlayout.sectionInset= UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 ,0, kScreen_Width, kScreen_Height-150) collectionViewLayout:flowlayout];
    [_collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
      [_collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.collectionView.header.stateHidden=YES;
    self.collectionView.header.updatedTimeHidden=YES;
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
    [self getData];
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
    
    return CGSizeMake((kScreen_Width-30)/ 2, (kScreen_Width - 6) / 2 + 50);
    
    
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
        [header addSubview:self.headerImage];
        return header;
    }
 
    return nil;
}
/*
 *  补充头部内容
 */
-(void)addContent
{
    UIImageView *headerImage=[[UIImageView alloc]init];
    headerImage.contentMode=UIViewContentModeScaleAspectFill;
    headerImage.clipsToBounds=YES;
    headerImage.frame=CGRectMake(0, 0, self.view.frame.size.width, 200);
    [headerImage sd_setImageWithURL:[NSURL URLWithString:_topImageUrl] placeholderImage:nil];
    //headerImage.image=[UIImage imageNamed:@"lazhu"];
    self.headerImage=headerImage;
}
- (void)footerRereshing {
    
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        _count += 1;
        [self getData];
        [self.collectionView.footer endRefreshing];
    }];
    
}


@end
