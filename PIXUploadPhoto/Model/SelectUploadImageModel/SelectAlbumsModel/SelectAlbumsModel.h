//
//  SelectAlbumsModel.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseModel.h"

@interface SelectAlbumsModel : BaseModel

+ (SelectAlbumsModel *)sharedInstance;

/**
 *  相簿列表資料
 */
@property (nonatomic, strong) NSArray *albumsArray;
/**
 *  選取上傳相簿的TableView
 */
@property (nonatomic, strong) UITableView *selectAlbumsTableView;
/**;
 *  取得相簿列表資料
 *
 */
- (void)getAlbumsFolder;
@end
