//
//  AppDelegate.h
//  PIXUploadPhoto
//
//  Created by shadow on 2015/12/30.
//  Copyright © 2015年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CheckHasLogin.h"
#import "UIColor+PIXCategory.h"
#import "APIObject.h"
#import "UIImageView+SDWebImage.h"
#import "ActionSheetPicker.h"
#import "PIXNETSDK.h"
#import "MJRefresh.h"
#import "TSMessage.h"
#import "ReactiveCocoa.h"
#import "MJRefreshStateHeader.h"
#import "MRProgress.h"
#import "OneSignal/OneSignal.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *userName;
@property (strong, nonatomic) OneSignal *oneSignal;

@end

