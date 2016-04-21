//
//  CompetenceTableView.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/7.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseTableView.h"
#import "AlbumsModel.h"
#import "PhotosModel.h"

@interface CompetenceTableView : BaseTableView<UITextFieldDelegate>

/**
 *  相簿的Model
 */
@property (nonatomic, strong) AlbumsModel *albumsModel;
/**
 *  相片的Model
 */
@property (nonatomic, strong) PhotosModel *photosModel;
/**
 *  瀏覽權限分類
 */
@property (nonatomic, strong) NSArray *competenceArray;
/**
 *  Albums的AlertView，用來在點選TableCell後關閉
 */
@property (nonatomic, strong) CustomIOSAlertView *alertView;
/**
 *  紀錄選取哪個TableCell
 */
@property (nonatomic, strong) NSIndexPath *lastIndexPath;
/**
 *  紀錄選取的瀏覽權限物件
 */
@property (nonatomic, copy) NSDictionary *competenceDictionary;
/**
 *  是否設定密碼
 */
@property (nonatomic, assign) BOOL needPassword;

@end
