//
//  ShoppingModel.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject


@property(copy,nonatomic) NSString *imageName;//商品图片


@property(copy,nonatomic) NSString *goodsTitle;//商品标题
@property(copy,nonatomic) NSString *goodsType;//商品类型
@property(copy,nonatomic) NSString *goodsPrice;//商品单价
@property(copy,nonatomic) NSString *goodsId;
@property(copy,nonatomic)NSString *shopCarId;
@property(assign,nonatomic) BOOL selectState;//是否选中状态

@property(assign,nonatomic) int goodsNum;//商品个数





-(instancetype)initWithShopDict:(NSDictionary *)dict;




@end
