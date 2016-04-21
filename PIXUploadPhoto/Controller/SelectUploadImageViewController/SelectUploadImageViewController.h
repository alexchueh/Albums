//
//  SelectUploadImageViewController.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseViewController.h"
#import "ZYQAssetPickerController.h"
#import "SelectAlbumsTableView.h"

@interface SelectUploadImageViewController : BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate>

@property (nonatomic, strong) SelectAlbumsTableView *selectAlbumsTableView;
@property (nonatomic, strong) NSMutableArray *selectImageArray;

@end
