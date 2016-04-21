//
//  LoginViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/4.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "LoginViewController.h"
#import "AlbumsViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) AlbumsViewController *albumsViewController;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginWithPixnet];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (IBAction)selectLoginType:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    switch (segmentControl.selectedSegmentIndex) {
        case 0: {
            [self loginWithPixnet];
        }
            break;
        case 1: {
            [self loginWithOther];
        }
            break;
        default:
            break;
    }
}

- (void)loginWithPixnet {
    [PIXNETSDK loginByOAuthLoginView:self.webView completion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            [self succeedLogin:result];
        }else{
            [self errorLogin];
        }
    }];
}

- (void)loginWithOther {
    [PIXNETSDK loginByOAuth2OpenIDOnlyWithLoginView:self.webView completion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            [self succeedLogin:result];
        }else{
            [self errorLogin];
        }
    }];
}

- (void)succeedLogin:(id)result{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:result forKey:kPixnetToken];
    [self getUserDataWithUserName];
}

- (void)errorLogin {
    [TSMessage showNotificationWithTitle:NSLocalizedString(@"登入失敗", nil)
                                subtitle:NSLocalizedString(@"請再檢查登入資訊，並重新登入", nil)
                                    type:TSMessageNotificationTypeError];
}

- (void)getUserDataWithUserName {
    [[PIXNETSDK new] getAccountWithCompletion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userName = result[kAccount][kName];
            [defaults setObject:userName forKey:kName];
            UIAppDelegate.userName = userName;
            [TSMessage showNotificationWithTitle:NSLocalizedString(@"登入成功", nil)
                                        subtitle:NSLocalizedString(@"已成功登入", nil)
                                            type:TSMessageNotificationTypeSuccess];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
