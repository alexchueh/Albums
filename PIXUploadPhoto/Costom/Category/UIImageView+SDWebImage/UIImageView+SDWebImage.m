//
//  UIImageView+SDWebImage.m
//  CTBCPayment
//
//  Created by shadow on 2014/8/20.
//  Copyright (c) 2014年 MyBall. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Global.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation UIImageView (SDWebImage)

-(void)useSDWebImageSetImage:(NSString *)imageString {
//    [self sd_setImageWithURL:[NSURL URLWithString:imageString]
//                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
//                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//     {
//         
////         if (image) {
////             [UIView transitionWithView:self
////                               duration:kDuration
////                                options:UIViewAnimationOptionTransitionCrossDissolve
////                             animations:^{
////                                 [self setContentMode:UIViewContentModeScaleAspectFill];
////                                 [self setClipsToBounds:YES];
////                                 [self setImage:image];
////                             } completion:NULL];
////         }
//     }];
//    [self setImageWithURL:[NSURL URLWithString:imageString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    [self setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}


@end
