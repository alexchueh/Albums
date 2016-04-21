//
//  CustomHeaderView.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseView.h"

@interface CustomHeaderView : BaseView

@property (nonatomic, strong) NSString *title;

- (UIView *)creatHeaderView:(CGRect)frame headerTitle:(NSString *)title;

@end
