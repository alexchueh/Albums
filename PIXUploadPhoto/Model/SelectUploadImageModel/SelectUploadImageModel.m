//
//  SelectUploadImageModel.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "SelectUploadImageModel.h"

@implementation SelectUploadImageModel

+ (SelectUploadImageModel *)sharedInstance {
    static id selectUploadImageModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectUploadImageModel = [[SelectUploadImageModel alloc]init];
    });
    return selectUploadImageModel;
}

- (void)uploadImageToPIXNETAlbums:(UIImage *)image parameters:(NSMutableDictionary *)parameters uploadImageCallback:(UploadImageCallback)uploadImageCallback {
    [[APIObject new] uploadImage:image parameters:parameters uploadImageCallback:^(BOOL succeed, NSError *error) {
        if (succeed) {
            uploadImageCallback(succeed,nil);
        }else {
            uploadImageCallback(succeed,error);
        }
        
    }];
}

@end
