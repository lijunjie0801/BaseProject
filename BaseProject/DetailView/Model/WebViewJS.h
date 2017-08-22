//
//  WebViewJS.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol WebViewJSObjectProtocol <JSExport>

-(void)getVideoIndex:(NSString *)index;

-(void)check:(NSString *)result;

-(void)toAppAliPay:(NSString *)response;

-(void)toAppWeiPay:(NSString *)response;

-(void)toAppPlayer:(NSString *)classId;

-(void)toAppClass:(NSString *)classId;

-(void)toBuyClass;

-(void)toLogin;

-(void)commentClass;

-(void)replyComment:(NSString *)commentId;

-(void)Todeil:(NSString *)content;

-(void)getTitle:(NSString *)content;

-(void)commentClassFromOrder:(NSString *)content;

-(void)keyup;

-(void)goBackOfApp;

-(void)replyTo:(NSString *)replyId;

-(void)toGoods:(NSString *)goodsId;

-(void)toAppStore:(NSString *)goodsId;
@end



@protocol WebViewJSDelegate <NSObject>

-(void)sendVideoIndex:(NSString *)index;

-(void)checkJS:(NSString *)result;

-(void)toAppAlipayJS:(NSString *)response;

-(void)toAppWeiPayJS:(NSString *)response;

-(void)toAppPlayerJS:(NSString *)classId;

-(void)toAppClassJS:(NSString *)classId;

-(void)toBuyClassJS;

-(void)toLoginJS;

-(void)commentClassJS;

-(void)replyCommentJS:(NSString *)commentId;

-(void)TodeilJS:(NSString *)content;

-(void)getTitleJS:(NSString *)content;

-(void)toAppStoreJS:(NSString *)goodsId;

-(void)commentClassFromOrderJS:(NSString *)content;

-(void)keyupJS;

-(void)replyToJS:(NSString *)replyId;

-(void)toGoodsJS:(NSString *)goodsId;

-(void)goBackOfAppJS;
@end


    

@interface WebViewJS : NSObject<WebViewJSObjectProtocol>

@property(nonatomic, weak) id<WebViewJSDelegate> delegate;


@end
