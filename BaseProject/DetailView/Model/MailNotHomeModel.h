//
//  MailNotHomeModel.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/9.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MailNotHomeModel : NSObject
@property(nonatomic,strong)NSString *goodsShowPrice;
@property(nonatomic,strong)NSString *goodsId;
@property(nonatomic,strong)NSString *goodsImg;
@property(nonatomic,strong)NSString *goodsName;
-(instancetype)initWithShopDict:(NSDictionary *)dict;
@end
