//
//  CheckHasLogin.m
//  BlogReader
//
//  Created by shadow on 2015/8/18.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import "CheckHasLogin.h"
#import "Global.h"

@interface CheckHasLogin ()
@property (nonatomic, assign) BOOL hasLogin;
@end

@implementation CheckHasLogin

+ (CheckHasLogin *)sharedInstance {
    static id checkHasLogin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checkHasLogin = [[CheckHasLogin alloc]init];
    });
    return checkHasLogin;
}

- (BOOL)checkHasLogin {
    self.hasLogin = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *pixnetToken = [defaults objectForKey:kPixnetToken];
    if ([pixnetToken length] > 0) {
        self.hasLogin = YES;
    }
    return self.hasLogin;
}

@end
