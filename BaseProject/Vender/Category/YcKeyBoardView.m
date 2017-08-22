//
//  YcKeyBoardView.m
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import "YcKeyBoardView.h"

@interface YcKeyBoardView()<UITextViewDelegate>
@property (nonatomic,assign) CGFloat textViewWidth;
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL reduce;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@end

@implementation YcKeyBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initTextView:frame];
    }
    return self;
}
-(void)initTextView:(CGRect)frame
{
    self.textView=[[UITextView alloc]init];
    self.textView.delegate=self;
    CGFloat textX=kStartLocation*0.5;
    self.textViewWidth=frame.size.width-100;
//    self.textView.frame=CGRectMake(textX, kStartLocation*0.2,self.textViewWidth , frame.size.height-2*kStartLocation*0.2);
    self.textView.frame=CGRectMake(15, kStartLocation*0.2,kScreen_Width-100, frame.size.height-2*kStartLocation*0.2);
    self.textView.backgroundColor=RGB(241, 241, 241);
    self.textView.layer.cornerRadius=6.0;
    self.textView.font=[UIFont systemFontOfSize:16.0];
    [self addSubview:self.textView];
    
    UIButton *sendBtn=[[UIButton alloc]init];
    [sendBtn setTitle:@"发表" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor colorWithHexString:@"0x59c5b7"] forState:UIControlStateNormal];
    [self addSubview:sendBtn];
    [sendBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.textView withOffset:10];
    [sendBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [sendBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4];
    [sendBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:4];
    [sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5,0,kScreen_Width-30,frame.size.height-2*kStartLocation*0.2)];
    self.label=label;
    label.font=[UIFont systemFontOfSize:20.0];
    label.enabled = NO;
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [ self.textView addSubview:label];

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        
        if([self.delegate respondsToSelector:@selector(keyBoardViewHide: textView:)]){
        
            [self.delegate keyBoardViewHide:self textView:self.textView];
        }
        return NO;
    }
    
    return YES;
}
-(void)sendClick{
    if([self.delegate respondsToSelector:@selector(sendClassComment)]){
        
        [self.delegate sendClassComment];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
      NSString *content=textView.text;
    if ([textView.text length] == 0) {
        [_label setHidden:NO];
    }else{
        [_label setHidden:YES];
    }

      CGSize contentSize=[content sizeWithFont:[UIFont systemFontOfSize:20.0]];
      if(contentSize.width>self.textViewWidth){
          
          if(!self.isChange){
              
              CGRect keyFrame=self.frame;
              self.originalKey=keyFrame;
              keyFrame.size.height+=keyFrame.size.height;
              keyFrame.origin.y-=keyFrame.size.height*0.25;
              self.frame=keyFrame;
              
              CGRect textFrame=self.textView.frame;
              self.originalText=textFrame;
              textFrame.size.height+=textFrame.size.height*0.5+kStartLocation*0.2;
              self.textView.frame=textFrame;
              self.isChange=YES;
              self.reduce=YES;
            }
      }
    
    if(contentSize.width<=self.textViewWidth){
        
        if(self.reduce){
            
            self.frame=self.originalKey;
            self.textView.frame=self.originalText;
            self.isChange=NO;
            self.reduce=NO;
       }
    }
}
@end
