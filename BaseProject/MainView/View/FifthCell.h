//
//  FifthCell.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/11.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol fifthDelegate<NSObject>

-(void)clickMyCollection;
-(void)clickMyOrders;
-(void)changeName:(UIButton *)sender;
-(void)orderClick:(UIButton *)sender;
-(void)changeIcon;
-(void)changeBackGround;
@end
@interface FifthCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UIImageView *backGroundView;
@property(nonatomic,strong)UITextField *nickNameContent;
@property(nonatomic,strong)UIButton *changeNameBtn;
@property(nonatomic,strong)UILabel *phoneNumContent;
@property(nonatomic,weak)id<fifthDelegate>delegate;
-(void)updataWithDic:(NSDictionary *)dic;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageCount:(NSInteger)imageCount;
@end
