//
//  HttpManagerPort.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "HttpManagerPort.h"
#import "ZZLProgressHUD.h"
#import "HttpManagers.h"
@implementation HttpManagerPort
DEFINE_SINGLETON_FOR_CLASS(HttpManagerPort)


/**获取验证码**/
-(void)getVerficode:(NSString *)mobile type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/sendCode",kBaseUrl] parameters:@{@"mobile":mobile,@"type":type} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}
/**注册**/
-(void)getRegistcode:(NSString *)mobile password:(NSString *)password code:(NSString *)code sendCode:(NSString *)sendCode Success:(void (^)(id))success Failure:(void (^)(NSError *))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/mobileRegister",kBaseUrl] parameters:@{@"mobile":mobile,@"password":password,@"code":code,@"sendCode":sendCode} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**获取分类**/
-(void)getCategory:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/category",kBaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**登录**/
-(void)getLogin:(NSString *)mobile password:(NSString *)password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/mobileLogin",kBaseUrl] parameters:@{@"mobile":mobile,@"password":password} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**更改密码**/
-(void)changePassword:(NSString *)mobile code:(NSString *)code sendCode:(NSString *)sendCode password:(NSString *)password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/changePassword",kBaseUrl] parameters:@{@"mobile":mobile,@"code":code,@"sendCode":sendCode,@"password":password} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取首页数据**/
-(void)getHomeData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_index",kBaseUrl] parameters:@{@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**获取首页bannel数据**/
-(void)getHomeBannelData:(void (^)(id))success Failure:(void (^)(NSError *))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_indexbanner",kBaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**单类别课程信息**/
-(void)getOnecate_classlist:(NSString *)userId cate_id:(NSString *)cate_id Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/onecate_classlist",kBaseUrl] parameters:@{@"userId":userId,@"cate_id":cate_id} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取已购买数据**/
-(void)getClass_buyList:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_buy",kBaseUrl] parameters:@{@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取已收藏数据**/
-(void)getClass_collectList:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_save",kBaseUrl] parameters:@{@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取已观看数据**/
-(void)getClass_readList:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_readsave",kBaseUrl] parameters:@{@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**收藏操作**/
-(void)class_collect_act:(NSString *)userId classId:(NSString *)classId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_collect_act",kBaseUrl] parameters:@{@"userId":userId,@"classId":classId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取商品数据**/
-(void)getGoodsCateData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/shop/getGoodsCate",kBaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取商城首页数据**/
-(void)getShopIndexData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/shop/shopIndex",kBaseUrl]parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
///
/**获取商城分类下商品数据**/
-(void)getShopCateData:(NSString *)cate page:(NSString *)page Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/shop/shopCate",kBaseUrl] parameters:@{@"cate":cate,@"page":page} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取个人信息数据**/
-(void)getUserIndexData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/userCenter/userIndex",kBaseUrl] parameters:@{@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**获取课程详情数据**/
-(void)getClass_infoData:(NSString *)classId userId:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_info",kBaseUrl] parameters:@{@"classId":classId,@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**观看操作**/
-(void)class_read_act:(NSString *)userId classId:(NSString *)classId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_readsave_act",kBaseUrl] parameters:@{@"userId":userId,@"classId":classId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**报名操作**/
-(void)offline_apply:(NSString *)phoneNum realName:(NSString *)realName Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/offline_apply",kBaseUrl] parameters:@{@"phoneNum":phoneNum,@"realName":realName} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**修改昵称**/
-(void)changeUserInfo:(NSString *)userId userName:(NSString *)userName Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/userCenter/changeUserInfo",kBaseUrl] parameters:@{@"userId":userId,@"userName":userName} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取购物车商品数据**/
-(void)getShopCarData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]GET:[NSString stringWithFormat:@"%@/api.php/UserCenter/shopCar",kBaseUrl] parameters:@{@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**上传头像**/
-(void)changeUserIcon:(NSString *)userId headcode:(NSString *)headcode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/changeHead",kBaseUrl] parameters:@{@"userId":userId,@"headcode":headcode} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**上传背景**/
-(void)changeBackground:(NSString *)userId Backgroundcode:(NSString *)Backgroundcode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/changeBackground",kBaseUrl] parameters:@{@"userId":userId,@"Backgroundcode":Backgroundcode} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**授权注册**/
-(void)authorizationRigst:(NSString *)openId type:(NSString *)type mobile:(NSString *)mobile code:(NSString *)code sendCode:(NSString *)sendCode nickName:(NSString *)nickName userImg:(NSString *)userImg Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/thirdRegister",kBaseUrl] parameters:@{@"openId":openId,@"type":type,@"mobile":mobile,@"code":code,@"nickName":nickName, @"userImg":userImg,@"sendCode":sendCode} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**授权登录**/
-(void)authorizationLogin:(NSString *)openId type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/thirdLogin",kBaseUrl] parameters:@{@"type":type,@"openId":openId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**购物车删除**/
-(void)deleteShopCar:(NSString *)userId shopCarId:(NSString *)shopCarId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/UserCenter/deleteShopCar",kBaseUrl] parameters:@{@"userId":userId,@"shopCarId":shopCarId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/** 站内消息是否有新消息**/
-(void)isNewMessage:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/UserCenter/newMessage",kBaseUrl] parameters:@{@"userId":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**阅读消息操作**/
-(void)changeNewsAct:(NSString *)userId newsType:(NSString *)newsType Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/UserCenter/changeNews",kBaseUrl] parameters:@{@"userId":userId,@"newsType":newsType} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**课程评论操作**/
-(void)classComment:(NSString *)userId classId:(NSString *)classId content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_info_comment",kBaseUrl] parameters:@{@"userId":userId,@"classId":classId,@"content":content} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**评论回复操作**/
-(void)classReply:(NSString *)userId commentId:(NSString *)commentId content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_info_reply",kBaseUrl] parameters:@{@"userId":userId,@"commentId":commentId,@"content":content} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**评论回评论操作**/
-(void)replyToReply:(NSString *)userId replyId:(NSString *)replyId content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_info_replyTo",kBaseUrl] parameters:@{@"userId":userId,@"replyId":replyId,@"content":content} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}


/**用户观看权限**/
-(void)class_Permission:(NSString *)userId classId:(NSString *)classId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/teach/class_Permission",kBaseUrl] parameters:@{@"userId":userId,@"classId":classId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
