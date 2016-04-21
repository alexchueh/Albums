//
//  UIColor+PIXCategory.m
//  BlogReader
//
//  Created by Dolphin Su on 8/21/15.
//  Copyright © 2015 shadow. All rights reserved.
//

#import "UIColor+PIXCategory.h"

@implementation UIColor (PIXCategory)
+(instancetype)PIXTableViewSeparatorGrayColor {
    return  [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
}
+(instancetype)PIXTextDarkGrayColor{
    return [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
}
+(instancetype)PIXBackgroundGrayColor{
    return [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
}
+(instancetype)PIXNavigationBarLightBlueColor{
    return [UIColor colorWithRed:255.0/255.0 green:221.0/255.0 blue:170.0/255.0 alpha:1.0];
//    return [UIColor colorWithRed:40.0/255.0 green:148.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+(instancetype)PIXNavigationBarTintColor {
    return [UIColor colorWithRed:255.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1.0];
}

+(instancetype)PIXBackgroundBlanchedAlmondColor {
    return [UIColor colorWithRed:255.0/255.0 green:235.0/255.0 blue:205.0/255.0 alpha:1.0];
}

+(instancetype)PIXTableViewHeaderTextColor {
    return [UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0];
}
@end
