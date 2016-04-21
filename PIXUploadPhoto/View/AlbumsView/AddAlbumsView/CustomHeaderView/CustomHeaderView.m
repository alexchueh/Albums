//
//  CustomHeaderView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "CustomHeaderView.h"

@implementation CustomHeaderView


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self addSubview:[self creatHeaderView:rect headerTitle:self.title]];
}

- (UIView *)creatHeaderView:(CGRect)frame headerTitle:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string = title;
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    return view;
}

@end
