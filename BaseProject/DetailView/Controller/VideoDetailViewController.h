//
//  VideoDetailViewController.h
//  SKOClass
//
//  Created by fyaex001 on 2017/4/1.
//  Copyright © 2017年 lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoDetailViewController : UIViewController
@property (nonatomic, strong) NSString *classId;
/** 视频URL */
@property (nonatomic, strong) NSURL *videoURL;
/** 视频标题 */
@property (nonatomic, strong) NSString *videoTitle;

@property (nonatomic, strong)NSString *homeTohere;

@end
