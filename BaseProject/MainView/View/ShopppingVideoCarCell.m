//
//  ShopppingVideoCarCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/27.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ShopppingVideoCarCell.h"

@implementation ShopppingVideoCarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
     CGFloat imgWidth=kScreen_Width/4;
    UIView *cellBackground=[[UIView alloc]init];
    cellBackground.backgroundColor=[UIColor colorWithHexString:@"#f7f7f7"];
    [self addSubview:cellBackground];
    [cellBackground autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [cellBackground autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [cellBackground autoSetDimensionsToSize:CGSizeMake(kScreen_Width, imgWidth)];
    
    self.checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (100-20)/2, 20, 20)];
    self.checkImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectbtnClick:)];
    [self.checkImg addGestureRecognizer:tap];
    [cellBackground addSubview:self.checkImg];
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkImg.right+10,0, imgWidth, imgWidth)];
      self.shopImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage)];
    [self.shopImageView addGestureRecognizer:singleTap];
    [cellBackground addSubview:self.shopImageView];
    
    
    UIImageView *playView=[[UIImageView alloc]initWithFrame:CGRectMake(75/2, 75/2, 25, 25)];
    playView.image=[UIImage imageNamed:@"play"];
    [self.shopImageView addSubview:playView];
    
    
    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,0,kScreen_Width-imgWidth-50,imgWidth/3)];
    self.shopNameLab.text = @"合生元金装3段1-3岁";
    self.shopNameLab.numberOfLines = 0;
    self.shopNameLab.font = SYSTEMFONT(15);
    [cellBackground addSubview:self.shopNameLab];
    
//    
    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,imgWidth/3*2,100, imgWidth/3)];
    self.priceLab=priceLab;
    priceLab.textColor=[UIColor colorWithHexString:@"0x59c5b7"];
    priceLab.text = @"总价:¥10.00";
    priceLab.font = SYSTEMFONT(15);
    [cellBackground addSubview:priceLab];
    
    
//    self.addNumberView = [[AddNumberView alloc]initWithFrame:CGRectMake(self.priceLab.right+10, self.shopTypeLab.bottom+5, 93, 22)];
//    self.addNumberView.delegate = self;
//    self.addNumberView.backgroundColor = [UIColor clearColor];
//    [cellBackground addSubview:self.addNumberView];
    
}
-(void)selectbtnClick:(UIButton *)sender{
    
    [self.delegate MKJTableView:self clickButton:sender];
    
}
/**
 * 点击减按钮数量的减少
 *
 * @param sender 减按钮
 */
- (void)deleteBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"减按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == NO)
    {
        self.selectState=YES;
        
    }
    [self.delegate btnClick:self andFlag:(int)sender.tag];

    
    
}
/**
 * 点击加按钮数量的增加
 *
 * @param sender 加按钮
 */
- (void)addBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"加按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == NO)
    {
        self.selectState=YES;
        
    }
    [self.delegate btnClick:self andFlag:(int)sender.tag];
    
}




-(void)updateWithModel:(ShoppingModel *)model{
    self.shopNameLab.text = model.goodsTitle;
    
    if (model.selectState)
    {
        self.checkImg.image = [UIImage imageNamed:@"SelectedCircle"];
        self.selectState = YES;
        
    }else{
        self.selectState = NO;
        self.checkImg.image = [UIImage imageNamed:@"unSelectedCircle"];
    }
    self.priceLab.text =[NSString stringWithFormat:@"总价:¥%.2f",[model.goodsPrice floatValue]*model.goodsNum] ;
   // [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
     UIImage *load=[UIImage sd_animatedGIFNamed:@"myloadingA"];
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.imageName]placeholderImage:load];
}
-(void)layoutSubviews{
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            UIView *deleteConfirmationView = subView.subviews[0];
            deleteConfirmationView.backgroundColor = [UIColor colorWithHexString:@"0x59c5b7"];
            for (UIView *deleteView in deleteConfirmationView.subviews) {
                NSLog(@"%@",deleteConfirmationView.subviews);
                UIImageView *deleteImage = [[UIImageView alloc] init];
                deleteImage.contentMode = UIViewContentModeScaleAspectFit;
                deleteImage.frame = CGRectMake(0, 0, deleteView.frame.size.width, deleteView.frame.size.height);
                [deleteView addSubview:deleteImage];
            }
        }
    }
}
-(void)whenClickImage{
    [self.delegate shopImgclick:self.indexRow];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
