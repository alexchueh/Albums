//
//  BaseTableViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/4.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor PIXBackgroundBlanchedAlmondColor]];
    self.navigationController.navigationBar.translucent = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

@end
