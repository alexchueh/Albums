//
//  SelectAlbumsTableView.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseTableView.h"
#import "SelectAlbumsModel.h"
#import "M13ProgressViewRing.h"

@interface SelectAlbumsTableView : BaseTableView

@property (nonatomic, strong) NSArray *albumsArray;
/**
 *  Albums的AlertView，用來在點選TableCell後關閉
 */
@property (nonatomic, strong) CustomIOSAlertView *alertView;
/**
 *  紀錄選取哪個TableViewCell
 */
@property (nonatomic, strong) NSIndexPath *lastIndexPath;
/**
 *  紀錄選取的相簿名稱物件
 */
@property (nonatomic, strong) NSDictionary *albumsDicitonary;
/**
 *  被選取到要上傳的相片
 */
@property (nonatomic, strong) NSMutableArray *selectImageArray;

@property (nonatomic, assign) NSString *uploaded;
@end
