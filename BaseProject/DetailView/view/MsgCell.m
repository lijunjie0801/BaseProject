//
//  MsgCell.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/19.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MsgCell.h"

@implementation MsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    UILabel *msglabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width-20, 50)];
    _msglabel=msglabel;
    [self.contentView addSubview:msglabel];
    
    UIView *topsepView=[[UIView alloc]initWithFrame:CGRectMake(15, 49.5, kScreen_Width-30, 0.5)];
    topsepView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:topsepView];
    
    UIView *blueView=[[UIView alloc]init];
    _blueView=blueView;
    blueView.hidden=YES;
    blueView.backgroundColor=[UIColor colorWithHexString:@"0x59c5b7"];
    [self.contentView addSubview:blueView];
    blueView.layer.cornerRadius=2.5;
    blueView.backgroundColor=[UIColor colorWithHexString:@"0x59c5b7"];

    UIImageView *moreImgView=[[UIImageView alloc]init];
    moreImgView.image=[UIImage imageNamed:@"more"];
    [self.contentView addSubview:moreImgView];
    [moreImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17.5];
    [moreImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [moreImgView autoSetDimensionsToSize:CGSizeMake(7.5, 15)];
    
    


}
-(void)updataWithModel:(MsgModel *)model{
    self.msglabel.text=model.content;
    CGSize titleSize=[model.content sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    self.msglabel.frame=CGRectMake(10, 15, titleSize.width+10, 20);
    _blueView.frame=CGRectMake(15+titleSize.width, 15, 5, 5);
   
    if ( [model.readstatus isEqualToString:@"1"]) {
        _blueView.hidden=NO;
    }else{
        _blueView.hidden=YES;
    }
    
}

@end
