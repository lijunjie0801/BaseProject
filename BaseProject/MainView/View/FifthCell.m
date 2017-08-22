//
//  FifthCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/11.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FifthCell.h"

@implementation FifthCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageCount:(NSInteger)imageCount{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        _topView.userInteractionEnabled=YES;
        [self.contentView addSubview:_topView];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/2.5)];
        _backGroundView=image;
        image.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBackImg:)];
        singleTaps.numberOfTapsRequired = 1;
        [image addGestureRecognizer:singleTaps];

        image.image=[UIImage imageNamed:@"mebackground"];
        [_topView addSubview:image];
        
        UIImageView *imagewhit=[[UIImageView alloc]init];
        imagewhit.center=CGPointMake(kScreen_Width/2, kScreen_Width/2.5);
        imagewhit.bounds=(CGRect){
            CGPointZero,CGSizeMake(90, 90)
        };
        imagewhit.backgroundColor=[UIColor whiteColor];
        imagewhit.clipsToBounds=YES;
        imagewhit.layer.cornerRadius=45;
        [_topView addSubview:imagewhit];
        
        UIImageView *iconimage=[[UIImageView alloc]init];
        iconimage.center=CGPointMake(kScreen_Width/2, kScreen_Width/2.5);
        iconimage.bounds=(CGRect){
            CGPointZero,CGSizeMake(86, 86)
        };
        iconimage.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [iconimage addGestureRecognizer:singleTap];
        _iconView=iconimage;
        iconimage.image=[UIImage imageNamed:@"defaultIcon"];
        iconimage.clipsToBounds=YES;
        iconimage.layer.cornerRadius=43;
        [_topView addSubview:iconimage];
        
        UILabel *nickNameTitle=[[UILabel alloc]init];
        nickNameTitle.text=@"昵称";
        nickNameTitle.textColor=[UIColor lightGrayColor];
        [_topView addSubview:nickNameTitle];
        [nickNameTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [nickNameTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imagewhit withOffset:20];
        [nickNameTitle autoSetDimensionsToSize:CGSizeMake(60, 20)];
        
        UITextField *nickNameContent=[[UITextField alloc]init];
        _nickNameContent=nickNameContent;
        nickNameContent.userInteractionEnabled=NO;
       // nickNameContent.text=_userName;
        nickNameContent.font=[UIFont systemFontOfSize:15];
        [_topView addSubview:nickNameContent];
        [nickNameContent autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:nickNameTitle withOffset:10];
        [nickNameContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imagewhit withOffset:20];
        [nickNameContent autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:65];
        [nickNameContent autoSetDimension:ALDimensionHeight toSize:20];
        
        UIButton *changeNameBtn=[[UIButton alloc]init];
        _changeNameBtn=changeNameBtn;
        changeNameBtn.selected=NO;
     //   [changeNameBtn setTitle:@"修改" forState:UIControlStateNormal];
        [changeNameBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        [changeNameBtn addTarget:self action:@selector(changeclick:) forControlEvents:UIControlEventTouchUpInside];
        [changeNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        changeNameBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_topView addSubview:changeNameBtn];
        [changeNameBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:nickNameContent withOffset:10];
        [changeNameBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imagewhit withOffset:20];
        [changeNameBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [changeNameBtn autoSetDimension:ALDimensionHeight toSize:20];
        
        
        UIView *firstLine=[[UIView alloc]init];
        firstLine.backgroundColor=RGB(241, 241, 241);
        [_topView addSubview:firstLine];
        [firstLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nickNameContent withOffset:10];
        [firstLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [firstLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [firstLine autoSetDimension:ALDimensionHeight toSize:1];
        
        UILabel *phoneNumTitle=[[UILabel alloc]init];
        phoneNumTitle.text=@"手机号";
        phoneNumTitle.textColor=[UIColor lightGrayColor];
        [_topView addSubview:phoneNumTitle];
        [phoneNumTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [phoneNumTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstLine withOffset:10];
        [phoneNumTitle autoSetDimensionsToSize:CGSizeMake(60, 20)];
        
        UILabel *phoneNumContent=[[UILabel alloc]init];
        _phoneNumContent=phoneNumContent;
        phoneNumContent.font=[UIFont systemFontOfSize:15];
        [_topView addSubview:phoneNumContent];
        [phoneNumContent autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:phoneNumTitle withOffset:10];
        [phoneNumContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstLine withOffset:10];
        [phoneNumContent autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [phoneNumContent autoSetDimension:ALDimensionHeight toSize:20];
        
        UIView *secondLine=[[UIView alloc]init];
        secondLine.backgroundColor=RGB(241, 241, 241);
        [_topView addSubview:secondLine];
        [secondLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumContent withOffset:10];
        [secondLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [secondLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [secondLine autoSetDimension:ALDimensionHeight toSize:1];
        
        
        UIView *myCollectionView=[[UIButton alloc]init];
        [_topView addSubview:myCollectionView];
        [myCollectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:secondLine withOffset:10];
        [myCollectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [myCollectionView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [myCollectionView autoSetDimension:ALDimensionHeight toSize:20];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectClick)];
        UIView *singleTapView = [tap view];
        [myCollectionView addGestureRecognizer:tap];
        
        UILabel *myCollectionLabel=[[UILabel alloc]init];
        myCollectionLabel.text=@"我的收藏";
        myCollectionLabel.font=[UIFont systemFontOfSize:15];
        [myCollectionView addSubview:myCollectionLabel];
        [myCollectionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [myCollectionLabel  autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [myCollectionLabel autoSetDimensionsToSize:CGSizeMake(100, 20)];
        
        UILabel *myCollectionArrow=[[UILabel alloc]init];
        myCollectionArrow.text=@">";
        myCollectionArrow.textColor=[UIColor lightGrayColor];
        myCollectionArrow.font=[UIFont systemFontOfSize:15];
        [myCollectionView addSubview:myCollectionArrow];
        [myCollectionArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [myCollectionArrow  autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [myCollectionArrow autoSetDimensionsToSize:CGSizeMake(20, 20)];
        
        UIView *fourthLine=[[UIView alloc]init];
        fourthLine.backgroundColor=RGB(241, 241, 241);
        [_topView addSubview:fourthLine];
        [fourthLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:myCollectionView withOffset:10];
        [fourthLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [fourthLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [fourthLine autoSetDimension:ALDimensionHeight toSize:1];
        
        UILabel *myOrderLabel=[[UILabel alloc]init];
        myOrderLabel.text=@"我的订单";
        myOrderLabel.font=[UIFont systemFontOfSize:15];
        [_topView addSubview:myOrderLabel];
        [myOrderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [myOrderLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:fourthLine withOffset:10];
        [myOrderLabel autoSetDimensionsToSize:CGSizeMake(100, 20)];
        
        
        UIButton *moreBtn=[[UIButton alloc]init];
        [moreBtn setTitle:@"查看全部>" forState:UIControlStateNormal];
        moreBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [moreBtn addTarget:self action:@selector(moreOrder) forControlEvents:UIControlEventTouchUpInside];
        [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_topView addSubview:moreBtn];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [moreBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:fourthLine withOffset:10];
        [moreBtn autoSetDimensionsToSize:CGSizeMake(100, 20)];
        
        CGFloat space=(kScreen_Width-60*3-50)/2;
        NSArray *waitArray=@[@"waitpay",@"waitreceived",@"waitsend"];
        NSArray *waitlabelArray=@[@"待付款",@"待发货",@"待收货"];
        for (int i=0; i<waitArray.count; i++) {
            UIButton *waitBtn=[[UIButton alloc]init];
            waitBtn.tag=i;
            [_topView addSubview:waitBtn];
            [waitBtn setBackgroundImage:[UIImage imageNamed:waitArray[i]] forState:UIControlStateNormal];
            [waitBtn addTarget:self action:@selector(waitClick:) forControlEvents:UIControlEventTouchUpInside];
            [waitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25+(60+space)*i];
            [waitBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:myOrderLabel withOffset:15];
            [waitBtn autoSetDimensionsToSize:CGSizeMake(60, 60/1.4)];
            
            UILabel *waitLabel=[[UILabel alloc]init];
            [_topView addSubview:waitLabel];
            waitLabel.text=waitlabelArray[i];
            waitLabel.textAlignment=UITextAlignmentCenter;
            waitLabel.font=[UIFont systemFontOfSize:15];
            [waitLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25+(60+space)*i];
            [waitLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:myOrderLabel withOffset:60/1.4+15];
            [waitLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
            
            UILabel *label = [[UILabel alloc] init];
            label.tag=500+i;
              [_topView addSubview:label];
            label.text=@"1";
            label.textAlignment=NSTextAlignmentCenter;
            label.textColor=[UIColor colorWithHexString:@"0x59c5b7"];
            label.clipsToBounds = YES;
            label.layer.borderWidth  = 1.5f;
            label.layer.borderColor  = [RGB(159, 208, 199) CGColor];  ;
            label.layer.cornerRadius = 10.0f;
            [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:70+(60+space)*i];
            [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:myOrderLabel withOffset:15];
            [label autoSetDimensionsToSize:CGSizeMake(20, 20)];
            
        }
        UIView *leftLine = [[UIView alloc]init];
        [leftLine setBackgroundColor:[UIColor grayColor]];
        [_topView addSubview:leftLine];
        [leftLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [leftLine autoSetDimensionsToSize:CGSizeMake(100, 1)];
        [leftLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:moreBtn withOffset:120];
        
        UIView *rightLine = [[UIView alloc]init];
        [rightLine setBackgroundColor:[UIColor grayColor]];
        [_topView addSubview:rightLine];
        [rightLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [rightLine autoSetDimensionsToSize:CGSizeMake(100, 1)];
        [rightLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:moreBtn withOffset:120];
        
        UILabel *ThirdLabel=[[UILabel alloc]init];
        ThirdLabel.text=@"猜您喜欢";
        [_topView addSubview:ThirdLabel];
        ThirdLabel.textColor=[UIColor grayColor];
        ThirdLabel.textAlignment=UITextAlignmentCenter;
        [ThirdLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftLine withOffset:0];
        [ThirdLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:rightLine withOffset:0];
        [ThirdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:moreBtn withOffset:110];
        [ThirdLabel autoSetDimension:ALDimensionHeight toSize:21];
        
    }
    return self;
}
-(void)updataWithDic:(NSDictionary *)dic{
    _nickNameContent.text=dic[@"userName"];
    _phoneNumContent.text=dic[@"phoneNum"];
    [_backGroundView sd_setImageWithURL:dic[@"backimgString"]];
     [_iconView sd_setImageWithURL:dic[@"userImg"]];
    NSArray *array=dic[@"guessArray"];
    for (int i=0; i<array.count; i++) {
        UIButton *imgBtn=[self viewWithTag:100+i];
        [imgBtn sd_setImageWithURL:[NSURL URLWithString:array[i][@"goodsImg"]] forState:UIControlStateNormal];
        UILabel *nameLabel=[self viewWithTag:200+i];
        nameLabel.text=array[i][@"goodsName"];
        
        UILabel *priceLabel=[self viewWithTag:300+i];
        priceLabel.text=array[i][@"goodsShowPrice"];
    }

    for (int i=0; i<3; i++) {
        UILabel *label=[self viewWithTag:500+i];
        label.font=[UIFont systemFontOfSize:12];
        
        if (i==0) {
            label.text=dic[@"dfkNum"];
            if ([dic[@"dfkNum"] isEqualToString:@"0"]) {
                label.hidden=YES;
            }
        }else if (i==1){
             label.text=dic[@"dfhNum"];
            if ([dic[@"dfhNum"] isEqualToString:@"0"]) {
                label.hidden=YES;
            }

        }else{
             label.text=dic[@"dshNum"];
            if ([dic[@"dshNum"] isEqualToString:@"0"]) {
                label.hidden=YES;
            }
        }
        
    }
  
}
-(void)moreOrder{
    if ([self.delegate respondsToSelector:@selector(clickMyOrders)]) {
        [self.delegate clickMyOrders];
    }
}
-(void)collectClick{
    if ([self.delegate respondsToSelector:@selector(clickMyCollection)]) {
        [self.delegate clickMyCollection];
    }
}
-(void)changeclick:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(changeName:)]){                                            
    [self.delegate changeName:sender];
    }
}
-(void)waitClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(orderClick:)]) {
        [self.delegate orderClick:sender];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)singleTap:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(changeIcon)]) {
        [self.delegate changeIcon];
    }

}
- (void)changeBackImg:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(changeBackGround)]) {
        [self.delegate changeBackGround];
    }
    
}

@end
