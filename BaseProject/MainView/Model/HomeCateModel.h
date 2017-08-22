//
//  HomeCateModel.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCateModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *classCateId;
@property (nonatomic,copy)NSArray *list;
@property (nonatomic,copy)NSString *placeholderImage;
@property (nonatomic,copy)NSString *bei;
-(instancetype)initWithCarDict:(NSDictionary*)dict;
+(instancetype)cateModel:(NSDictionary*)dict;
@end
