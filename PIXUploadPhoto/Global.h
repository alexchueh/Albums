//
//  Global.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/4.
//  Copyright © 2016年 shadow. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define IS_TEST_MODE 0 //送審要用0
#define IS_ARCHIVED 1 //包版和送審要用1

#if IS_TEST_MODE
#define kServiceDomain @""
#else
#define kServiceDomain @"https://emma.pixnet.cc/"
#define kNearByServiceDomain @"https://demoidea.events.pixnet.net/maps2/"
#define kHotBlogerDomain @"https://emma.pixnet.cc/mainpage/blog/hot"

#endif
#define UIAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kPixnetToken @"pixnettoken" //PIXNET使用者登入的Token
#define kAccount @"account" //會員
#define kName @"name" //文章作者
#define kAvatar @"avatar" //大頭照
#define kAlbumsName @"albumsName" //相簿名稱
#define kAlbumsDescription @"albumsDescription" //相簿描述
#define kCategoryTitle @"title" //全站分類名稱
#define kCategoryID @"categoryID" //全站分類ID
#define kCompetenceTitle @"title" //瀏覽權限名稱
#define kCompetenceID @"competenceID" //瀏覽權限ID
#define kAlbumsPassword @"albumsPassword" //相簿密碼
#define kAlbumsPrompt @"albumsPrompt" //相簿密碼提示
#define kQuota @"quota"
#define kAlbumSpaceQuota @"album_space_quota" //相簿可使用總流量
#define kAlbumSpaceUsage @"album_space_usage" //相簿以使用流量
#define kAlbumSpaceLeft @"album_space_left" //相簿剩餘流量
#define kAlbumUploadQuota @"album_upload_quota" //單月上傳流量上限
#define kAlbumUploadUsage @"album_upload_usage" //單月已上傳流量
#define kAlbumUploadLeft @"album_upload_left" //單月剩餘流量

//AlbumsCollectionMode
#define kSetfolders @"setfolders" //相簿列表
#define kThumb @"thumb" //相簿封面圖片
#define kAlbumsID @"id" //相簿ID
#define kElementID @"id" //相片ID
#define kAlbumsTitle @"title" //相簿名稱
#define kCategoryTitleString @"category" //分類名稱
#define kTotalAlbums @"total" //相簿總數量
#define kTotalPictures @"total_pictures" //相簿照片總數量
#define kPermission @"permission" //相簿分類圖示
#define kLarge @"large" //large大小的圖片

//扣掉NavigationBar的高度跟StatusBar的高度
#define IS_OS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define kViewHeight self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height

//TabNotificationCenterName
#define kSelectUploadImage @"SelectUploadImage"
#define kTabBarSecondControllerDisMiss @"TabBarSecondControllerDisMiss"

//AnimationNotificationCenter
#define kShake @"shake"
#define kRemoveAnimation @"removeAnimation"

#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)

//選擇列表的高度
#define kCellHeight 44
#define kPasswordCellHeight 150
#endif /* Global_h */
