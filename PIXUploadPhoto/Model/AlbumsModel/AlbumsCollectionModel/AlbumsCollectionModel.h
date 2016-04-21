//
//  AlbumsCollectionModel.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/11.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseModel.h"

@interface AlbumsCollectionModel : BaseModel
typedef void (^Completion)(BOOL succeed, NSError *error);

+ (AlbumsCollectionModel *)sharedInstance;

/**
 *  取得相簿列表資料
 *
 *  @param userName   使用者名稱
 *  @param completion 完成下載後告知結果
 */
- (void)getAlbumsListData:(NSString *)userName completion:(Completion)completion;
/**
 *  取得分類圖片
 *
 *  @param permission 分類
 *
 *  @return 回傳圖片
 */
- (UIImage *)selectImage:(NSString *)permission;

@property (nonatomic, strong) UICollectionView *albumsCollectionView;
/**
 *  相簿列表
 */
@property (nonatomic, strong) NSMutableArray *setfolders;
/**
 *  相簿封面圖片
 */
@property (nonatomic, copy) NSString *thumb;
/**
 *  相簿ID
 */
@property (nonatomic, copy) NSString *albumsID;
/**
 *  相簿名稱
 */
@property (nonatomic, copy) NSString *albumsTitle;
/**
 *  分類名稱
 */
@property (nonatomic, copy) NSString *categoryTitle;
/**
 *  相簿照片總數量
 */
@property (nonatomic, copy) NSString *totalPictures;
/**
 *  權限分類ID
 */
@property (nonatomic, copy) NSString *permission;

@end
