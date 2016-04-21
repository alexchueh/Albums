//
//  APIObject.h
//  BlogReader
//
//  Created by shadow on 2015/8/7.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "Global.h"

/**
 *  API Call Back的Block方法
 *
 *  @param result 回傳結果
 *  @param error  錯誤資訊
 */
typedef void (^ApiCallback)(id result, NSError *error);

typedef void (^UploadImageCallback)(BOOL succeed, NSError *error);

/**
 *  傳輸型態
 */
typedef NS_ENUM(NSInteger, HttpMethodType){
    /**
     *  POST
     */
    HttpMethodTypePOST = 0,
    /**
     *  GET
     */
    HttpMethodTypeGET = 1,
    /**
     *  PUT
     */
    HttpMethodTypePUT = 2,
    /**
     *  DELETE
     */
    HttpMethodTypeDELETE = 3,
};

@interface APIObject : NSObject

-(void)getAPIData:(NSString *)urlString parameters:(NSDictionary *)parameters httpMethod:(HttpMethodType)httpMethod  isInBackgroundUploadData:(BOOL)isInBackgroundUploadData callback:(ApiCallback)callback;
/**
 *  上傳相片到PIXNET相簿
 *
 *  @param image      要上傳的圖片
 *  @param parameters 要上傳的參數（參考：https://developer.pixnet.pro/#!/doc/pixnetApi/albumElementsCreate）
 */
- (void)uploadImage:(UIImage *)image parameters:(NSMutableDictionary *)parameters uploadImageCallback:(UploadImageCallback)uploadImageCallback;
@end
