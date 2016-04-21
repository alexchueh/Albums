//
//  SelectAlbumsModel.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "SelectAlbumsModel.h"
#import "AlbumsCollectionModel.h"

@implementation SelectAlbumsModel

+ (SelectAlbumsModel *)sharedInstance {
    static id selectAlbumsModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectAlbumsModel = [[SelectAlbumsModel alloc]init];
    });
    return selectAlbumsModel;
}

- (void)getAlbumsFolder {
    self.albumsArray = [AlbumsCollectionModel sharedInstance].setfolders;
}

@end
