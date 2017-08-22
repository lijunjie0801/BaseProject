//
//  MessageViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/14.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MessageViewController.h"
#import "MsgCell.h"
#import "MsgModel.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong)NSArray *msgarray;
@property(nonatomic,strong)NSMutableArray *homeArray;
@end

@implementation MessageViewController
-(NSMutableArray *)homeArray{
    if (!_homeArray) {
        _homeArray = [NSMutableArray array];
    }
    return _homeArray;
}
-(NSArray *)msgarray{
    if (!_msgarray) {
        _msgarray = [NSArray array];
    }
    return _msgarray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
    navigationBar.tintColor = [UIColor whiteColor];;
    //创建UINavigationItem
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"消息"];
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];
    //创建UIBarButton 可根据需要选择适合自己的样式
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
    navigationBarTitle.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    
    UIView *topsepView=[[UIView alloc]initWithFrame:CGRectMake(0, 63, kScreen_Width, 0.5)];
    topsepView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:topsepView];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];

}
-(void)viewWillAppear:(BOOL)animated{
    [self isNewMsg];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgcell"];
//    NSArray *titilearray;
    if(!cell){
        cell = [[MsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"msgcell"];
    }
    MsgModel *model=_homeArray[indexPath.row];
    [cell updataWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _homeArray.count;
}
-(void)isNewMsg{
    [kNetManager isNewMessage:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"消息信息：%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            
            NSArray *array=responseObject[@"datas"][@"newMessage"];
            NSLog(@"消息信息111：%@",array);
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in array) {
                MsgModel *model = [[MsgModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            _homeArray=[homeModelArray mutableCopy];
             NSLog(@"消息信息222：%@",_homeArray);
           [self.tableView reloadData];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {

    }];
}-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgModel *model=_homeArray[indexPath.row];
        [kNetManager changeNewsAct:[DEFAULTS objectForKey:@"userId"] newsType:model.title Success:^(id responseObject) {
            if ([responseObject[@"status"] integerValue]==100) {
                
            }else{
                [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
            }
        } Failure:^(NSError *error) {
            
        }];
    CustomeWebViewNoNavController *CV=[[CustomeWebViewNoNavController alloc]init];
    CV.webUrl=[NSString stringWithFormat:@"http://hongpei.zilankeji.com/api.php/userCenter/%@?userId=%@",model.title,[DEFAULTS objectForKey:@"userId"]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:CV];
    
    [self presentViewController:nav_third animated:NO completion:nil ];

  }

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_backBtn addTarget:self action:@selector(webGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)webGoBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
