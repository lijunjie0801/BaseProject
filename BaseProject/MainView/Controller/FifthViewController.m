//
//  FifthViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/26.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FifthViewController.h"
#import "CustomWebViewController.h"
#import "FifthCell.h"
#import "SettingViewController.h"
#import "MessageViewController.h"
#import "XDAlertController.h"
#import "MsgModel.h"
#import "LDImagePicker.h"
@interface FifthViewController ()<UITableViewDelegate,UITableViewDataSource,fifthDelegate,UITextFieldDelegate,LDImagePickerDelegate>{
    NSInteger _count;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *messageBtn;
@property(nonatomic,strong)UIButton *settingBtn;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *phoneNum;
@property(nonatomic,strong)NSString *isTeacher;
@property(nonatomic,strong)NSArray *guessArray;
@property(nonatomic,strong)UITextField *nickNameContent;
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UIImageView *backGroundView;
@property(nonatomic,strong)UIButton *changeNameBtn;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)NSDictionary *dictionary;
@property(nonatomic,strong)NSString *classNews;
@property(nonatomic,strong)NSString *studentNews;
@property(nonatomic,strong)NSString *recComment;
@property(nonatomic,strong)NSString *goodsNews;
@property(nonatomic,strong)UIView *pointView;
//@property(nonatomic,strong)UIImagePickerController *imagePicke1;
//@property(nonatomic,strong)UIImagePickerController *imagePicke2;

@end

