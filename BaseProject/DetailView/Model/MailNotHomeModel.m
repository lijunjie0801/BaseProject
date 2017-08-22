//
//  MailNotHomeModel.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/9.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MailNotHomeModel.h"

@implementation MailNotHomeModel
-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
    self.goodsId = dict[@"goodsId"];
    self.goodsName = dict[@"goodsName"];
    self.goodsImg = dict[@"goodsImg"];
    self.goodsShowPrice = dict[@"goodsShowPrice"];
    return self;
}
@end
