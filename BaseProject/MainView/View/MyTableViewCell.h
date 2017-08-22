//
//  MyTableViewCell.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/20.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface MyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLabel;
-(void)updataWithModel:(MyModel *)model;
@end
