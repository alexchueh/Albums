//
//  PhotosCollectionModel.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "PhotosCollectionModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PhotosCollectionModel

+ (PhotosCollectionModel *)sharedInstance {
    static id photosCollectionModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photosCollectionModel = [[PhotosCollectionModel alloc]init];
    });
    return photosCollectionModel;
}

- (void)getPhotosData:(NSString *)userName setID:(NSString *)setID completion:(Completion)completion {
    self.photosArray = [NSMutableArray array];
    self.largeArray = [NSMutableArray array];
    [[PIXAlbum new] getAlbumSetElementsWithUserName:userName setID:setID elementType:PIXAlbumElementTypePic page:1 perPage:100 password:self.password withDetail:1 trimUser:0 shouldAuth:0 completion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            NSArray *array = result[@"elements"];
            self.photosArray = [array mutableCopy];
            for (int i = 0 ; i < [array count] ; i++) {
                NSDictionary *dictionary = array[i];
                NSString *large = dictionary[kLarge];
                NSURL *url = [NSURL URLWithString:large];
                IDMPhoto *photo = [IDMPhoto photoWithURL:url];
                [self.largeArray addObject:photo];
            }
            completion (succeed, error);
        }else {
            completion (succeed, error);
        }
    }];
}

@end