@implementation FifthViewController
-(NSMutableDictionary *)dic{
    if (!_dic) {
        _dic=[NSMutableDictionary dictionary];
    }
    return _dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserData];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.separatorStyle = NO;
    _tableView.delegate=self;
    _tableView.dataSource=self;
     [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    self.tableView.header.stateHidden=YES;
    self.tableView.header.updatedTimeHidden=YES;
    self.view = _tableView;
  
    
}
-(void)setbottom{
    UIView *bview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    _tableView.tableFooterView=bview;
    
    CGFloat likeBtnWidth=(kScreen_Width-40-30)/3;
    NSArray *array=_dictionary[@"guessArray"];
    for (int i=0; i<array.count; i++) {
        UIButton *likeBtn=[[UIButton alloc]init];
        likeBtn.tag=i;
        [likeBtn addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
        [bview addSubview:likeBtn];
        [likeBtn sd_setImageWithURL:[NSURL URLWithString:array[i][@"goodsImg"]] forState:UIControlStateNormal];
        [likeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15+(likeBtnWidth+20)*i];
        [likeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [likeBtn autoSetDimensionsToSize:CGSizeMake(likeBtnWidth, likeBtnWidth)];
        
        UILabel *proLabel=[[UILabel alloc]init];
        proLabel.text=array[i][@"goodsName"];
        [bview addSubview:proLabel];
        proLabel.font=[UIFont systemFontOfSize:15];
        proLabel.textColor=[UIColor colorWithHexString:@"0x555555"];
        [proLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15+(likeBtnWidth+20)*i];
        [proLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10+likeBtnWidth];
        [proLabel autoSetDimensionsToSize:CGSizeMake(likeBtnWidth, 20)];
        
        UILabel *priceLabel=[[UILabel alloc]init];
        priceLabel.text=array[i][@"goodsShowPrice"];
        priceLabel.tag=300+i;
        [bview addSubview:priceLabel];
        priceLabel.textColor=[UIColor colorWithHexString:@"0x555555"];
        priceLabel.font=[UIFont systemFontOfSize:15];
        [priceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15+(likeBtnWidth+20)*i];
        [priceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30+likeBtnWidth];
        [priceLabel autoSetDimensionsToSize:CGSizeMake(likeBtnWidth, 20)];
    }

}
- (void)headerRereshing{
    [self getUserData];
    [self isNewMsg];
    [self.tableView headerEndRefreshing];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    NSArray *array=_dictionary[@"guessArray"];
    FifthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[FifthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" imageCount:array.count];
    }
    cell.delegate=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [cell updataWithDic:_dictionary];
    _nickNameContent=cell.nickNameContent;
    _nickNameContent.delegate=self;
    _iconView=cell.iconView;
    _backGroundView=cell.backGroundView;
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Width/2.5+340;
}

-(void)getUserData{
     NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }
    [kNetManager getUserIndexData:user_id Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSLog(@"个人信息:%@",responseObject);
            _userName=responseObject[@"datas"][@"userIndex"][@"userInfo"][@"username"];
            _phoneNum=responseObject[@"datas"][@"userIndex"][@"userInfo"][@"mobile"];
            _isTeacher=responseObject[@"datas"][@"userIndex"][@"userInfo"][@"isTeacher"];
            _guessArray=responseObject[@"datas"][@"userIndex"][@"guessYouLike"];
            NSString *iconstring=responseObject[@"datas"][@"userIndex"][@"userInfo"][@"userImg"];
            NSString *backimgString=responseObject[@"datas"][@"userIndex"][@"userInfo"][@"backgroundImg"];
            NSString *dfhNumstring=responseObject[@"datas"][@"userIndex"][@"orderNum"][@"dfhNum"];
            NSString *dshNumstring=responseObject[@"datas"][@"userIndex"][@"orderNum"][@"dshNum"];
            NSString *dfkNumstring=responseObject[@"datas"][@"userIndex"][@"orderNum"][@"dfkNum"];
            _dictionary =@{
                           @"userName":_userName,
                           @"phoneNum":_phoneNum,
                           @"userImg":iconstring,
                           @"guessArray":_guessArray,
                           @"dfhNum":dfhNumstring,
                           @"dshNum":dshNumstring,
                           @"dfkNum":dfkNumstring,
                           @"backimgString":backimgString
                           };
            [self setbottom];
            NSLog(@"_dicqqqq:%@",_dictionary);
            [self.tableView reloadData];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {
         NSLog(@"个人信息:%@",error);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    UIButton *messageBtn=[[UIButton alloc]init];
    _messageBtn=messageBtn;
    [messageBtn setImage:[UIImage imageNamed:@"message"]  forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setBackgroundColor:[UIColor whiteColor]];
    messageBtn.frame=CGRectMake(20, 20, 30, 30);
    messageBtn.layer.cornerRadius=15;
    [[[UIApplication sharedApplication ] keyWindow ] addSubview : messageBtn];
    
    UIView *pointView=[[UIView alloc]initWithFrame:CGRectMake(24, 0, 6, 6)];
    pointView.backgroundColor=[UIColor colorWithHexString:@"0x59c5b7"];
    pointView.layer.cornerRadius=3;
    pointView.hidden=YES;
    _pointView=pointView;
    [messageBtn addSubview:pointView];
    
    
    UIButton *setBtn=[[UIButton alloc]init];
    _settingBtn=setBtn;
    [setBtn setImage:[UIImage imageNamed:@"setting"]  forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    //    setBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [setBtn setBackgroundColor:[UIColor whiteColor]];
    setBtn.frame=CGRectMake(kScreen_Width-50, 20, 30, 30);
    setBtn.layer.cornerRadius=15;
    [[[UIApplication sharedApplication ] keyWindow ] addSubview : setBtn];
    
    [self isNewMsg];

}
-(void)changeBackGround{
    _count=1;
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
    imagePicker.delegate = self;
    
    XDAlertController *alert = [XDAlertController alertControllerWithTitle:@"修改背景皮肤" message:nil preferredStyle:XDAlertControllerStyleActionSheet];
    XDAlertAction *action1 = [XDAlertAction actionWithTitle:@"从相册获取" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        [imagePicker showImagePickerWithType:1 InViewController:self Scale:0.4];
    }];
    XDAlertAction *action2 = [XDAlertAction actionWithTitle:@"拍照" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        [imagePicker showImagePickerWithType:0 InViewController:self Scale:0.4];

    }];
    
    XDAlertAction *action3 = [XDAlertAction actionWithTitle:@"取消" style:XDAlertActionStyleCancel handler:^(XDAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    NSData *fileData = UIImageJPEGRepresentation(editedImage, 1.0);
    // 对于base64编码编码
    NSString *headImageString=[fileData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [kNetManager changeBackground:[DEFAULTS objectForKey:@"userId"] Backgroundcode:headImageString Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            NSLog(@"背景%@",responseObject);
//            NSString *Imgstr=responseObject[@"datas"][@"changeBackground"];
            // [_backGroundView sd_setImageWithURL:[NSURL URLWithString:Imgstr]];
            [_backGroundView setImage:editedImage];
        }
        
    } Failure:^(NSError *error) {
        
    }];

}
-(void)viewWillDisappear:(BOOL)animated{
    [_messageBtn removeFromSuperview];
    [_settingBtn removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)likeClick:(UIButton *)sender{
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    NSArray *array=_dictionary[@"guessArray"];
    NSString *goodId=array[sender.tag][@"goodsId"];
    cv.webUrl=[NSString stringWithFormat:@"%@/api.php/Shop/shopDetail?goodsId=%@&userId=%@",kBaseUrl,goodId,[DEFAULTS objectForKey:@"userId"]];
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:cv];
    
    [self presentViewController:cv animated:NO completion:nil ];
}
-(void)clickMyCollection{
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    cv.webUrl=[NSString stringWithFormat:@"%@/api.php/UserCenter/my_collect?userId=%@",kBaseUrl,[DEFAULTS objectForKey:@"userId"]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:cv];
    
    [self presentViewController:nav_third animated:NO completion:nil ];

}
//-(void)viewDidAppear:(BOOL)animated {
//    [self.nickNameContent resignFirstResponder];
//}
-(void)changeName:(UIButton *)sender{
    if (sender.selected==NO) {
        [sender setImage:[UIImage imageNamed:@"baocun"] forState:UIControlStateNormal];
        sender.selected=YES;
        _nickNameContent.userInteractionEnabled=YES;
        [UIView animateWithDuration:0.1 animations:^{} completion:^(BOOL finished) {
            [self.nickNameContent becomeFirstResponder];
        }];
    }else{
        [kNetManager changeUserInfo:[DEFAULTS objectForKey:@"userId"] userName:self.nickNameContent.text Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue]==100) {
                [JRToast showWithText:@"修改成功" duration:1.0];
            }else{
                 [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
            }
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [sender setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        sender.selected=NO;
        _nickNameContent.userInteractionEnabled=NO;
        
    }

}
-(void)setClick{
    SettingViewController *setVC=[[SettingViewController alloc]init];
    setVC.view.backgroundColor=[UIColor whiteColor];
    [self presentViewController:setVC animated:NO completion:nil ];
}
-(void)clickMyOrders{
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    NSString *user_id;
    if (![DEFAULTS objectForKey:@"userId"]) {
        user_id=@"";
    }else{
        user_id=[DEFAULTS objectForKey:@"userId"];
    }

    cv.webUrl=[NSString stringWithFormat:@"%@/api.php/UserCenter/userOrderPage?userId=%@",kBaseUrl,user_id];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:cv];
    
    [self presentViewController:nav_third animated:NO completion:nil ];


}
-(void)orderClick:(UIButton *)sender{
    NSArray *orderNum=@[@"1",@"2",@"3"];
    CustomeWebViewNoNavController *cv=[[CustomeWebViewNoNavController alloc]init];
    cv.webUrl=[NSString stringWithFormat:@"%@/api.php/UserCenter/userOrderPage?userId=%@&orderType=%@",kBaseUrl,[DEFAULTS objectForKey:@"userId"],orderNum[sender.tag]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:cv];
    
    [self presentViewController:nav_third animated:NO completion:nil ];


}
-(void)messageClick{
    MessageViewController *MC=[[MessageViewController alloc]init];
    MC.isTearcher=_isTeacher;

    [self presentViewController:MC animated:NO completion:nil ];
}
-(void)changeIcon{
   
    XDAlertController *alert = [XDAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:XDAlertControllerStyleActionSheet];
    XDAlertAction *action1 = [XDAlertAction actionWithTitle:@"从相册获取" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
    //     _imagePicke2=imagePicker;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    XDAlertAction *action2 = [XDAlertAction actionWithTitle:@"拍照" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    XDAlertAction *action3 = [XDAlertAction actionWithTitle:@"取消" style:XDAlertActionStyleCancel handler:^(XDAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
     //   if (picker==_imagePicke2) {
            [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];

    //    }
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)saveImage:(UIImage *)image {
    NSLog(@"%@",image);
    //_iconView.image=image;
    NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
    // 对于base64编码编码
    NSString *headImageString=[fileData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"base64:%@",headImageString);
        [kNetManager changeUserIcon:[DEFAULTS objectForKey:@"userId"] headcode:headImageString Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue]==100) {
//                NSString *iconstr=responseObject[@"datas"][@"changeHead"];
                NSString *base=responseObject[@"base64"];
                NSLog(@"base64::::::%@",base);
//                [_iconView sd_setImageWithURL:[NSURL URLWithString:iconstr]];
                [_iconView setImage:image];
            }
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

  
    
}
-(void)isNewMsg{
    [kNetManager isNewMessage:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
       NSLog(@"消息信息：%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            
            NSArray *array=responseObject[@"datas"][@"newMessage"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            NSMutableArray *isnews=[NSMutableArray array];
            for (NSDictionary *dic in array) {
                MsgModel *model = [[MsgModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
                [isnews addObject:model.readstatus];
            }
            NSLog(@"isnews:%@",isnews);
            if ([isnews containsObject:@"1"]) {
                self.pointView.hidden=NO;
            }else{
                self.pointView.hidden=YES;
            }
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
    } Failure:^(NSError *error) {
    }];
}
@end
