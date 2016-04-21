//
//  UITextField+PIXTextFieldCategory.h
//  PixnetPanel
//
//  Created by shadow on 2015/1/21.
//  Copyright (c) 2015年 PIXNET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PIXToolbar.h>

@interface UITextField (PIXTextFieldCategory)<PIXTextFieldAccessoryViewDeleage>

-(void)setToolBar;

@end
