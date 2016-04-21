//
//  ProfileViewController.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseViewController.h"
#import "ASProgressPopUpView.h"

@interface ProfileViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
/**
 *  使用者的大頭照
 */
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
/**
 *  使用者名稱
 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/**
 *  相簿數量
 */
@property (weak, nonatomic) IBOutlet UILabel *albumsCount;
/**
 *  相片數量
 */
@property (weak, nonatomic) IBOutlet UILabel *picturesCount;
/**
 *  本月上傳流量Icon
 */
@property (weak, nonatomic) IBOutlet UIImageView *uploadImageView;
/**
 *  空間使用情況Icon
 */
@property (weak, nonatomic) IBOutlet UIImageView *spaceUsedImageView;

@end
