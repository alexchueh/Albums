//
//  AlbumsCollectionView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "AlbumsCollectionView.h"
#import "PhotosViewController.h"
#import "PhotosCollectionModel.h"

@implementation AlbumsCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
    }
    self.albumsCellArray = [NSMutableArray array];
    self.albumsCollectionModel = [AlbumsCollectionModel sharedInstance];
    self.albumsCollectionModel.albumsCollectionView = self;
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.albumsCollectionModel getAlbumsListData:UIAppDelegate.userName completion:^(BOOL succeed, NSError *error) {
            self.canDelete = NO;
            [self.albumsCollectionModel.albumsCollectionView reloadData];
        }];
        [self.header endRefreshing];
    }];
    self.delegate = self;
    self.dataSource = self;
    self.canDelete = NO;

    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self registerNib:[UINib nibWithNibName:@"AlbumsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumsCollectionViewCell"];
    self.userInteractionEnabled = YES;
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //移除AlbumsCell的動畫效果
    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveAnimation object:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.albumsCollectionModel.setfolders count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumsCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dictionary = self.albumsCollectionModel.setfolders[indexPath.row];
    NSString *thumb = dictionary[kThumb];
    NSString *albumsTitle = dictionary[kAlbumsTitle];
    NSString *categoryTitle = dictionary[kCategoryTitleString];
    NSString *totalPictures = [NSString stringWithFormat:@"%@",dictionary[kTotalPictures]];
    NSString *permission = dictionary[kPermission];
    if (self.canDelete) {
        [cell.deleteButton setHidden:NO];
        [cell.layer removeAnimationForKey:kShake];
        [self shaking:cell];
    }else {
        [cell.deleteButton setHidden:YES];
        [cell.layer removeAnimationForKey:kShake];
    }
    cell.delegate = self;
    [cell setTag:indexPath.row];
    [cell.thumbImageView useSDWebImageSetImage:thumb];
    [cell.thumbImageView.layer setCornerRadius:5];
    [cell.albumsTitle setText:albumsTitle];
    [cell.categoryTitle setText:categoryTitle];
    [cell.totalPictures setText:totalPictures];
    [cell.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [cell.categoryIcon setImage:[self.albumsCollectionModel selectImage:permission]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectCollectionIndex = (int)indexPath.row;
    NSDictionary *dictionary = self.albumsCollectionModel.setfolders[self.selectCollectionIndex];
    NSString *setID = dictionary[kAlbumsID];
    NSString *albumsTitle = dictionary[kAlbumsTitle];
    NSString *totalPictures = [NSString stringWithFormat:@"%@",dictionary[kTotalPictures]];
    NSString *permission = dictionary[kPermission];
    //permission為3的時候為密碼相簿，需輸入密碼才可以進入
    if ([permission isEqualToString:@"3"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密碼相簿" message:@"請輸入此相簿的密碼" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確定", nil];
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alertView show];
        return;
    }else {
        
    }
    if ([totalPictures intValue] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"此相簿目前無相片" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    PhotosViewController *photosViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([PhotosViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([PhotosViewController class])];
    photosViewController.title = albumsTitle;
    photosViewController.setID = setID;
    [self.navigationController pushViewController:photosViewController animated:YES];
    NSLog(@"[%@]didSelectItemAtIndexPath[%i]",[self class],(int)indexPath.row);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //左右及中間各間距10
    CGFloat size = (self.frame.size.width - 10 * 3)/ 2;
    return CGSizeMake(size, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //移除AlbumsCell的動畫效果
//    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveAnimation object:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        [textField resignFirstResponder];
        [PhotosCollectionModel sharedInstance].password = textField.text;
        NSDictionary *dictionary = self.albumsCollectionModel.setfolders[self.selectCollectionIndex];
        NSString *setID = dictionary[kAlbumsID];
        NSString *albumsTitle = dictionary[kAlbumsTitle];
        PhotosViewController *photosViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([PhotosViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([PhotosViewController class])];
        photosViewController.title = albumsTitle;
        photosViewController.setID = setID;
        [self.navigationController pushViewController:photosViewController animated:NO];
    }
}

#pragma mark - 長按
- (void)longClickiconView:(AlbumsCollectionViewCell *)albumsCell {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeShakeAnimation:) name:kRemoveAnimation object:nil];
    self.canDelete = YES;
    [self reloadData];
}

- (void)deleteIconView:(AlbumsCollectionViewCell *)albumsCell index:(int)index {
    [UIView animateWithDuration:0.5 animations:^{
        NSDictionary *dictionary = self.albumsCollectionModel.setfolders[index];
        NSString *setID = dictionary[kAlbumsID];
        [[PIXAlbum new] deleteAlbumSetWithSetID:setID completion:^(BOOL succeed, id result, NSError *error) {
            if (succeed) {
                [self.albumsCollectionModel.setfolders removeObjectAtIndex:index];
                [self performBatchUpdates:^{
                    [self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.numberOfSections)]];
                } completion:nil];
            }else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"刪除失敗" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
//        [self performBatchUpdates:^{
//            [self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.numberOfSections)]];
//        } completion:nil];
//        [views removeObject:albumsCell];
//        [albumsCell removeFromSuperview];
//        [self reloadData];
//        int count = (int)views.count;
//        int count2 = self.frame.size.width / 60;
//        for (int i = 0; i < count; i++) {
//            IconView *item = _subViews[i];
//            item.tag = i;
//            //frame
//            item.frame = CGRectMake(i * 60 + 10, 10, 60, kDockHeight);
//        }
    }];
}

- (void)removeShakeAnimation:(NSNotification*)notification {
    if (self.canDelete) {
        self.canDelete = NO;
        [self reloadData];
    }
}

#pragma mark - 抖動動畫
- (void)shaking:(AlbumsCollectionViewCell *)view {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(Angle2Radian(-1)),  @(Angle2Radian(1)), @(Angle2Radian(-1))];
    anim.duration = 0.2;
    // 動畫重複執行次數
    anim.repeatCount = MAXFLOAT;
    
    // 保持動畫執行完畢後的狀態
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:anim forKey:kShake];
}


@end
