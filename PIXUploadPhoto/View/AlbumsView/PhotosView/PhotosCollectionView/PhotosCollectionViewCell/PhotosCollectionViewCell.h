//
//  PhotosCollectionViewCell.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlbumsCollectionViewCell;

@protocol DeleteIconDelegate <NSObject>

- (void)deleteIconView:(AlbumsCollectionViewCell *)albumsCell index:(int)index;

@end

@interface PhotosCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<DeleteIconDelegate> delegate;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *deleteButton;
@end
