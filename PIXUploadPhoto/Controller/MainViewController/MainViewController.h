//
//  MainViewController.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/4.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MainViewController : UITabBarController<UITabBarControllerDelegate>
/**
 *  最後選的Tab，用來記錄當上傳相片頁面關閉時應切換回哪個Tab
 */
@property (nonatomic, assign) NSInteger lastSelectTab;

@end
