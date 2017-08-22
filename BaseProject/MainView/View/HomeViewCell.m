//
//  HomeViewCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "HomeViewCell.h"
#import "HomeCateModel.h"
#define imgWidth (kScreen_Width-50)/2
#import "UIImage+GIF.h"
@implementation HomeViewCell

-(NSMutableArray *)array{
    if (!_array) {
        _array=[NSMutableArray array];
    }
    return _array;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageCount:(NSInteger)imageCount{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel=[[UILabel alloc]init];
        self.titleLabel=titleLabel;
        titleLabel.font=[UIFont systemFontOfSize:17];
//        titleLabel.numberOfLines=0;
        [self.contentView addSubview:titleLabel];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:32.5];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [titleLabel autoSetDimensionsToSize:CGSizeMake(100, 20)];
        
        UIButton *moreBtn=[[UIButton alloc]init];
        [moreBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        moreBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [moreBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
//        [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
         CGSize moreSize=[@"查看全部" sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        [self.contentView addSubview:moreBtn];
        [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:32.5];
        [moreBtn autoSetDimensionsToSize:CGSizeMake(moreSize.width+10, 20)];
        
        UIImageView *moreImgView=[[UIImageView alloc]init];
        moreImgView.image=[UIImage imageNamed:@"more"];
        [self.contentView addSubview:moreImgView];
        [moreImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:36.5];
        [moreImgView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:moreBtn withOffset:0];
        [moreImgView autoSetDimensionsToSize:CGSizeMake(7, 12)];
        
        
      
//        UILabel *moreLab=[[UILabel alloc]init];
//        moreLab.text=@"查看全部";
//        moreLab.textColor=[UIColor colorWithHexString:@"#a0a0a0"];
//        [self.contentView addSubview:moreLab];
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreClick)];
//        singleTap.numberOfTapsRequired = 1;
//        [moreLab addGestureRecognizer:singleTap];
//        CGSize moreSize=[moreLab.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
//        [moreLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//        [moreLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:32.5];
//        [moreLab autoSetDimensionsToSize:CGSizeMake(moreLab.width, 20)];



        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 72.5, kScreen_Width, imgWidth+160)];
        self.scroView=scrollView;
        [self.contentView addSubview:scrollView];
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
      
        
        for (int index = 0; index <imageCount; index++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame=CGRectMake(index * imgWidth+(index+1)*10, 0, imgWidth,imgWidth);
            imageView.tag=100+index;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellImageClick:)];
            UIView *singleTapView = [tap view];
            singleTapView.tag =index;
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [_scroView addSubview:imageView];
            
            UIButton *collectBtn=[[UIButton alloc]init];
           // _collectBtn=collectBtn;
            collectBtn.frame=CGRectMake(index * imgWidth+(index+1)*10+imgWidth-30, 10,17.5,15);
            collectBtn.tag=index+700;
            [collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
            [collectBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
            [_scroView addSubview:collectBtn];
            
            
         
            
            UILabel *proNameLabel=[[UILabel alloc]init];
            proNameLabel.tag=200+index;
            proNameLabel.font=[UIFont systemFontOfSize:14];
            proNameLabel.textColor=[UIColor colorWithHexString:@"#555555"];
             proNameLabel.frame=CGRectMake(index * imgWidth+(index+1)*10, imgWidth, imgWidth,20);
             [_scroView addSubview:proNameLabel];

            _starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(index * imgWidth+(index+1)*10-5, imgWidth+30, 80,12)];
            _starRateView.tag=600+index;
            _starRateView.rateStyle = WholeStar;
            _starRateView.numberOfStars = 5;
            _starRateView.currentScore = 3;
            [_scroView addSubview:_starRateView];
            
            UILabel *priceLabel=[[UILabel alloc]init];
            priceLabel.tag=300+index;
            priceLabel.font=[UIFont systemFontOfSize:14];
            priceLabel.textColor=[UIColor colorWithHexString:@"#555555"];
            priceLabel.frame=CGRectMake(index * imgWidth+(index+1)*10, imgWidth+10, imgWidth,20);
            [_scroView addSubview:priceLabel];

        }
        _scroView.contentSize = CGSizeMake((imgWidth+10) *imageCount+10, 0);
        
      
    }
    return self;
}

