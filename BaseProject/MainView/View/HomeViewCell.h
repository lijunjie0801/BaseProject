//
//  HomeViewCell.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "XHStarRateView.h"
#import "HomeCateModel.h"
@protocol HomeViewCellDelegate<NSObject>
-(void)saveAction:(NSString *)indexrow:(UIButton *)sender;
@end

@class HomeCateModel;
@interface HomeViewCell : UITableViewCell{
    NSInteger imgcount;
}
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,assign)int count;
@property(nonatomic,assign)UIButton *collectBtn;
@property(nonatomic,strong)UIScrollView *scroView;
@property(nonatomic,strong)XHStarRateView *starRateView;
@property(nonatomic, strong) NSString *indexRow;
@property(nonatomic, weak)id<HomeViewCellDelegate>delegate;
@property (nonatomic,copy) void(^selectBtnChange)(NSString *isSelect,NSString *indexrow);
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageCount:(NSInteger)imageCount;

@property(nonatomic, strong) HomeCateModel *homeCateModel;


-(void)updataWithModel:(HomeCateModel *)model;
@end
