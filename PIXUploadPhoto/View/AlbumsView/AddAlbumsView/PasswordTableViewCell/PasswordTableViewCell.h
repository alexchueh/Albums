//
//  PasswordTableViewCell.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/7.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOSAlertView.h"
#import "UIFloatLabelTextField.h"

@interface PasswordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *promptTextField;

/**
 *  Albums的AlertView，用來在點選TableCell後關閉
 */
@property (nonatomic, strong) CustomIOSAlertView *alertView;

@end
