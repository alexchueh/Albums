//
//  AlbumsCollectionViewCell.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlbumsCollectionViewCell;

@protocol LongPressIconDelegate <NSObject>

- (void)longClickiconView:(AlbumsCollectionViewCell *)albumsCell;

- (void)deleteIconView:(AlbumsCollectionViewCell *)albumsCell index:(int)index;

@end

@interface AlbumsCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<LongPressIconDelegate> delegate;

/**
 *  刪除相簿按鈕
 */
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
/**
 *  相簿封面圖面
 */
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
/**
 *  相簿名稱
 */
@property (weak, nonatomic) IBOutlet UILabel *albumsTitle;
/**
 *  分類名稱
 */
@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
/**
 *  相簿照片總數量
 */
@property (weak, nonatomic) IBOutlet UILabel *totalPictures;
/**
 *  分類圖示
 */
@property (weak, nonatomic) IBOutlet UIImageView *categoryIcon;
@end
