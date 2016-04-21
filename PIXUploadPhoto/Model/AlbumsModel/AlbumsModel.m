//
//  AlbumsModel.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/6.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "AlbumsModel.h"
#import "AlbumsCollectionModel.h"
#import "SelectAlbumsModel.h"

@implementation AlbumsModel

+ (AlbumsModel *)sharedInstance {
    static id albumsModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        albumsModel = [[AlbumsModel alloc]init];
    });
    return albumsModel;
}

- (NSArray *)getCategory {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CategoryArray" ofType:@"plist"];
    NSArray *categoryArray = [NSArray arrayWithContentsOfFile:plistPath];
    return categoryArray;
}

-(NSArray *)getCompetence {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CompetenceArray" ofType:@"plist"];
    NSArray *competenceArray = [NSArray arrayWithContentsOfFile:plistPath];
    return competenceArray;
}

- (void)setAlbumsData:(NSString *)value key:(NSString *)key {
    [self.albumsDictionary setObject:value forKey:key];
}

- (void)creatAlbumsDictionary {
    self.albumsDictionary = [NSMutableDictionary dictionary];
}

- (BOOL)checkData:(NSDictionary *)dictionary {
    BOOL canCreat = YES;
    self.albumsTitle = dictionary[kAlbumsName];
    self.albumsDescription = dictionary[kAlbumsDescription];
    self.categoryID = dictionary[kCategoryID];
    self.competenceID = dictionary[kCompetenceID];
    self.albumsPassword = dictionary[kAlbumsPassword];
    self.albumsPrompt = dictionary[kAlbumsPrompt];
    NSMutableString *alertString = [NSMutableString string];
    if (self.albumsTitle.length == 0) {
        [alertString appendString:@"您尚未輸入相簿標題，請再一次檢查\n"];
        canCreat = NO;
    }
    if (self.albumsDescription.length == 0) {
        [alertString appendString:@"您尚未輸入相簿描述，請再一次檢查\n"];
        canCreat = NO;
    }
    if (self.categoryID.length == 0) {
        [alertString appendString:@"您尚未選擇相簿分類，請再一次檢查\n"];
        canCreat = NO;
    }
    if (self.competenceID.length == 0) {
        [alertString appendString:@"您尚未選擇閱讀權限，請再一次檢查\n"];
        canCreat = NO;
    }
    if ([self.competenceID isEqualToString:@"3"] && [self.albumsPassword length] == 0 ){
        [alertString appendString:@"您選擇隱藏相簿，請填寫密碼\n"];
        canCreat = NO;
    }
    if (alertString.length > 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    return canCreat;
}

- (void)creatAlbumsSets:(Completion)completion {
    [MRProgressOverlayView showOverlayAddedTo:self.albumsView title:@"相簿新增中..." mode:MRProgressOverlayViewModeIndeterminate animated:YES];
    [[PIXAlbum new] createAlbumSetWithTitle:self.albumsTitle description:self.albumsDescription permission:[self.competenceID intValue] categoryID:self.categoryID isLockRight:0 isAllowCC:0 commentRightType:0 password:self.albumsPassword passwordHint:self.albumsPrompt friendGroupIDs:nil allowCommercialUse:0 allowDerivation:0 parentID:0 completion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            [[AlbumsCollectionModel sharedInstance] getAlbumsListData:UIAppDelegate.userName completion:^(BOOL succeed, NSError *error) {
//                [[AlbumsCollectionModel sharedInstance].albumsCollectionView reloadData];
                [[AlbumsCollectionModel sharedInstance].albumsCollectionView performBatchUpdates:^{
                    [[AlbumsCollectionModel sharedInstance].albumsCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
                } completion:nil];
                [[SelectAlbumsModel sharedInstance] getAlbumsFolder];
                [[SelectAlbumsModel sharedInstance].selectAlbumsTableView reloadData];
            }];
            completion(succeed,error);
            [MRProgressOverlayView showOverlayAddedTo:self.albumsView title:@"新增完成" mode:MRProgressOverlayViewModeCheckmark animated:YES];
        }
        [self performBlock:^{
            [MRProgressOverlayView dismissAllOverlaysForView:self.albumsView animated:YES];
        } afterDelay:1.0];
        
        
//        [SVProgressHUD dismiss];

    }];
}

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
@end
