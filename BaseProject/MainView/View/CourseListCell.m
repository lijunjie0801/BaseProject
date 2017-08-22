//
//  CourseListCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/24.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "CourseListCell.h"
#import "XHStarRateView.h"
@interface CourseListCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) XHStarRateView *starRateView;
@property (nonatomic, strong) UIButton *collectBtn;

@end
@implementation CourseListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI
{
    _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageV];
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_imageV autoSetDimension:ALDimensionHeight toSize: (kScreen_Width-30)/2];
    
    UIButton *collectBtn=[[UIButton alloc]init];
    _collectBtn=collectBtn;
//    collectBtn.userInteractionEnabled=YES;
    [collectBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    //[collectBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [_imageV addSubview:collectBtn];
    _imageV.userInteractionEnabled = YES;
    [collectBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [collectBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [collectBtn autoSetDimensionsToSize:CGSizeMake(17.5,15)];

    
    _titleLabel.frame = CGRectMake(5, self.bounds.size.width - 45, kScreen_Width/2, 20);
    _priceLabel.frame = CGRectMake(5, self.bounds.size.width - 20, kScreen_Width/2, 20);
    _imageV.image=[UIImage imageNamed:@"meishi"];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text=@"123";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10+ (kScreen_Width-30)/2];
    [_titleLabel autoSetDimension:ALDimensionHeight toSize:20];
    
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(-2, 50+ (kScreen_Width-30)/2, 80,12)];
    self.starRateView=starRateView;
     starRateView.rateStyle = WholeStar;
    starRateView.tag = 1;
    starRateView.numberOfStars = 5;
    starRateView.currentScore = 3;
    [self.contentView addSubview:starRateView];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30+ (kScreen_Width-30)/2, 100,20)];
    _priceLabel.text=@"¥163.00";
    _priceLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_priceLabel];
}
-(void)saveClick:(UIButton *)sender{
    
    NSLog(@"结果===%@",self.indexRow);
    if (sender.selected==YES) {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        sender.selected=NO;
    }else{
        if ([DEFAULTS objectForKey:@"userId"]) {
            [sender setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            sender.selected=YES;
        }
      
    }
    
    if ([self.delegate respondsToSelector:@selector(selectSaveBtnAction:)]) {
        
        [self.delegate selectSaveBtnAction:self.indexRow];
    }
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cellBtnClick" object:self userInfo:nil];

}
-(void)updateWithModel:(CourseModel *)model{
 
//    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.classImg] placeholderImage:[UIImage imageNamed:@"unLoadA"]];
    UIImage *load=[UIImage sd_animatedGIFNamed:@"myloadingA"];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.classImg]placeholderImage:load];
    _priceLabel.text=[NSString stringWithFormat:@"¥%@",model.classPrice];
    _priceLabel.textColor=[UIColor colorWithHexString:@"#555555"];
    _titleLabel.text=model.classTitle;
    _starRateView.numberOfStars = 5;
    _starRateView.currentScore = [model.classDifficulty floatValue];
    if ([model.isSave integerValue]==0) {
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _collectBtn.selected=NO;
    }else{
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        _collectBtn.selected=YES;
    }
}
@end
