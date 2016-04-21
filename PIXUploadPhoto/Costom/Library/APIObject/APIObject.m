//
//  APIObject.m
//  BlogReader
//
//  Created by shadow on 2015/8/7.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import "APIObject.h"

@implementation APIObject

-(void)getAPIData:(NSString *)urlString parameters:(NSDictionary *)parameters httpMethod:(HttpMethodType)httpMethod isInBackgroundUploadData:(BOOL)isInBackgroundUploadData callback:(ApiCallback)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted]];
    manager.requestSerializer.timeoutInterval = 10;
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    if (isInBackgroundUploadData == NO) {
        [SVProgressHUD showWithStatus:@"載入中..." maskType:SVProgressHUDMaskTypeNone];
    }
    switch (httpMethod) {
        case HttpMethodTypePOST:
        {
            [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
                callback(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                callback(nil, error);
                [self showInterNetErrorMessage:(int)error.code];
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
            }];
        }
            break;
        case HttpMethodTypeGET:
        {
            [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
                callback(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                callback(nil, error);
                [self showInterNetErrorMessage:(int)error.code];
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
            }];
        }
            break;
        case HttpMethodTypePUT:
        {
            [manager PUT:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
                callback(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                callback(nil, error);
                [self showInterNetErrorMessage:(int)error.code];
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
            }];
        }
            break;
            
        case HttpMethodTypeDELETE:
        {
            [manager DELETE:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
                callback(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                callback(nil, error);
                [self showInterNetErrorMessage:(int)error.code];
                if (isInBackgroundUploadData == NO) {
                    [SVProgressHUD dismiss];
                }
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)uploadImage:(UIImage *)image parameters:(NSMutableDictionary *)parameters uploadImageCallback:(UploadImageCallback)uploadImageCallback {
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    if (image) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        parameters[@"access_token"] = [defaults objectForKey:kPixnetToken];
    }
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@album/elements",kServiceDomain]
                                    parameters:parameters
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                         [formData appendPartWithFileData:imageData
                                                     name:@"upload_file"
                                                 fileName:@"photo.jpg"
                                                 mimeType:@"image/jpeg"];
                     }];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                         NSLog(@"Success %@", responseObject);
                                         uploadImageCallback(YES,nil);
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Failure %@", error.description);
                                         uploadImageCallback(NO,error);
                                     }];
    
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        //        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
        //        CGFloat percentage = (float)totalBytesWritten/(float)totalBytesExpectedToWrite;
        
    }];
    [operation start];
}


-(void)showInterNetErrorMessage:(int)errorCode
{
    NSString *message = nil;
    switch (errorCode) {
        case -1009:
            message = @"網路連線異常請確認";
            break;
            
        default:
            break;
    }
    if ([message length] > 0)
    {
//        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:message];
//        [alertView addButtonWithTitle:@"確定"
//                                 type:SIAlertViewButtonTypeDestructive
//                              handler:^(SIAlertView *alert) {
//                              }];
//        [alertView show];
    }
}

@end
