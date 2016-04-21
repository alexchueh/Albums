//
//  PhotosCollectionView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "PhotosCollectionView.h"
#import "PhotosCollectionModel.h"

@implementation PhotosCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
    }

    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block

        [self.header endRefreshing];
    }];
    self.delegate = self;
    self.dataSource = self;
    self.canDelete = NO;
    [self registerNib:[UINib nibWithNibName:@"PhotosCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotosCollectionViewCell"];
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photosArray count];
}

- (CGFloat)sectionSpacingForCollectionView:(UICollectionView *)collectionView {
    return 5.f;
}

- (CGFloat)minimumInteritemSpacingForCollectionView:(UICollectionView *)collectionView {
    return 5.f;
}

- (CGFloat)minimumLineSpacingForCollectionView:(UICollectionView *)collectionView {
    return 5.f;
}

- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView {
    return UIEdgeInsetsMake(5.f, 0, 5.f, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForLargeItemsInSection:(NSInteger)section {
    return RACollectionViewTripletLayoutStyleSquare;
}

- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView {
    return UIEdgeInsetsMake(50.f, 0, 50.f, 0);
}

- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView {
    return UIEdgeInsetsMake(64.f, 0, 0, 0);
}

- (CGFloat)reorderingItemAlpha:(UICollectionView *)collectionview {
    return .3f;
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath {
    //因移動過CollectionView item故將Array重新排列
    NSObject *image = [self.photosArray objectAtIndex:fromIndexPath.item];
    [self.photosArray removeObjectAtIndex:fromIndexPath.item];
    [self.photosArray insertObject:image atIndex:toIndexPath.item];
    
    IDMPhoto *IDMPhoto = [self.largeArray objectAtIndex:fromIndexPath.item];
    [self.largeArray removeObjectAtIndex:fromIndexPath.item];
    [self.largeArray insertObject:IDMPhoto atIndex:toIndexPath.item];
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotosCollectionViewCell" forIndexPath:indexPath];
    if (self.canDelete) {
        [cell.deleteButton setHidden:NO];
//        [cell.layer removeAnimationForKey:kShake];
//        [self shaking:cell];
    }else {
        [cell.deleteButton setHidden:YES];
//        [cell.layer removeAnimationForKey:kShake];
    }
    cell.delegate = self;
    [cell.imageView removeFromSuperview];
    cell.imageView.frame = cell.bounds;
    [cell.imageView useSDWebImageSetImage:self.photosArray[indexPath.item][kThumb]];
    cell.tag = indexPath.row;
    [cell.contentView addSubview:cell.imageView];
    [cell.contentView addSubview:cell.deleteButton];
    cell.deleteButton.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.canDelete) {
        return;
    }
    //點擊該CollectionView Item展開BrowserView用來瀏覽圖片
    UIImageView *imageView = [(PhotosCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath] imageView];
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:self.largeArray animatedFromView:imageView];
    browser.delegate = self;
    browser.displayActionButton = NO;
    browser.displayArrowButton = YES;
    browser.displayCounterLabel = YES;
    browser.usePopAnimation = YES;
    [browser setInitialPageIndex:indexPath.row];
    IDMPhoto *IDMPhoto = [self.largeArray objectAtIndex:indexPath.item];
    NSURL *url = IDMPhoto.photoURL;
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        browser.scaleImage = image;
    }];
    [self.viewController presentViewController:browser animated:YES completion:nil];
}

#pragma mark - DeleteClickDelegate 

- (void)deleteIconView:(PhotosCollectionViewCell *)albumsCell index:(int)index {
    NSDictionary *dictionary = self.photosArray[index];
    NSString *elementID = dictionary[kElementID];
    [UIView animateWithDuration:0.5 animations:^{
        [self.photosArray removeObjectAtIndex:index];
        [self.largeArray removeObjectAtIndex:index];
        [self performBatchUpdates:^{
            [self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.numberOfSections)]];
        } completion:nil];
    }];
    [[PIXAlbum new] deleteElementWithElementID:elementID completion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            
        }else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"刪除失敗" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}

#pragma mark - 抖動動畫
- (void)shaking:(PhotosCollectionViewCell *)view {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(Angle2Radian(-.3)),  @(Angle2Radian(.3)), @(Angle2Radian(-.3))];
    anim.duration = 0.2;
    // 動畫重複執行次數
    anim.repeatCount = MAXFLOAT;
    
    // 保持動畫執行完畢後的狀態
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:anim forKey:kShake];
}

@end
