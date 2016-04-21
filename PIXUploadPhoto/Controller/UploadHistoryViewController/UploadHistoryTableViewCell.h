//
//  UploadHistoryTableViewCell.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/2/4.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadHistoryTableViewCell : UITableViewCell

/**
 *  上傳至哪本相簿
 */
@property (weak, nonatomic) IBOutlet UILabel *albumsPath;
/**
 *  上傳狀態
 */
@property (weak, nonatomic) IBOutlet UILabel *status;
///**
// *  上傳數量
// */
//@property (weak, nonatomic) IBOutlet UILabel *uploadCount;
/**
 *  上傳日期
 */
@property (weak, nonatomic) IBOutlet UILabel *uploadDate;
@end
