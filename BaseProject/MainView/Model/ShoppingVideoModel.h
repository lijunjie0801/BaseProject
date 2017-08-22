//
//  ShoppingVideoModel.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingVideoModel : NSObject
@property(copy,nonatomic) NSString *imageName;//商品图片
@property(copy,nonatomic) NSString *goodsTitle;//商品标题
@property(copy,nonatomic) NSString *goodId;
//@property(copy,nonatomic) NSString *goodsType;//商品类型
@property(copy,nonatomic) NSString *goodsPrice;//商品单价
@property(assign,nonatomic) int goodsNum;//商品个数
@property(assign,nonatomic) BOOL selectState;//是否选中状态
@property(copy,nonatomic)NSString *shopCarId;





-(instancetype)initWithShopDict:(NSDictionary *)dict;
@end
