//
//  UITextView+PIXTextViewCategory.h
//  Foodie
//
//  Created by shadow on 2015/3/4.
//  Copyright (c) 2015年 PIXNET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PIXToolbar.h>

@interface UITextView (PIXTextViewCategory)<PIXTextFieldAccessoryViewDeleage>

-(void)setToolBar;

@end
