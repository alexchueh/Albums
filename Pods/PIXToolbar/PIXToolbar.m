//
//  PIXToolbar.m
//  PIXTextView
//
//  Created by shadow on 2015/1/20.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import "PIXToolbar.h"

@implementation PIXToolbar

- (void)setType:(AccessoryType)type
{
    switch (type)
    {
        case AccessoryTypeClearCancelDone:
        {
            
            UIBarButtonItem *clearBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearBtnItemClicked:)];
            
            UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            /*
             UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnItemClicked:)];
             */
            
            UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnItemClicked:)];
            
            
            /*
             UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnItemClicked:)];
             */
            
            UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"確認" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnItemClicked:)];
            
            
            NSArray *items = [NSArray arrayWithObjects:clearBtnItem, spaceItem, cancelBtnItem, doneBtnItem, nil];
            [self setItems:items];
        }
            break;
        default:
            break;
    }
}

- (void)clearBtnItemClicked:(id)sender
{
    
    if (self.PIXDeleage && [self.PIXDeleage respondsToSelector:@selector(accessoryViewClearBtnDidClicked:)])
    {
        [self.PIXDeleage accessoryViewClearBtnDidClicked:self.tag];
    }
    
}

- (void)cancelBtnItemClicked:(id)sender
{
    if (self.PIXDeleage && [self.PIXDeleage respondsToSelector:@selector(accessoryViewClearBtnDidClicked:)])
    {
        [self.PIXDeleage accessoryViewCancelBtnDidClicked:self.tag];
    }
}

- (void)doneBtnItemClicked:(id)sender
{
    if (self.PIXDeleage && [self.PIXDeleage respondsToSelector:@selector(accessoryViewClearBtnDidClicked:)])
    {
        [self.PIXDeleage accessoryViewDoneBtnDidClicked:self.tag];
    }
}

@end
