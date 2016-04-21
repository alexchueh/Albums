//
//  PasswordTableViewCell.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/7.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "PasswordTableViewCell.h"

@implementation PasswordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)confirmPassword:(id)sender {
    [self.alertView close];
}

@end
