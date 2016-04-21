//
//  CheckHasLogin.h
//  BlogReader
//
//  Created by shadow on 2015/8/18.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckHasLogin : NSObject

+ (CheckHasLogin *)sharedInstance;

- (BOOL)checkHasLogin;

@end
