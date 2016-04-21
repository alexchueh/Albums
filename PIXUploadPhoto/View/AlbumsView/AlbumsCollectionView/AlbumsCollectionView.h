//
//  AlbumsCollectionView.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseCollectionView.h"
#import "AlbumsCollectionViewCell.h"
#import "AlbumsCollectionModel.h"

@interface AlbumsCollectionView : BaseCollectionView<UIAlertViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,LongPressIconDelegate>
/**
 *  AlbumsViewController的NavigationController
 */
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) AlbumsCollectionModel *albumsCollectionModel;
@property (nonatomic, assign) int selectCollectionIndex;
/**
 *  相簿的CellArray
 */
@property (nonatomic, strong) NSMutableArray *albumsCellArray;
@property (nonatomic, assign) BOOL canDelete;
@end
