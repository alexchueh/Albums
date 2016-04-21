//
//  AlbumsCollectionViewCell.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "AlbumsCollectionViewCell.h"
#import "AlbumsCollectionModel.h"

@implementation AlbumsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick:)];
    [self addGestureRecognizer:longPress];
    [self.deleteButton setHidden:YES];
    
}

- (void)longClick:(UILongPressGestureRecognizer *)longPress {
    if ([_delegate respondsToSelector:@selector(longClickiconView:)]) {
        [_delegate longClickiconView:self];
    }
}
/*
 to delete the iconView method
 */
//- (void)deleteIcon {
//    if ([_delegate respondsToSelector:@selector(deleteIconView:)]) {
//        [_delegate deleteIconView:self];
//    }
//}

- (IBAction)deleteClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(deleteIconView:index:)]) {
        [_delegate deleteIconView:self index:(int)self.tag];
    }
}

@end
