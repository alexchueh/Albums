//
//  PhotosCollectionModel.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseModel.h"
#import "IDMPhotoBrowser.h"

@interface PhotosCollectionModel : BaseModel
typedef void (^Completion)(BOOL succeed, NSError *error);

+ (PhotosCollectionModel *)sharedInstance;

/**
 *  相簿資料的Array
 */
@property (nonatomic, strong) NSMutableArray *photosArray;
/**
 *  Large Size圖片的Array
 */
@property (nonatomic, strong) NSMutableArray *largeArray;;
@property (nonatomic, copy) NSString *password;

- (void)getPhotosData:(NSString *)userName setID:(NSString *)setID completion:(Completion)completion;

@end
