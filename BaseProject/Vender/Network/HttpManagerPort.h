//
//  HttpManagerPort.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySingleton.h"
@interface HttpManagerPort : NSObject
DEFINE_SINGLETON_FOR_HEADER(HttpManagerPort)

/**获取验证码**/
-(void)getVerficode:(NSString *)mobile type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**注册**/
-(void)getRegistcode:(NSString *)mobile password:(NSString *)password code:(NSString *)code sendCode:(NSString *)sendCode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**登录**/
-(void)getLogin:(NSString *)mobile password:(NSString *)password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**忘记密码**/
-(void)changePassword:(NSString *)mobile code:(NSString *)code sendCode:(NSString *)sendCode password:(NSString *)password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取课程分类**/
-(void)getCategory:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;

/**获取首页数据**/
//-(void)getHomeData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
-(void)getHomeData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取首页bannel**/
-(void)getHomeBannelData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;

/**单类别课程信息**/
-(void)getOnecate_classlist:(NSString *)userId cate_id:(NSString *)cate_id Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取已购买数据**/
-(void)getClass_buyList:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取已收藏数据**/
-(void)getClass_collectList:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**收藏操作**/
-(void)class_collect_act:(NSString *)userId classId:(NSString *)classId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取商城首页数据**/
-(void)getShopIndexData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取商品数据**/
-(void)getGoodsCateData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取商城分类下商品数据**/
-(void)getShopCateData:(NSString *)cate page:(NSString *)page Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取个人信息数据**/
-(void)getUserIndexData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取课程详情数据**/
-(void)getClass_infoData:(NSString *)classId userId:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**观看操作**/
-(void)class_read_act:(NSString *)userId classId:(NSString *)classId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取已观看数据**/
-(void)getClass_readList:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**报名操作**/
-(void)offline_apply:(NSString *)phoneNum realName:(NSString *)realName Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**修改昵称**/
-(void)changeUserInfo:(NSString *)userId userName:(NSString *)userName Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取购物车商品数据**/
-(void)getShopCarData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**上传头像**/
-(void)changeUserIcon:(NSString *)userId headcode:(NSString *)headcode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**授权登录**/
-(void)authorizationRigst:(NSString *)openId type:(NSString *)type mobile:(NSString *)mobile code:(NSString *)code sendCode:(NSString *)sendCode nickName:(NSString *)nickName userImg:(NSString *)userImg Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**授权登录**/
-(void)authorizationLogin:(NSString *)openId type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**购物车删除**/
-(void)deleteShopCar:(NSString *)userId shopCarId:(NSString *)shopCarId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/** 站内消息是否有新消息**/
-(void)isNewMessage:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**阅读消息操作**/
-(void)changeNewsAct:(NSString *)userId newsType:(NSString *)newsType Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**课程评论操作**/
-(void)classComment:(NSString *)userId classId:(NSString *)classId content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**评论回复操作**/
-(void)classReply:(NSString *)userId commentId:(NSString *)commentId content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**用户观看权限**/
-(void)class_Permission:(NSString *)userId classId:(NSString *)classId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**评论回评论操作**/
-(void)replyToReply:(NSString *)userId replyId:(NSString *)replyId content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**上传背景**/
-(void)changeBackground:(NSString *)userId Backgroundcode:(NSString *)Backgroundcode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
@end
