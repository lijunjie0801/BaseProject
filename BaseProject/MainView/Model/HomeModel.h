//
//  HomeModel.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/24.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property(nonatomic,strong)NSString *classId;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSArray *proName;
@property(nonatomic,strong)NSArray *price;
@property(nonatomic,assign)CGFloat imgHeight;
//@property(nonatomic,assign)NSUInteger count;
@end
