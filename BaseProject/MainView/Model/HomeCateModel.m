//
//  HomeCateModel.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "HomeCateModel.h"

@implementation HomeCateModel
-(instancetype)initWithCarDict:(NSDictionary*)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
      
    }
    return self;
}

+(instancetype)cateModel:(NSDictionary*)dict{
    return [[self alloc]initWithCarDict:dict];
}
@end
