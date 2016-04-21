//
//  NSString+DeleteBlankText.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DeleteBlankText)

/**
 *  當最後一個字為空白的時候將它刪除
 *
 *  @param string 調整前的文字
 *
 *  @return 刪除後的文字
 */
-(NSString *)whenLastTextIsBlankDelete:(NSString *)string;

@end
