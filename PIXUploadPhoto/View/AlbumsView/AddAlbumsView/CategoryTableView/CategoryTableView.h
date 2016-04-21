//
//  CategoryTableView.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/6.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseTableView.h"
#import "AlbumsModel.h"

@interface CategoryTableView : BaseTableView

/**
 *  全站瀏覽分類
 */
@property (nonatomic, strong) NSArray *categoryArray;
/**
 *  Albums的AlertView，用來在點選TableCell後關閉
 */
@property (nonatomic, strong) CustomIOSAlertView *alertView;
/**
 *  紀錄選取哪個TableViewCell
 */
@property (nonatomic, strong) NSIndexPath *lastIndexPath;
/**
 *  紀錄選取的瀏覽分類物件
 */
@property (nonatomic, copy) NSDictionary *categoryDictionary;
@end
