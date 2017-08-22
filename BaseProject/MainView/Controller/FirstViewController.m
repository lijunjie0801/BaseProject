//
//  FirstViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/17.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FirstViewController.h"
#import "SDCycleScrollView.h"
#import "MyTableViewCell.h"
#import "MyModel.h"
#import "RDVTabBarController.h"
#import "HomeViewCell.h"
#import "HomeModel.h"
#import "HomeCateModel.h"
#import "ClassMdel.h"
#import "VideoDetailViewController.h"
#import "SignUpViewController.h"
#import "UIButton+WebCache.h"
#import "CustomWebViewController.h"
@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,HomeViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *homeDataArray;
@property(nonatomic,strong)UIView *upperView;
@property(nonatomic,strong)NSMutableArray *categoryArray;
@property(nonatomic,strong)NSMutableArray *testArray;
@property(nonatomic,strong)SDCycleScrollView *sdview;
@property(nonatomic,strong)NSMutableArray *bannerstorId;
@end

@implementation FirstViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)bannerstorId{
    if (!_bannerstorId) {
        _bannerstorId=[NSMutableArray array];
    }
    return _bannerstorId;
}
-(NSMutableArray *)categoryArray{
    if (!_categoryArray) {
        _categoryArray=[NSMutableArray array];
    }
    return _categoryArray;
}

-(NSMutableArray *)testArray{
    if (!_testArray) {
        _testArray=[NSMutableArray array];
    }
    return _testArray;
}

-(NSMutableArray *)homeDataArray{
    if (!_homeDataArray) {
        _homeDataArray=[NSMutableArray array];
    }
    return _homeDataArray;
}
- (void)loadView{
    if([DEFAULTS boolForKey:@"isLoginToHome"]==YES){
        [DEFAULTS setBool:NO forKey:@"isLoginToHome"];
    }else{
//        if ([DEFAULTS boolForKey:@"first"]) {
//            [DEFAULTS setBool:YES forKey:@"first"];
//        }else{
            [self setUpperView];
      //  }
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"食空";
      UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 33, 33)];
    btn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    [btn setImage:[UIImage imageNamed:@"shouye_caidan"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];

    UIButton *searchbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 33, 33)];
    searchbtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [searchbtn setImage:[UIImage imageNamed:@"shouye_search"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchbtn];

      _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
     self.view=_tableView;
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.tableView.header.stateHidden=YES;
    self.tableView.header.updatedTimeHidden=YES;
    _tableView.tableHeaderView.frame=CGRectMake(0, 0,kScreen_Width, kScreen_Width/2.3);
    [self getTopData];
    [self getHomeData];
    
    
//    UIView *homeTop=[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.67)
    SDCycleScrollView *scr=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.67) imageNamesGroup:nil];
    _sdview=scr;
    scr.currentPageDotColor=[UIColor redColor];
    scr.pageDotColor=[UIColor whiteColor];
    scr.showPageControl=YES;
    scr.pageDotImage=[UIImage imageNamed:@"circleNormal"];
    scr.currentPageDotImage=[UIImage imageNamed:@"circleSelect"];
    scr.delegate=self;
    //间隔时间
    scr.autoScrollTimeInterval=3;
    _tableView.tableHeaderView=scr;

     [self performSelector:@selector(delayRemoveUpperView) withObject:nil afterDelay:2.5];

  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cellImgClick:) name:@"cellImgClick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moreClick:) name:@"moreClick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(collectClick:) name:@"collectClick" object:nil];
    
  

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
-(void)collectClick:(NSNotification *)noti{
    if ([DEFAULTS boolForKey:@"isLogin"]!=YES) {
        [self alertLogin];
    }else{
        NSString *index=noti.userInfo[@"btnIndex"];
        UITableViewCell *cell=noti.object;
        NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
        HomeCateModel *model=_testArray[indexpath.row];
        NSLog(@"class：%@",model.list[[index integerValue]]);
        NSString *classId=model.list[[index integerValue]][@"classId"];
    
        NSString *user_id;
        if (![DEFAULTS objectForKey:@"userId"]) {
            user_id=@"";
        }else{
            user_id=[DEFAULTS objectForKey:@"userId"];
        }
        [kNetManager class_collect_act:user_id classId:classId Success:^(id responseObject) {//  NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue]==100) {
                NSLog(@"nsgs:%@",responseObject[@"msgs"]);
               // [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
            }
    } Failure:^(NSError *error) {
        NSLog(@"错误信息%@",error);
    }];
    
    }

}
-(void)cellImgClick:(NSNotification *)noti{
    if ([DEFAULTS boolForKey:@"isLogin"]!=YES) {
        [self alertLogin];
    }else{
        NSString *index=noti.userInfo[@"btnIndex"];
        UITableViewCell *cell=noti.object;
        NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
        HomeCateModel *model=_testArray[indexpath.row];
        NSString *classId=model.list[[index integerValue]][@"classId"];
        MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
        vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,classId,[DEFAULTS objectForKey:@"userId"]];

        vc.classId=classId;
        [self.navigationController pushViewController:vc animated:NO];    }
}
-(void)moreClick:(NSNotification *)noti{
    UITableViewCell *cell=noti.object;
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    NSLog(@"第%ld个more",(long)indexpath.row);
    [DEFAULTS setObject:[NSString stringWithFormat:@"%ld",(long)indexpath.row] forKey:@"selindex"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toSencondCtr" object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%ld",(long)indexpath.row]}];

}
-(void)getHomeData{
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
    [kNetManager getHomeData:user_id Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *dataarray=responseObject[@"datas"][@"class_index"];

            NSMutableArray *muAarray=[NSMutableArray array];
            for (NSDictionary *dict in dataarray) {
                HomeCateModel *model = [[HomeCateModel alloc] initWithCarDict:dict];
                [muAarray addObject:model];
                
            }
            _testArray=[muAarray mutableCopy];
            [self.tableView reloadData];
            
        }
    } Failure:^(NSError *error) {
        NSLog(@"错误信息%@",error);
    }];

}
//-(void)getCateData{
//    [[HttpManagerPort sharedHttpManagerPort]getCategory:^(id responseObject) {
//        NSLog(@"分类%@",responseObject);
//        NSArray *arr=responseObject[@"datas"][@"category"];
//        NSLog(@"分类列表%@",_categoryArray);
//        NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//        NSString *documents = [array lastObject];
//        NSString *documentPath = [documents stringByAppendingPathComponent:@"arrayXML.xml"];
//        NSRange range = NSMakeRange(1, arr.count-1);
//        NSArray *array1 = [arr subarrayWithRange:range];
//        _categoryArray = [array1 mutableCopy];
//        //第五步：将数组存入到指定的本地文件
//        [arr writeToFile:documentPath atomically:YES];
//        //第六步：可对已经存储的数组进行查询等操作
////        NSArray *resultArray = [NSArray arrayWithContentsOfFile:documentPath];
////        NSLog(@"%@", documentPath);
//        [self setUpperView];
//    } Failure:^(NSError *error) {
//        
//    }];
//
//}
-(void)leftBarClick{
    [self setUpperView];
}

