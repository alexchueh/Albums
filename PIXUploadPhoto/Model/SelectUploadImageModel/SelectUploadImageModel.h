//
//  SelectUploadImageModel.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseModel.h"

typedef void (^UploadImageCallback)(BOOL succeed, NSError *error);

@interface SelectUploadImageModel : BaseModel

+ (SelectUploadImageModel *)sharedInstance;

- (void)uploadImageToPIXNETAlbums:(UIImage *)image parameters:(NSMutableDictionary *)parameters uploadImageCallback:(UploadImageCallback)uploadImageCallback;

@end
