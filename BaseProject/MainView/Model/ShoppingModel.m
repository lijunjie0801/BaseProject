//
//  ShoppingModel.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel



-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
        self.imageName = dict[@"itemImg"];
        self.goodsTitle = dict[@"itemName"];
        self.goodsPrice = dict[@"itemPrice"];
        self.goodsNum = [dict[@"itemNum"] intValue];
        self.shopCarId=dict[@"shopCarId"];
        self.goodsId = dict[@"itemId"];
        self.goodsType=[NSString stringWithFormat:@"规格:%@",dict[@"itemNormsName"]];
        self.selectState = NO;
    
    return self;
}





@end