-(void)setHomeCateModel:(HomeCateModel *)homeCateModel
{
    _homeCateModel = homeCateModel;
    
    
    
    self.scroView.frame=CGRectMake(0, 65, kScreen_Width, imgWidth*[homeCateModel.bei floatValue]+75);
    NSLog(@"%@",homeCateModel);
    for (int i=0; i<homeCateModel.list.count; i++) {
        UIImageView *imageView=[self viewWithTag:100+i];
        float bei=[homeCateModel.bei floatValue];
        
        UIImage *load=[UIImage sd_animatedGIFNamed:homeCateModel.placeholderImage];
        [imageView sd_setImageWithURL:[NSURL URLWithString:homeCateModel.list[i][@"classImg"]] placeholderImage:load];
        imageView.frame=CGRectMake(i * imgWidth+(i+1)*10, 0, imgWidth,imgWidth*bei);
        
        UILabel *proLabel=[self viewWithTag:200+i];
        proLabel.text=homeCateModel.list[i][@"classTitle"];
        proLabel.frame=CGRectMake(i * imgWidth+(i+1)*10, imgWidth*bei+10, imgWidth,20);
        
        XHStarRateView *starRateView=[self viewWithTag:600+i];
        starRateView.frame=CGRectMake(i * imgWidth+(i+1)*10-2, imgWidth*bei+60, 80,12);
        starRateView.numberOfStars = 5;
        starRateView.currentScore = [homeCateModel.list[i][@"classDifficulty"] integerValue];
        
        
        UILabel *priceLabel=[self viewWithTag:300+i];
        if (!homeCateModel.list[i][@"classPrice"]) {
            priceLabel.text=@"Free";
        }else{
            priceLabel.text=[NSString stringWithFormat:@"¥%@",homeCateModel.list[i][@"classPrice"]] ;
        }
        priceLabel.frame=CGRectMake(i * imgWidth+(i+1)*10, imgWidth*bei+35, imgWidth,20);
        
        UIButton *button=[self viewWithTag:700+i];
        
        NSLog(@"结果%@======%d=====%@",self.indexRow,i,homeCateModel.list[i][@"isSave"]);
        
        
        if ([homeCateModel.list[i][@"isSave"] isEqualToString:@"0"]) {
            [button setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            button.selected = NO;
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            button.selected = YES;
            
        }
    }
    
    
    
}

-(void)updataWithModel:(HomeCateModel *)model{
    self.scroView.frame=CGRectMake(0, 65, kScreen_Width, imgWidth*[model.bei floatValue]+75);
    NSLog(@"%@",model);
    for (int i=0; i<model.list.count; i++) {
        UIImageView *imageView=[self viewWithTag:100+i];
        float bei=[model.bei floatValue];

        UIImage *load=[UIImage sd_animatedGIFNamed:model.placeholderImage];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.list[i][@"classImg"]] placeholderImage:load];
        imageView.frame=CGRectMake(i * imgWidth+(i+1)*10, 0, imgWidth,imgWidth*bei);
        
         UILabel *proLabel=[self viewWithTag:200+i];
        proLabel.text=model.list[i][@"classTitle"];
        proLabel.frame=CGRectMake(i * imgWidth+(i+1)*10, imgWidth*bei+10, imgWidth,20);
        
        XHStarRateView *starRateView=[self viewWithTag:600+i];
        starRateView.frame=CGRectMake(i * imgWidth+(i+1)*10, imgWidth*bei+60, 80,12);
        starRateView.numberOfStars = 5;
        starRateView.currentScore = [model.list[i][@"classDifficulty"] integerValue];


        UILabel *priceLabel=[self viewWithTag:300+i];
        if (!model.list[i][@"classPrice"]) {
            priceLabel.text=@"Free";
        }else{
            priceLabel.text=[NSString stringWithFormat:@"¥%@",model.list[i][@"classPrice"]] ;
        }
        priceLabel.frame=CGRectMake(i * imgWidth+(i+1)*10, imgWidth*bei+35, imgWidth,20);
        
        UIButton *button=[self viewWithTag:700+i];
        if ([model.list[i][@"isSave"] isEqualToString:@"0"]) {
             [button setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
             button.selected = NO;
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            button.selected = YES;
          
        }
    }
}
-(void)cellImageClick:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld",[singleTap view].tag);
     [[NSNotificationCenter defaultCenter] postNotificationName:@"cellImgClick" object:self userInfo:@{@"btnIndex":[NSString stringWithFormat:@"%ld",[singleTap view].tag-100]}];
}
-(void)collectClick:(UIButton *)sender{
    
//    sender.selected = !sender.selected;
    
        
    
    if (self.selectBtnChange) {
        self.selectBtnChange([NSString stringWithFormat:@"%d",sender.selected],[NSString stringWithFormat:@"%ld",sender.tag-700]);
    }


    if ([self.delegate respondsToSelector:@selector(saveAction::)]) {
        [self.delegate saveAction:self.indexRow :sender];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)moreClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moreClick" object:self userInfo:nil];

  
}

@end
