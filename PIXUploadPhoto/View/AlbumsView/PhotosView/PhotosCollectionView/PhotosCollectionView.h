//
//  PhotosCollectionView.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseCollectionView.h"
#import "RACollectionViewReorderableTripletLayout.h"
#import "MJRefresh.h"
#import "IDMPhotoBrowser.h"
#import "PhotosCollectionViewCell.h"

@interface PhotosCollectionView : BaseCollectionView<RACollectionViewDelegateReorderableTripletLayout, RACollectionViewReorderableTripletLayoutDataSource,IDMPhotoBrowserDelegate,DeleteIconDelegate>

/**
 *  相簿資料的Array
 */
@property (nonatomic, strong) NSMutableArray *photosArray;
/**
 *  Large Size圖片的Array
 */
@property (nonatomic, strong) NSMutableArray *largeArray;
/**
 *  PhotoViewController的ViewController
 */
@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, assign) BOOL canDelete;

@end
