//
//  AppDelegate.h
//  BaseProject
//
//  Created by lijunjie on 2017/4/17.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@protocol AppdelDelegate <NSObject>
-(void)huidiao:(NSString *)index;
-(void)stopVideo;
@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property(nonatomic,retain) NSString * access_token;
@property(nonatomic,retain) NSString * openid;
@property(nonatomic, weak) id<AppdelDelegate> delegate;
- (void)saveContext;


@end

