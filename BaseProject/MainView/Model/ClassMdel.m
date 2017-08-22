//
//  ClassMdel.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ClassMdel.h"

@implementation ClassMdel
-(void)setHomeCateModel:(HomeCateModel *)homeCateModel {
    
    _homeCateModel = homeCateModel;
    
    NSMutableArray *mutbleArray = [NSMutableArray array];
    for (NSDictionary *dict in homeCateModel.list) {
        
        ClassMdel *innerModel = [[ClassMdel alloc] initWithClassDict:dict];
        [mutbleArray addObject:innerModel];
    }
    _homeCateModel.list = mutbleArray;
}

-(instancetype)initWithClassDict:(NSDictionary*)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
//
+(instancetype)class :(NSDictionary*)dict{
    return [[self alloc]initWithClassDict:dict];
}

@end
