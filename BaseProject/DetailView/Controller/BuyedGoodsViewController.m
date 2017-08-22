//
//  BuyedGoodsViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/27.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "BuyedGoodsViewController.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"
#import "SGPageView.h"
#import "ShopppingVideoCarCell.h"
#import "ShoppingVideoModel.h"
#import "CustomWebViewController.h"
#import "VideoDetailViewController.h"
@interface BuyedGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingCarCellDelegate,CustomWebViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮

@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额
@property (nonatomic,strong) UILabel *selectedNumLab;

@property(nonatomic,strong)UIView *totalView;

@property(nonatomic,assign) float allPrice;

@property(nonatomic,assign) int proNum;



@end

@implementation BuyedGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.dataArray = [[NSMutableArray alloc]init];
    self.view.frame=CGRectMake(0, 35, kScreen_Width, kScreen_Height);
    self.allPrice = 0.00;
    [self createSubViews];
    [self initData];
}
/**
 * 初始化假数据
 */

-(void)initData{

    [kNetManager getShopCarData:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([self.isVideo isEqualToString:@"no"]){
            NSArray *array=responseObject[@"datas"][@"changeUserInfo"][@"goods"];
            NSMutableArray *muAarray=[NSMutableArray array];
//            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height)];
//            imageview.image=[UIImage imageNamed:@"tutorial_1"];
//            [self.view addSubview:imageview];
//            if (array.count==0) {
//                imageview.hidden=NO;
//            }else{
//                imageview.hidden=YES;
//            }
                for (NSDictionary *infoDict in array) {
                    ShoppingModel *goodsModel = [[ShoppingModel alloc]initWithShopDict:infoDict];
                    [muAarray addObject:goodsModel];
                    self.dataArray=[muAarray mutableCopy];
                }
            
//            }
            [self CalculationPrice];
            if (self.dataArray.count!=0) {
                self.tableView.backgroundView.hidden=YES;
            }else{
                  self.tableView.backgroundView.hidden=NO;
            }
                

             [self.tableView reloadData];
        }else{
            NSArray *array=responseObject[@"datas"][@"changeUserInfo"][@"class"];
             NSMutableArray *muAarray=[NSMutableArray array];
            for (NSDictionary *infoDict in array) {
                ShoppingVideoModel *goodsModel = [[ShoppingVideoModel alloc]initWithShopDict:infoDict];
                [muAarray addObject:goodsModel];
                self.dataArray=[muAarray mutableCopy];
            }
             [self CalculationPrice];
            if (self.dataArray.count!=0) {
                self.tableView.backgroundView.hidden=YES;
            }else{
                self.tableView.backgroundView.hidden=NO;
            }

             [self.tableView reloadData];
    }
       
       
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

-(void)createSubViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,35, kScreen_Width, kScreen_Height-140) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view =_tableView;
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    self.tableView.header.stateHidden=YES;
    self.tableView.header.updatedTimeHidden=YES;
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    _tableView.tableFooterView=footView;
    
    UIView *totalView=[[UIView alloc]init];
    self.totalView=totalView;
    [self.navigationController.view addSubview:totalView];
    totalView.backgroundColor=[UIColor whiteColor];
    [totalView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [totalView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [totalView autoSetDimensionsToSize:CGSizeMake(kScreen_Width, 50)];
    
    
    UIView *topLine=[[UIView alloc]init];
    topLine.backgroundColor=RGB(241, 241, 241);
    [totalView addSubview:topLine];
    [topLine autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [topLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [topLine autoSetDimensionsToSize:CGSizeMake(kScreen_Width, 1)];
    
    UILabel *selectedNumLab=[[UILabel alloc]init];
    _selectedNumLab=selectedNumLab;
    NSMutableAttributedString *numStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共计%d件商品,",self.proNum]];
    [numStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x59c5b7"] range:NSMakeRange(2,numStr.length-6)];
    self.selectedNumLab.attributedText = numStr;
    self.proNum=0;
    self.selectedNumLab.attributedText = numStr;
    selectedNumLab.font=SYSTEMFONT(13.0);
    [totalView addSubview:selectedNumLab];
    [selectedNumLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [selectedNumLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [selectedNumLab autoSetDimensionsToSize:CGSizeMake([self getWidthWithTitle:[numStr string] font:SYSTEMFONT(13.0)], 50)];
    
    
    
    self.totalMoneyLab = [[UILabel alloc]init];
    [totalView addSubview:self.totalMoneyLab];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总需%.2f元",self.allPrice]];
    self.totalMoneyLab.attributedText = str;
    self.totalMoneyLab.font = SYSTEMFONT(13.0);
    [_totalMoneyLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:selectedNumLab withOffset:10];
    [_totalMoneyLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_totalMoneyLab autoSetDimensionsToSize:CGSizeMake(150, 50)];
    
    
    
    self.jieSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [totalView addSubview:self.jieSuanBtn];
    [_jieSuanBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_jieSuanBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_jieSuanBtn autoSetDimensionsToSize:CGSizeMake(100, 50)];
    [self.jieSuanBtn setBackgroundColor: [UIColor colorWithHexString:@"0x59c5b7"]];
    [self.jieSuanBtn addTarget:self action:@selector(jieSuanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.jieSuanBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [self.jieSuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jieSuanBtn.titleLabel.font = SYSTEMFONT(15.0);
    self.jieSuanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tbBack"]];
    [self.tableView setBackgroundView:imageView];
    self.tableView.backgroundView.hidden=YES;
    
}
-(void)headerRereshing{
    [self initData];
    [self.tableView.header endRefreshing];
}
//结算
-(void)jieSuanAction{
    NSLog(@"结算");
    if ([self.isVideo isEqualToString:@"no"]) {
        NSMutableArray *orderInfArray=[NSMutableArray array];
        
        for ( int i =0; i<self.dataArray.count;i++)
        {
            ShoppingModel *model = self.dataArray[i];
            if (model.selectState)
            {
                NSString *jsonstr=[NSString stringWithFormat:@"{\"shopCarId\":%@,\"goodsNum\":%@}",model.shopCarId,[NSString stringWithFormat:@"%d",model.goodsNum]];
                [orderInfArray addObject:jsonstr];
            }
            
        }
        NSLog(@"%@",orderInfArray);
        NSString *more;
        if (orderInfArray.count>0) {
            more=@"1";
        }else{
            more=@"0";
        }
        NSString *tempString = [orderInfArray componentsJoinedByString:@","];
        NSLog(@"%@",tempString);
        
        if (orderInfArray.count>0) {
            CustomWebViewController *CV=[[CustomWebViewController alloc]init];
            CV.delegate=self;
            NSString *urlstring=[NSString stringWithFormat:@"%@/api.php/Shop/submitOrder?orderInfo=[%@]&userId=%@&newOrder=1&more=%@&orderType=1",kBaseUrl,tempString,[DEFAULTS objectForKey:@"userId"],more];
            CV.webUrl=[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
            [self.navigationController pushViewController:CV animated:NO];
        }else{
            [self alertSelect];
        }

      
    }else{
        NSMutableArray *orderInfArray=[NSMutableArray array];
        for ( int i =0; i<self.dataArray.count;i++)
        {
            ShoppingVideoModel *model = self.dataArray[i];
            if (model.selectState)
            {
                NSString *jsonstr=[NSString stringWithFormat:@"{\"shopCarId\":%@,\"goodsNum\":1}",model.shopCarId];
                [orderInfArray addObject:jsonstr];            }
        }
        NSLog(@"%@",orderInfArray);
        NSString *more;
        if (orderInfArray.count>0) {
            more=@"1";
        }else{
            more=@"0";
        }
        NSString *tempString = [orderInfArray componentsJoinedByString:@","];
        NSLog(@"%@",tempString);
        if (orderInfArray.count>0) {
            CustomWebViewController *CV=[[CustomWebViewController alloc]init];
            CV.delegate=self;
            NSString *urlstring=[NSString stringWithFormat:@"%@/api.php/Shop/submitOrder?orderInfo=[%@]&userId=%@&newOrder=1&more=%@&orderType=2",kBaseUrl,tempString,[DEFAULTS objectForKey:@"userId"],more];
            CV.webUrl=[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
            [self.navigationController pushViewController:CV animated:NO];
        }else{
            [self alertSelect];
        }


    }
    
   

    
}
-(void)alertSelect{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"结算提醒" message:@"你尚未选择结算商品" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        

    }];
    [alertController addAction:okAction];
 //   [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
//全选
-(void)selectAllaction:(UIButton *)sender{
    
    
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
        
    }
    //改变单元格选中状态
    for (int i=0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        model.selectState = sender.tag;
    }
    
    [self CalculationPrice];
    
    [self.tableView reloadData];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.showsVerticalScrollIndicator = NO;
    static NSString *cellStr = @"ShopCarCell";
    if ([self.isVideo isEqualToString:@"no"]) {
        ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        if(!cell){
            cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.delegate = self;
        cell.indexRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        ShoppingModel *model = self.dataArray[indexPath.row];
        [cell updateWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        ShopppingVideoCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
          tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if(!cell){
            cell = [[ShopppingVideoCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.delegate = self;
        cell.indexRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        ShoppingModel *model = self.dataArray[indexPath.row];
        [cell updateWithModel:model];
       // cell.shoppingModel = self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return kScreen_Width/4+20;
}



//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      /**
     * 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    //    ShoppingModel *model = self.dataArray[indexPath.row];
    //    if (model.selectState)
    //    {
    //        model.selectState = NO;
    //    }
    //    else
    //    {
    //        model.selectState = YES;
    //    }
    //
    //    //刷新当前行
    //    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //    [self CalculationPrice];
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 * 实现加减按钮点击代理事件
 *
 * @param cell 当前单元格
 * @param flag 按钮标识，11 为减按钮，12为加按钮
 */


-(void)MKJTableView:(UITableViewCell *)cell clickButton:(UIButton *)btn{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    ShoppingModel *model = self.dataArray[indexpath.row];
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    
    //刷新当前行
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self CalculationPrice];

}
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            ShoppingModel *model = self.dataArray[index.row];
            model.selectState=YES;
            
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            ShoppingModel *model = self.dataArray[index.row];
            model.selectState=YES;
            model.goodsNum ++;
        }
            break;
        default:
            break;
    }
    //刷新表格
    [self.tableView reloadData];
    //计算总价
    [self CalculationPrice];
}
//计算价格
-(void)CalculationPrice
{
//    if (self.dataArray.count==0) {
//        _totalView.hidden=YES;
//    }
    
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        if (model.selectState)
        {
            self.allPrice = self.allPrice + model.goodsNum *[model.goodsPrice floatValue];
            self.proNum=self.proNum+model.goodsNum;
        }
    }
    
    
    NSMutableAttributedString *numStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共计%d件商品,",self.proNum]];
    [numStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x59c5b7"] range:NSMakeRange(2,numStr.length-6)];
    self.selectedNumLab.frame=CGRectMake(15, 0, [self getWidthWithTitle:[numStr string] font:SYSTEMFONT(13)]+10, 50);
    self.selectedNumLab.attributedText = numStr;
    self.proNum=0;
    
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总需%.2f元",self.allPrice]];
    //[str addAttribute:NSFontAttributeName value:SYSTEMFONT(17) range:NSMakeRange(2,str.length-3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x59c5b7"] range:NSMakeRange(2,str.length-3)];
    
    self.totalMoneyLab.frame=CGRectMake(self.selectedNumLab.frame.size.width+25, 0, [self getWidthWithTitle:[str string] font:SYSTEMFONT(13)]+10, 50);
    self.totalMoneyLab.attributedText = str;
    NSLog(@"%f",self.allPrice);
    
    self.allPrice = 0.00;
    
    
}

  //self.view.backgroundColor = [UIColor whiteColor];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSString *shopCarId;
        if ([self.isVideo isEqualToString:@"no"]){
            ShoppingModel *model=_dataArray[indexPath.row];
            shopCarId=model.shopCarId;
        }else{
            ShoppingVideoModel *model=_dataArray[indexPath.row];
            shopCarId=model.shopCarId;
        }
        [kNetManager deleteShopCar:[DEFAULTS objectForKey:@"userId"] shopCarId:shopCarId Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue]==100) {
                [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
            }
          
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

        [_dataArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self CalculationPrice];
        }];
    return @[deleteRowAction];
}
- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
-(void)shopImgclick:(NSString *)indexRow{
    if ([self.isVideo isEqualToString:@"no"]) {
        CustomWebViewController *CV=[[CustomWebViewController alloc]init];
        ShoppingModel *model= _dataArray[[indexRow integerValue]];
        
        CV.webUrl=[NSString stringWithFormat:@"%@/api.php/Shop/shopDetail?goodsId=%@&userId=%@",kBaseUrl,model.goodsId,[DEFAULTS objectForKey:@"userId"]];
        
        [self.navigationController pushViewController:CV animated:NO];
    }else{

        ShoppingVideoModel *model= _dataArray[[indexRow integerValue]];
      
        MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
        vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,model.goodId,[DEFAULTS objectForKey:@"userId"]];
        vc.classId=model.goodId;
                
        [self.navigationController pushViewController:vc animated:NO];
    }

}
-(void)payFinish{
    [self.dataArray removeAllObjects];
    [self initData];
    for (ShoppingModel *model in _dataArray) {
        model.selectState=NO;
    }
      [self CalculationPrice];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.totalView.hidden=YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [self initData];
    
    [super viewWillAppear:animated];
    self.totalView.hidden=NO;
}
@end
