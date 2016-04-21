//
//  MainViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/4.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "AlbumsViewController.h"
#import "SelectUploadImageViewController.h"
#import "ProfileViewController.h"
#import "UploadHistoryViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastSelectTab = 0;
    self.delegate = self;
//    [[UITabBar appearance] setBarTintColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
    CheckHasLogin *checkHasLogin = [CheckHasLogin sharedInstance];
    if ([checkHasLogin checkHasLogin] == NO) {
        LoginViewController *loginViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([LoginViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }else {
        static BOOL isFirst = YES;
        if (isFirst) {
            [self setTabBarController];
            isFirst = NO;
        }
    }
}

- (void)refreshToken {
    
    //https://emma.pixnet.cc/oauth2/grant?grant_type=refresh_token&refresh_token={refresh_token}&client_id={client_id}&client_secret={client_secret}
}

- (void)setTabBarController {
    AlbumsViewController *albumsViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([AlbumsViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([AlbumsViewController class])];
    albumsViewController.tabBarItem.image = [UIImage imageNamed:@"albums"];
    albumsViewController.tabBarItem.tag = 0;
    UINavigationController *albumsNavigation = [[UINavigationController alloc] initWithRootViewController:albumsViewController];
    
    SelectUploadImageViewController *selectUploadImageViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([SelectUploadImageViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SelectUploadImageViewController class])];
    selectUploadImageViewController.tabBarItem.image = [UIImage imageNamed:@"camera"];
    selectUploadImageViewController.tabBarItem.tag = 1;
    UINavigationController *selectUploadImageNavigation = [[UINavigationController alloc] initWithRootViewController:selectUploadImageViewController];
    
//    UploadHistoryViewController *uploadHistoryViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([UploadHistoryViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([UploadHistoryViewController class])];
//    uploadHistoryViewController.tabBarItem.image = [UIImage imageNamed:@"history"];
//    uploadHistoryViewController.tabBarItem.tag = 2;
//    UINavigationController *uploadHistoryNavigation = [[UINavigationController alloc] initWithRootViewController:uploadHistoryViewController];
    
    ProfileViewController *profileViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([ProfileViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([ProfileViewController class])];
    profileViewController.tabBarItem.image = [UIImage imageNamed:@"profile"];
    profileViewController.tabBarItem.tag = 2;
    UINavigationController *profileNavigation = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    
    self.viewControllers = [NSArray arrayWithObjects:albumsNavigation,selectUploadImageNavigation,profileNavigation, nil];
    
    //接收kTabBarSecondControllerDisMiss的訊息，當上傳相簿的頁面被DisMiss掉的時候切換至相簿列表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pickerControllerDisMiss:) name:kTabBarSecondControllerDisMiss object:nil];
}

- (void)pickerControllerDisMiss:(NSNotification*)notification{
    [self setSelectedIndex:self.lastSelectTab];
}

#pragma mark TabbarControllerDelegate

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    switch (item.tag) {
        case 1: {
            [[NSNotificationCenter defaultCenter] postNotificationName:kSelectUploadImage object:nil];
        }
            break;
            
        default:
            break;
    }
    //紀錄當上傳頁面關閉時上次選取的Tab
    if (item.tag != 1) {
        self.lastSelectTab = item.tag;
    }
}


@end
