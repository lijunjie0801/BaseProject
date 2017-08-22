//
//  WebViewJS.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "WebViewJS.h"

@implementation WebViewJS

-(void)getVideoIndex:(NSString *)index{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(sendVideoIndex:)]) {
            [self.delegate sendVideoIndex:index];
        }
    });
    
}
-(void)check:(NSString *)result{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(checkJS:)]) {
            [self.delegate checkJS:result];
        }
    });
}
-(void)toAppAliPay:(NSString *)response{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toAppAlipayJS:)]) {
            [self.delegate toAppAlipayJS:response];
        }
    });
}

-(void)toAppWeiPay:(NSString *)response{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toAppWeiPayJS:)]) {
            [self.delegate toAppWeiPayJS:response];
        }
    });
}
-(void)toAppPlayer:(NSString *)classId{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toAppPlayerJS:)]) {
            [self.delegate toAppPlayerJS:classId];
        }
    });
}
-(void)toAppClass:(NSString *)classId{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toAppClassJS:)]) {
            [self.delegate toAppClassJS:classId];
        }
    });
}
-(void)toBuyClass{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toBuyClassJS)]) {
            [self.delegate toBuyClassJS];
        }
    });

}
-(void)toLogin{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toLoginJS)]) {
            [self.delegate toLoginJS];
        }
    });

}
-(void)commentClass{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(commentClassJS)]) {
            [self.delegate commentClassJS];
        }
    });

}
-(void)replyComment:(NSString *)commentId{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(replyCommentJS:)]) {
            [self.delegate replyCommentJS:commentId];
        }
    });

}
-(void)Todeil:(NSString *)content{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(TodeilJS:)]) {
            [self.delegate TodeilJS:content];
        }
    });
}

-(void)getTitle:(NSString *)content{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(getTitleJS:)]) {
            [self.delegate getTitleJS:content];
        }
    });

}

-(void)commentClassFromOrder:(NSString *)content{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(commentClassFromOrderJS:)]) {
            [self.delegate commentClassFromOrderJS:content];
        }
    });
}
-(void)keyup{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(keyupJS)]) {
            [self.delegate keyupJS];
        }
    });

}
-(void)toAppStore:(NSString *)goodsId{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toAppStoreJS:)]) {
            [self.delegate toAppStoreJS:goodsId];
        }
    });

}
-(void)toGoods:(NSString *)goodsId{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(toGoodsJS:)]) {
            [self.delegate toGoodsJS:goodsId];
        }
    });

}
-(void)replyTo:(NSString *)replyId{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(replyToJS:)]) {
            [self.delegate replyToJS:replyId];
        }
    });

}
-(void)goBackOfApp{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(goBackOfAppJS)]) {
            [self.delegate goBackOfAppJS];
        }
    });
}
@end

