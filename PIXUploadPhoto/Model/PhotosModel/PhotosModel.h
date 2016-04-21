//
//  PhotosModel.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/2/2.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseModel.h"

@interface PhotosModel : BaseModel
typedef void (^Completion)(BOOL succeed, NSError *error);
+ (PhotosModel *)sharedInstance;

@property (nonatomic, strong) NSMutableDictionary *albumsDictionary;
/**
 *  初始化相簿物件資料
 */
- (void)creatAlbumsDictionary;
/**
 *  將新增相簿資料存入
 *
 *  @param value 存入的資料
 *  @param key   存入的參數
 */
- (void)setAlbumsData:(NSString *)value key:(NSString *)key;
/**
 *  檢查必傳資料是否填寫
 *
 *  @param dictionary 要傳送的資料
 *
 *  @return 回傳是或否
 */
- (BOOL)checkData:(NSDictionary *)dictionary;
/**
 *  修改相簿
 */
- (void)fixAlbumsSets:(Completion)completion;
/**
 *  相簿ID
 */
@property (nonatomic, copy) NSString *setID;
/**
 *  相簿標題
 */
@property (nonatomic, copy) NSString *albumsTitle;
/**
 *  相簿描述
 */
@property (nonatomic, copy) NSString *albumsDescription;
/**
 *  相簿分類ID
 */
@property (nonatomic, copy) NSString *categoryID;
/**
 *  相簿權限ID
 */
@property (nonatomic, copy) NSString *competenceID;
/**
 *  相簿密碼
 */
@property (nonatomic, copy) NSString *albumsPassword;
/**
 *  相簿密碼提示
 */
@property (nonatomic, copy) NSString *albumsPrompt;
/**
 *  在albumsView顯示MRProgressOverlayView
 */
@property (nonatomic, strong) UIView *albumsView;

@end
