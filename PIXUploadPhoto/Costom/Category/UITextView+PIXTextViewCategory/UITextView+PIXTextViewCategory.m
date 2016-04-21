//
//  UITextView+PIXTextViewCategory.m
//  Foodie
//
//  Created by shadow on 2015/3/4.
//  Copyright (c) 2015年 PIXNET. All rights reserved.
//

#import "UITextView+PIXTextViewCategory.h"

@implementation UITextView (PIXTextViewCategory)

-(void)setToolBar
{
    PIXToolbar *toolbar = [[PIXToolbar alloc]initWithFrame:CGRectMake(0.0 , 0.0 , self.frame.size.width , 44.0)];
    [toolbar setType:AccessoryTypeClearCancelDone];
    [toolbar setPIXDeleage:self];
    [self setInputAccessoryView:toolbar];
}

#pragma mark PIXTextFieldAccessoryViewDeleage
- (void)accessoryViewClearBtnDidClicked:(NSInteger)viewTag
{
    self.text = @"";
}

- (void)accessoryViewCancelBtnDidClicked:(NSInteger)viewTag
{
    [self resignFirstResponder];
}

- (void)accessoryViewDoneBtnDidClicked:(NSInteger)viewTag
{
    [self resignFirstResponder];
}

@end