-(void)delayRemoveUpperView{
    [UIView animateWithDuration:2.0f animations:^{
        self.upperView.transform = CGAffineTransformMakeTranslation(-kScreen_Width,0);
        
    } completion:^(BOOL finished) {
        [self.upperView removeFromSuperview];
    }];

}
-(void)removeUpperView{
    [self.upperView removeFromSuperview];
}
-(void)firstsearch{
    [self.upperView removeFromSuperview];
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    cv.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/classSearchH5",kBaseUrl] ;
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:cv];
    
    [self presentViewController:nav_third animated:NO completion:nil ];
}

- (void)headerRereshing{
    [self getHomeData];
    [self getTopData];
    [self.tableView.header endRefreshing];
    
}
//- (void)footerRereshing {
//    [self.tableView addLegendFooterWithRefreshingBlock:^{
////        _count += 20;
////        [self getdata];
//        [self.tableView footerEndRefreshing];
//    }];
//    
//}

-(void)setUpperView{
    CGFloat imageWidth=(kScreen_Width-60)/2;
    UIView *upperView=[[UIView alloc]initWithFrame: CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
     //upperView.contentSize = CGSizeMake(320, 460*10);
    self.upperView=upperView;
    [self.rdv_tabBarController.view addSubview:upperView];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
      effectView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    [upperView addSubview:effectView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    scrollView.delegate = self;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(0, (imageWidth+20)*4);
    [effectView addSubview:scrollView];
    UIButton *removeBtn=[[UIButton alloc]init];
    [removeBtn setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
    [upperView addSubview:removeBtn];
    [removeBtn autoSetDimensionsToSize:CGSizeMake(35, 35)];
    [removeBtn addTarget:self action:@selector(removeUpperView) forControlEvents:UIControlEventTouchUpInside];
    [removeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [removeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:25];

    UIButton *searchBtn=[[UIButton alloc]init];
    [searchBtn setImage:[UIImage imageNamed:@"firstSearch"] forState:UIControlStateNormal];
    [upperView addSubview:searchBtn];
    [searchBtn autoSetDimensionsToSize:CGSizeMake(35, 35)];
    [searchBtn addTarget:self action:@selector(firstsearch) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [searchBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:25];

    UILabel *label=[[UILabel alloc]init];
    label.text=@"食空";
    label.font=[UIFont systemFontOfSize:20];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=UITextAlignmentCenter;
    [effectView addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [label autoSetDimension:ALDimensionHeight toSize:25];
    
    NSArray *array =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documents = [array lastObject];
    NSString *documentPath = [documents stringByAppendingPathComponent:@"arrayXML.xml"];
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:documentPath];
    NSLog(@"%@", resultArray);
    NSMutableArray *titleArray=[NSMutableArray array];
    NSMutableArray *classCateIdArray=[NSMutableArray array];
     NSMutableArray *imageArray=[NSMutableArray array];
 
    for (int i=1; i<resultArray.count; i++) {
        [titleArray addObject:resultArray[i][@"classCateName"]];
        [classCateIdArray addObject:resultArray[i][@"classCateId"]];
       [imageArray addObject:resultArray[i][@"classCateImg"]];
    }
       _categoryArray=[titleArray copy];
   NSLog(@"分类标题数组%@",titleArray);

    for (int i=0; i<titleArray.count; i++) {
        UIButton *imagebtn=[[UIButton alloc]init];
        imagebtn.tag=i;
        [imagebtn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
          if (i!=titleArray.count) {
              [imagebtn sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] forState:UIControlStateNormal placeholderImage:nil];
          }else{
              NSString *str=[NSString stringWithFormat:@"%@/upload/apply/woyaobaoming.png",kBaseUrl];
              [imagebtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
          }
        [scrollView addSubview:imagebtn];
        [imagebtn autoSetDimensionsToSize:CGSizeMake(imageWidth, imageWidth)];
        [imagebtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:i%2*imageWidth+(i%2+1)*20];
       [imagebtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100+(i/2)*(imageWidth+20) ];
        
        UILabel *btnName=[[UILabel alloc]initWithFrame:CGRectMake(0, (imageWidth-20)/2, imageWidth, 20)];
        btnName.textAlignment=UITextAlignmentCenter;
        btnName.textColor=[UIColor whiteColor];
        btnName.text=titleArray[i];
        [imagebtn addSubview:btnName];
    }
    
    

    
    
    
}
-(void)imageClick:(UIButton *)sender{
    [self.upperView removeFromSuperview];
    NSString *index=[NSString stringWithFormat:@"%ld",sender.tag+1];
    if (sender.tag!=_categoryArray.count) {
        [DEFAULTS setObject:index forKey:@"selindex"];
        NSLog(@"点击的是第张%@图",[DEFAULTS valueForKey:@"selindex"]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"toSencondCtr" object:nil userInfo:@{@"index":index}];
    }else{
        SignUpViewController *SV=[[SignUpViewController alloc]init];
        [self.navigationController pushViewController:SV animated:NO];
    }
    
}
-(void)getTopData{
     [kNetManager getHomeBannelData:^(id responseObject) {
         NSLog(@"banner data%@",responseObject);
         if ([responseObject[@"status"] integerValue]==100) {
             NSArray *listArray=responseObject[@"datas"][@"class_indexbanner"][@"list"];
             NSMutableArray *bannerArray=[NSMutableArray array];
             NSMutableArray *bannerIdArray=[NSMutableArray array];
             for (NSDictionary *dic in listArray) {
                 [bannerArray addObject:dic[@"bannerImg"]];
                 [bannerIdArray addObject:dic[@"bannerstorId"]];
             }
             _bannerstorId = [bannerIdArray mutableCopy];
             _sdview.imageURLStringsGroup=bannerArray;
         }else{
              [JRToast showWithText:responseObject[@"msgs"] duration:1.0f];
         }
     } Failure:^(NSError *error) {
         NSLog(@"banner error%@",error);
     }];


}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%@",_bannerstorId[index]);
    MoviePlayerViewController *vc=[[MoviePlayerViewController alloc]init];
    vc.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/class_info_h5?classId=%@&userId=%@",kBaseUrl,_bannerstorId[index],[DEFAULTS objectForKey:@"userId"]];
    vc.classId=_bannerstorId[index];
    [self.navigationController pushViewController:vc animated:NO];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.showsVerticalScrollIndicator = NO;
    HomeCateModel *model = self.testArray[indexPath.row];
    
    NSString *identifier = [NSString stringWithFormat:@"TimeLineCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =  [[HomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier imageCount:model.list.count];
    }
    
    if (indexPath.row==0) {
        model.bei=@"1";
        model.placeholderImage=@"myloadingA.gif";
    }else{
        model.bei=@"1.5";
        model.placeholderImage=@"myloadingB.gif";
    }
    cell.indexRow=[NSString stringWithFormat:@"%ld",indexPath.row];
    cell.delegate=self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.titleLabel.text=model.title;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
 
    
    
    __weak HomeCateModel *weakHomeCateModel = model;
    [cell setSelectBtnChange:^(NSString *isSelect,NSString *indexrow){
        
        if ([isSelect isEqualToString:@"0"]) {
            NSDictionary *dic =  [NSDictionary dictionary];
            NSArray *array = weakHomeCateModel.list;
            dic = array[[indexrow integerValue]];
            
            NSDictionary *dic2 = [dic mutableCopy];
            [dic2 setValue:@"1" forKey:@"isSave"];
            
            dic = dic2;
            
            NSMutableArray *arr=[NSMutableArray array];
            arr=[array mutableCopy];
            arr[[indexrow integerValue]]=dic2;
            weakHomeCateModel.list=arr;
            
        }else{
            NSDictionary *dic =  [NSDictionary dictionary];
            NSArray *array = weakHomeCateModel.list;
            dic = array[[indexrow integerValue]];
            
            NSDictionary *dic2 = [dic mutableCopy];
            [dic2 setValue:@"0" forKey:@"isSave"];
            
            dic = dic2;
            
            NSMutableArray *arr=[NSMutableArray array];
            arr=[array mutableCopy];
            arr[[indexrow integerValue]]=dic2;
            weakHomeCateModel.list=arr;
            
            
            
        }}];
    
//    [cell updataWithModel:model];
    cell.homeCateModel = model;
    
    
    
    HomeCateModel *model1 = self.testArray[0];
    
 //   NSArray *array = model1.list[0];

    
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  //  NSLog(@"几行%ld",self.testArray.count);
    return self.testArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (kScreen_Width-50)/2+138;
   }else{
       return (kScreen_Width-50)/2*1.5+145;//(kScreen_Width-60)/2+180;
}

}
-(void)saveAction:(NSString *)indexrow :(UIButton *)sender{
    if ([DEFAULTS boolForKey:@"isLogin"]!=YES) {
        [self alertLogin];
    }else{
        HomeCateModel *model=_testArray[[indexrow integerValue]];
        NSLog(@"class：%@",model.list[sender.tag-700]);
        NSInteger index=sender.tag-700;
        NSString *classId=model.list[index][@"classId"];
       
        NSString *user_id;
        if (![DEFAULTS objectForKey:@"userId"]) {
            user_id=@"";
        }else{
            user_id=[DEFAULTS objectForKey:@"userId"];
        }
        [kNetManager class_collect_act:user_id classId:classId Success:^(id responseObject) {
            if ([responseObject[@"status"] integerValue]==100) {
                if (sender.selected==YES) {

                    sender.selected=NO;
                    [sender setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
                }else{
                    sender.selected=YES;
                    [sender setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                }
                
                [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
            }
        } Failure:^(NSError *error) {
            NSLog(@"错误信息%@",error);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)rightBarClick{
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    cv.webUrl=[NSString stringWithFormat:@"%@/api.php/teach/classSearchH5",kBaseUrl] ;
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:cv];
    
    [self presentViewController:nav_third animated:NO completion:nil ];
 //[self.navigationController pushViewController:cv animated:NO];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [self.rdv_tabBarController setTabBarHidden:NO];
//}
@end
