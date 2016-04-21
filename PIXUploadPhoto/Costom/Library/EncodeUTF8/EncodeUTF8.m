//
//  EncodeUTF8.m
//  BlogReader
//
//  Created by shadow on 2015/9/9.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import "EncodeUTF8.h"

@implementation EncodeUTF8

- (NSString *)encodeURL:(NSString*)unescapedString {
    NSString* escapedUrlString= (NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)unescapedString, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    return escapedUrlString;
    return escapedUrlString;
}

@end
