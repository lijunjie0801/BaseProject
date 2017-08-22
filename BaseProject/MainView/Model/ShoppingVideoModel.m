//
//  ShoppingVideoModel.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ShoppingVideoModel.h"

@implementation ShoppingVideoModel
-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
    self.imageName = dict[@"itemImg"];
    self.goodsTitle = dict[@"itemName"];
    self.goodsPrice = dict[@"itemPrice"];
    self.goodsNum = 1;
    self.goodId = dict[@"itemId"];
    self.shopCarId=dict[@"shopCarId"];
//    self.goodsType=[NSString stringWithFormat:@"规格:%@",dict[@"itemNormsName"]];
    self.selectState = NO;
    
    return self;
}
@end
