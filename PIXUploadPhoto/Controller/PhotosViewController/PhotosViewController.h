//
//  PhotosViewController.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotosViewController : BaseViewController<UIAlertViewDelegate>

/**
 *  相簿ID
 */
@property (nonatomic, copy) NSString *setID;

@end
