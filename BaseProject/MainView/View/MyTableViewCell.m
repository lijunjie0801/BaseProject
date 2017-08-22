//
//  MyTableViewCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/4/20.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imgView=[[UIImageView alloc]init];
        self.imgView=imgView;
        [self.contentView addSubview:imgView];
        [imgView autoSetDimensionsToSize:CGSizeMake(100, 100)];
        [imgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [imgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        
        UILabel *titleLabel=[[UILabel alloc]init];
        self.titleLabel=titleLabel;
        titleLabel.numberOfLines=0;
        [self.contentView addSubview:titleLabel];
       // CGFloat labelX=CGRectGetMaxX(imgView.bounds);
        [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imgView withOffset:10];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        
    }
    return self;
}
-(void)updataWithModel:(MyModel *)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"default"]  options:SDWebImageRetryFailed];
    self.titleLabel.text=model.title;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
