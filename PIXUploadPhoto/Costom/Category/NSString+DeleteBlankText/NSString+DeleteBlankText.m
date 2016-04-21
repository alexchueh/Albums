//
//  NSString+DeleteBlankText.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "NSString+DeleteBlankText.h"

@implementation NSString (DeleteBlankText)

//當最後一個字為空白的時候將它刪除
-(NSString *)whenLastTextIsBlankDelete:(NSString *)string {
    if ([string hasSuffix:@" "]) {
        NSMutableString *newString = [string mutableCopy];
        [newString deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
        string = newString;
    }
    return string;
}

@end
