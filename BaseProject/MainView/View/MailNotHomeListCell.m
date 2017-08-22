//
//  MailNotHomeListCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/26.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MailNotHomeListCell.h"
@interface MailNotHomeListCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end
@implementation MailNotHomeListCell
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
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_imageV autoSetDimension:ALDimensionHeight toSize: (kScreen_Width-30)/2];
//    _titleLabel.frame = CGRectMake(5, self.bounds.size.width - 45, kScreen_Width/2, 20);
//    _priceLabel.frame = CGRectMake(5, self.bounds.size.width - 20, kScreen_Width/2, 20);
    _imageV.image=[UIImage imageNamed:@"meishi"];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text=@"烘焙原料美国进口纯AMD代可可";
    _titleLabel.font = [UIFont systemFontOfSize:16];
   // _titleLabel.numberOfLines=0;
    _titleLabel.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10+ (kScreen_Width-30)/2];
    [_titleLabel autoSetDimension:ALDimensionHeight toSize:20];
    
       
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35+ (kScreen_Width-30)/2, 100,15)];
    _priceLabel.textColor=[UIColor colorWithHexString:@"#555555"];
    _priceLabel.text=@"¥163.00";
    _priceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_priceLabel];
}

-(void)updateWithModel:(MailNotHomeModel *)model{
   
//    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.goodsImg]];
     UIImage *load=[UIImage sd_animatedGIFNamed:@"myloadingA"];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.goodsImg]placeholderImage:load];

    _priceLabel.text=[NSString stringWithFormat:@"¥%@",model.goodsShowPrice];
    _titleLabel.text=model.goodsName;
}

@end
