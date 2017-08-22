//
//  ShopppingVideoCarCell.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/27.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingModel.h"

#import "AddNumberView.h"
#import "LineLabel.h"

@protocol ShoppingCarCellDelegate;
@interface ShopppingVideoCarCell : UITableViewCell<AddNumberViewDelegate>


@property (nonatomic,strong) UIImageView *checkImg;

@property (nonatomic,strong) UIImageView *shopImageView;

@property (nonatomic,strong) UILabel *shopNameLab;

@property (nonatomic,strong) UILabel *priceLab;

@property (nonatomic,strong) LineLabel *oldPriceLab;//原价


@property (nonatomic,strong) UILabel *shopTypeLab;//商品型号

@property (nonatomic,strong) UIButton *jianBtn;//减数量按钮

@property (nonatomic,strong) UIButton *addBtn;//加数量按钮

@property (nonatomic,strong) UILabel *numberLab;//显示数量

//@property (nonatomic,strong) UILabel *priceLab;//显示价格

@property (nonatomic,strong) ShoppingModel *shoppingModel;

@property (assign,nonatomic) BOOL selectState;//选中状态

@property (nonatomic,assign) id<ShoppingCarCellDelegate>delegate;
@property(nonatomic, strong) NSString *indexRow;
@property (nonatomic,strong) AddNumberView *addNumberView;
-(void)updateWithModel:(ShoppingModel *)model;
@end

@protocol ShoppingCarCellDelegate

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;
-(void)MKJTableView:(UITableViewCell *)cell clickButton:(UIButton *)btn;
-(void)shopImgclick:(NSString *)indexRow;
@end
