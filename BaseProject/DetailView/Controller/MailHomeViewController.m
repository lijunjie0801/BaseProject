//
//  MailHomeViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/25.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MailHomeViewController.h"
#import "SDCycleScrollView.h"
#import "MailHomeViewCell.h"
#import "MailHomeModel.h"
#import "CustomWebViewController.h"
#define imgWidth kScreen_Width/4
@interface MailHomeViewController ()<UITableViewDelegate,UITableViewDataSource,MailHomeViewCellDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *scroView;
@property(nonatomic,strong)NSMutableArray *homeArray;
@property(nonatomic,strong)SDCycleScrollView *sdview;
@property(nonatomic,strong)NSMutableArray *topGoodArray;
@property(nonatomic,strong)NSMutableArray *bannalIds;
@end

@implementation MailHomeViewController
-(NSMutableArray *)topGoodArray{
    if (!_topGoodArray) {
        _topGoodArray = [NSMutableArray array];
    }
    return _topGoodArray;
}
-(NSMutableArray *)bannalIds{
    if (!_bannalIds) {
        _bannalIds = [NSMutableArray array];
    }
    return _bannalIds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMyTableView];
    

    [self getIndexData];
    
   
    

}
-(void)setTopMailView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.67+imgWidth+120)];
    topView.userInteractionEnabled=YES;
    
    SDCycleScrollView *scr=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.67) imageNamesGroup:nil];
    [topView addSubview:scr];
    scr.delegate=self;
    _sdview=scr;
    scr.showPageControl=YES;
    scr.pageDotImage=[UIImage imageNamed:@"circleNormal"];
    scr.currentPageDotImage=[UIImage imageNamed:@"circleSelect"];
    scr.delegate=self;
    scr.autoScrollTimeInterval=3;

    UILabel *titleLabel=[[UILabel alloc]init];
    //self.titleLabel=titleLabel;
    titleLabel.text=@"推荐商品";
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.numberOfLines=0;
    [topView addSubview:titleLabel];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kScreen_Width/1.67+20];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [titleLabel autoSetDimensionsToSize:CGSizeMake(100, 20)];

    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kScreen_Width/1.67+50, kScreen_Width, imgWidth+60)];
    [topView addSubview:scrollView];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    
    
    for (int index = 0; index <_topGoodArray.count; index++) {
        NSString *goodImg=_topGoodArray[index][@"goodsImg"];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame=CGRectMake(index * imgWidth+(index+1)*10, 0, imgWidth,imgWidth);
        imageView.tag=100+index;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
         UIImage *load=[UIImage sd_animatedGIFNamed:@"myloadingA"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:goodImg] placeholderImage:load];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topImageClick:)];
        UIView *singleTapView = [tap view];
        singleTapView.tag =index;
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        UILabel *proNameLabel=[[UILabel alloc]init];
        proNameLabel.textColor=[UIColor colorWithHexString:@"#555555"];
        proNameLabel.tag=200+index;
        proNameLabel.font=[UIFont systemFontOfSize:14];
        proNameLabel.frame=CGRectMake(index * imgWidth+(index+1)*10, imgWidth+5, imgWidth,20);
        proNameLabel.text=_topGoodArray[index][@"goodsName"];
//        proNameLabel.numberOfLines=0;
        [scrollView addSubview:proNameLabel];
        
        UILabel *priceLabel=[[UILabel alloc]init];
        priceLabel.text=[NSString stringWithFormat:@"¥%@",_topGoodArray[index][@"goodsShowPrice"]];
        priceLabel.textColor=[UIColor colorWithHexString:@"#555555"];
        priceLabel.tag=300+index;
        priceLabel.font=[UIFont systemFontOfSize:14];
        priceLabel.frame=CGRectMake(index * imgWidth+(index+1)*10, imgWidth+25, imgWidth,20);
        [scrollView addSubview:priceLabel];
        
    }
    scrollView.contentSize = CGSizeMake((imgWidth+10) *_topGoodArray.count+10, 0);
     _tableView.tableHeaderView=topView;
}
-(void)topImageClick:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld",[singleTap view].tag);
    NSString *selectGoodsId=_topGoodArray[[singleTap view].tag-100][@"goodsId"];
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
-(void)getIndexData{
    [kNetManager getShopIndexData:^(id responseObject) {
        NSLog(@"商城首页:%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *array=responseObject[@"datas"][@"shopIndex"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in array) {
                MailHomeModel *model = [[MailHomeModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            _homeArray=[homeModelArray mutableCopy];
            [self.tableView reloadData];
            
            NSArray *bannalArray=responseObject[@"bannel"][@"list"];
            NSMutableArray *bannals=[NSMutableArray array];
            NSMutableArray *bannalIds=[NSMutableArray array];
            for (NSDictionary *dic in bannalArray) {
                NSString* strUrl = dic[@"bannerImg"];
                [bannals addObject:strUrl];
                [bannalIds addObject:dic[@"bannerstorId"]];
            }
            _bannalIds=[bannalIds mutableCopy];
            
            NSArray *goodsArray=responseObject[@"bannel"][@"goodslist"];
            NSMutableArray *goods=[NSMutableArray array];
            for (NSDictionary *dic in goodsArray) {
                [goods addObject:dic];
            }
            _topGoodArray =[goods mutableCopy];
            NSLog(@"wwe:%@",_topGoodArray);
             [self setTopMailView];
            _sdview.imageURLStringsGroup=bannals;

            
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)setMyTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.separatorStyle = NO;
      _tableView.contentInset = UIEdgeInsetsMake(0, 0,114, 0);
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    self.tableView.header.stateHidden=YES;
    self.tableView.header.updatedTimeHidden=YES;
    self.view = _tableView;
    _tableView.showsVerticalScrollIndicator = NO;

   
}

- (void)headerRereshing{
    [self getIndexData];
  
    [self.tableView headerEndRefreshing];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MailHomeModel *model=_homeArray[indexPath.row];
//    MailHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   // if (!cell) {
//     MailHomeViewCell   *cell = [[MailHomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" imageCount:model.list.count];
    //}
    
    NSString *identifier = [NSString stringWithFormat:@"TimeLineCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    MailHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =  [[MailHomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageCount:model.list.count];
    }
    cell.indexRow=[NSString stringWithFormat:@"%ld",indexPath.row];
    cell.delegate=self;
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [cell updataWithModel:model];
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _homeArray.count;
}
-(void)selectGoodsAction:(NSDictionary *)dic{
    NSLog(@"dic%@",dic);
    NSInteger selectindexRow=[dic[@"indexRow"] integerValue];
    NSInteger selectindex=[dic[@"index"] integerValue];
     MailHomeModel *model=_homeArray[selectindexRow];
    NSString *selectGoodsId=model.list[selectindex][@"goodsId"];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreen_Width/1.67+kScreen_Width/4+125;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
