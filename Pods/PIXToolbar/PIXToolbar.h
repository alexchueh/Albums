//
//  PIXToolbar.h
//  PIXTextView
//
//  Created by shadow on 2015/1/20.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PIXTextFieldAccessoryViewDeleage <NSObject>

@optional
/**
 *  清除所有鍵盤上文字
 *
 *  @param viewTag UITextField的Tag
 */
- (void)accessoryViewClearBtnDidClicked:(NSInteger)viewTag;
/**
 *  鍵盤的取消鍵
 *
 *  @param viewTag UITextField的Tag
 */
- (void)accessoryViewCancelBtnDidClicked:(NSInteger)viewTag;
/**
 *  鍵盤的確定鍵
 *
 *  @param viewTag UITextField的Tag
 */
- (void)accessoryViewDoneBtnDidClicked:(NSInteger)viewTag;
@end

@interface PIXToolbar : UIToolbar

/**
 *  鍵盤類型
 */
typedef NS_ENUM(NSInteger, AccessoryType){
    /**
     *  預設(清除，取消，確定)
     */
    AccessoryTypeClearCancelDone = 0,
};

/**
 *  設定鍵盤類型
 *
 *  @param type AccessoryType
 */
- (void)setType:(AccessoryType)type;

@property (assign,nonatomic) id<PIXTextFieldAccessoryViewDeleage>PIXDeleage;

@end
