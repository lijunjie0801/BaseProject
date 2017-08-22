//
//  MailHomeViewCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/26.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MailHomeViewCell.h"
#define imgWidth kScreen_Width/4
@implementation MailHomeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageCount:(NSInteger)imageCount{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *topImageView=[[UIImageView alloc]init];
        self.topImageView=topImageView;
        [self.contentView addSubview:topImageView];
        [topImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [topImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [topImageView autoSetDimensionsToSize:CGSizeMake(kScreen_Width,kScreen_Width/1.67 )];
        
//        UILabel *categoryLabel=[[UILabel alloc]init];
//        _categoryLabel=categoryLabel;
//        categoryLabel.backgroundColor=[UIColor whiteColor];
//        categoryLabel.alpha=0.5;
//        categoryLabel.textAlignment=UITextAlignmentCenter;
//        categoryLabel.text=@"类别";
//        [self.contentView addSubview:categoryLabel];
//        [categoryLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(kScreen_Width-30)*0.25+10];
//        [categoryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(kScreen_Width-80)/2];
//        [categoryLabel autoSetDimensionsToSize:CGSizeMake(80,30)];
        
        UILabel *titleLab=[[UILabel alloc]init];
        self.titleLab=titleLab;
        titleLab.text=@"部分商品";
        titleLab.font=[UIFont systemFontOfSize:16];
        titleLab.numberOfLines=0;
        [self.contentView addSubview:titleLab];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kScreen_Width/1.67+25];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [titleLab autoSetDimensionsToSize:CGSizeMake(100, 20)];
        
//        UIButton *moreBtn=[[UIButton alloc]init];
//        [moreBtn setTitle:@"查看全部>" forState:UIControlStateNormal];
//        moreBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//        [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [self.contentView addSubview:moreBtn];
//        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kScreen_Width*0.5+20];
//        [moreBtn autoSetDimensionsToSize:CGSizeMake(100, 20)];
     
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kScreen_Width/1.67+55, kScreen_Width, imgWidth+60)];
//        self.scroView=scrollView;
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
            imageView.image = [UIImage imageNamed:@"meishi"];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellImageClick:)];
            UIView *singleTapView = [tap view];
            singleTapView.tag =index;
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [scrollView addSubview:imageView];
            
            UILabel *proNameLabel=[[UILabel alloc]init];
            proNameLabel.tag=200+index;
            proNameLabel.font=[UIFont systemFontOfSize:14];
            proNameLabel.frame=CGRectMake(index * imgWidth+(index+1)*10, imgWidth+5, imgWidth,20);
           // proNameLabel.numberOfLines=0;
            proNameLabel.textColor=[UIColor colorWithHexString:@"#555555"];
            [scrollView addSubview:proNameLabel];
            
            UILabel *priceLabel=[[UILabel alloc]init];
            priceLabel.textColor=[UIColor colorWithHexString:@"#555555"];
            priceLabel.tag=300+index;
            priceLabel.font=[UIFont systemFontOfSize:14];
            priceLabel.frame=CGRectMake(index * imgWidth+(index+1)*10, imgWidth+25, imgWidth,20);
            [scrollView addSubview:priceLabel];
            
        }
        scrollView.contentSize = CGSizeMake((imgWidth+10) *imageCount+10, 0);
        
        
    }
    return self;
}
-(void)updataWithModel:(MailHomeModel *)model{
   [_topImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsCateImg] placeholderImage:nil];
    self.titleLab.text=model.title;
    for (int i=0; i<model.list.count; i++) {
        
        UIImageView *imageView=[self viewWithTag:100+i];
         UIImage *load=[UIImage sd_animatedGIFNamed:@"myloadingA"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.list[i][@"goodsImg"]] placeholderImage:load];
        
        UILabel *proLabel=[self viewWithTag:200+i];
        proLabel.text=model.list[i][@"goodsName"];
    
       
        
        UILabel *priceLabel=[self viewWithTag:300+i];
        priceLabel.text=[NSString stringWithFormat:@"¥%@",model.list[i][@"goodsShowPrice"]];
  
        
    }
}



-(void)cellImageClick:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld",[singleTap view].tag);
    if ([self.delegate respondsToSelector:@selector(selectGoodsAction:)]) {
        
        [self.delegate selectGoodsAction:@{@"indexRow":self.indexRow,
                                           @"index":[NSString stringWithFormat:@"%ld",[singleTap view].tag-100]}];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
