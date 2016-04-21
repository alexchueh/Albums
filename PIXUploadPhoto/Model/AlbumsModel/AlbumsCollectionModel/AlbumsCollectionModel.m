//
//  AlbumsCollectionModel.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/11.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "AlbumsCollectionModel.h"

@implementation AlbumsCollectionModel

+ (AlbumsCollectionModel *)sharedInstance {
    static id albumsCollectionModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        albumsCollectionModel = [[AlbumsCollectionModel alloc]init];
    });
    return albumsCollectionModel;
}

- (void)getAlbumsListData:(NSString *)userName completion:(Completion)completion {
    [[PIXAlbum new] getAlbumSetsWithUserName:UIAppDelegate.userName parentID:nil trimUser:NO page:1 perPage:100 shouldAuth:NO completion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            NSDictionary *dictionary = (NSDictionary *)result;
            NSArray *array = dictionary[@"sets"];
            self.setfolders = [NSMutableArray array];
            for (int i = 0 ; i < [array count] ; i++) {
                NSDictionary *dictionary = array[i];
                self.thumb = dictionary[kThumb];
                self.albumsID = dictionary[kAlbumsID];
                self.albumsTitle = dictionary[kAlbumsTitle];
                self.categoryTitle = dictionary[kCategoryTitleString];
                self.permission = dictionary[kPermission];
                self.totalPictures = [NSString stringWithFormat:@"%@",dictionary[kTotalPictures]];
                
                NSMutableDictionary *new = [NSMutableDictionary dictionary];
                [new setObject:self.thumb forKey:kThumb];
                [new setObject:self.albumsID forKey:kAlbumsID];
                [new setObject:self.albumsTitle forKey:kAlbumsTitle];
                [new setObject:self.categoryTitle forKey:kCategoryTitleString];
                [new setObject:self.permission forKey:kPermission];
                [new setObject:self.totalPictures forKey:kTotalPictures];
                [self.setfolders addObject:new];
            }
            completion(succeed,error);
        }
    }];
}

- (UIImage *)selectImage:(NSString *)permission {
    UIImage *image = nil;
    int type = [permission intValue];
    switch (type) {
        case 0: {//完全開放
            image = [UIImage imageNamed:@"eye"];
        }
            break;
        case 1: {//好友相簿
            image = [UIImage imageNamed:@"friend"];
        }
            break;
        case 2: {
            
        }
            break;
        case 3: {//密碼相簿
            image = [UIImage imageNamed:@"key"];
        }
            break;
        case 4: {
            
        }
            break;
        case 5: {//好友群組相簿
            image = [UIImage imageNamed:@"friends"];
        }
            break;
            
        default:
            break;
    }
    return image;
}

@end
