//
//  PhotosCollectionViewCell.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "PhotosCollectionViewCell.h"

@implementation PhotosCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.deleteButton = [[UIButton alloc] init];
        self.deleteButton.contentMode = UIViewContentModeScaleAspectFill;
        [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"deleteIcon"] forState:UIControlStateNormal];
        [self.deleteButton setHidden:YES];
        [self.deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.imageView.frame = bounds;
    self.deleteButton.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.imageView.alpha = .7f;
    }else {
        self.imageView.alpha = 1.f;
    }
}

- (IBAction)deleteClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    if ([_delegate respondsToSelector:@selector(deleteIconView:index:)]) {
        [_delegate deleteIconView:self index:(int)button.tag];
    }
}

@end
