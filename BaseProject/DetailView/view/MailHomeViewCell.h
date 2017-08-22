//
//  MailHomeViewCell.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/26.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MailHomeModel.h"
@protocol MailHomeViewCellDelegate<NSObject>

-(void)selectGoodsAction:(NSDictionary *)dic;

@end
@interface MailHomeViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UILabel *categoryLabel;
@property(nonatomic, strong) NSString *indexRow;
@property(nonatomic, strong)UILabel *titleLab;
@property(nonatomic, weak) id<MailHomeViewCellDelegate> delegate;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageCount:(NSInteger)imageCount;
-(void)updataWithModel:(MailHomeModel *)model;
@end
