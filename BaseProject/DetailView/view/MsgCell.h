//
//  MsgCell.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/19.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgModel.h"
@interface MsgCell : UITableViewCell
@property(nonatomic,strong)UILabel *msglabel;
-(void)updataWithModel:(MsgModel *)model;
@property(nonatomic,strong) UIView *blueView;
@end
