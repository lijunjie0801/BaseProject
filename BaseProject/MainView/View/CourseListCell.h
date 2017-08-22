//
//  CourseListCell.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/24.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"

@protocol CourseListCellDelegate<NSObject>

-(void)selectSaveBtnAction:(NSString *)indexRow;

@end

@interface CourseListCell : UICollectionViewCell
@property (nonatomic, strong) CourseModel *model;
-(void)updateWithModel:(CourseModel *)model;

@property(nonatomic, strong) NSString *indexRow;

@property(nonatomic, weak) id<CourseListCellDelegate> delegate;

@end
