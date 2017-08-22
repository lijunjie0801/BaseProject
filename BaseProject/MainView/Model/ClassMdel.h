//
//  ClassMdel.h
//  BaseProject
//
//  Created by lijunjie on 2017/5/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeCateModel.h"
@interface ClassMdel : NSObject
@property (nonatomic,copy) NSString *classTitle;
@property (nonatomic,copy) NSString *classImg;
@property (nonatomic,strong) HomeCateModel *homeCateModel;
@end
