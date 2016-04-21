//
//  ProfileViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet ASProgressPopUpView *monthProgress;
@property (weak, nonatomic) IBOutlet ASProgressPopUpView *totalProgress;
@property (strong, nonatomic) OneSignal *oneSignal;
@property (nonatomic, copy) NSString *iconImageURL;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *albums;
@property (nonatomic, copy) NSString *pictures;
@property (nonatomic, copy) NSString *monthValue;
@property (nonatomic, copy) NSString *totalValue;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setProgress];
    [self setIconImageView];
    [self getUserDataWithUserName];
    self.backgroundScrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self getUserDataWithUserName];
        [self.backgroundScrollView.header endRefreshing];
    }];
//    self.progress.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProgress {
    self.monthProgress.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:16];
    self.monthProgress.popUpViewAnimatedColors = @[[UIColor greenColor], [UIColor orangeColor], [UIColor redColor]];
    self.monthProgress.progress = 0;
    [self.monthProgress showPopUpViewAnimated:YES];
    
    self.totalProgress.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:16];
    self.totalProgress.popUpViewAnimatedColors = @[[UIColor greenColor], [UIColor orangeColor], [UIColor redColor]];
    self.totalProgress.progress = 0;
    [self.totalProgress showPopUpViewAnimated:YES];
}

- (void)setIconImageView {
    self.userIconImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.userIconImageView.layer.masksToBounds = YES;
    self.userIconImageView.layer.cornerRadius = 50.0;
    self.userIconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userIconImageView.layer.borderWidth = 3.0f;
    self.userIconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.userIconImageView.layer.shouldRasterize = YES;
    self.userIconImageView.clipsToBounds = YES;
    
    self.uploadImageView.layer.cornerRadius = 5.0;
    self.spaceUsedImageView.layer.cornerRadius = 5.0;
}

- (IBAction)logoutAccount:(id)sender {
    [PIXNETSDK logout];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:kPixnetToken];
    LoginViewController *loginViewController = [[UIStoryboard storyboardWithName:NSStringFromClass([LoginViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void)getUserDataWithUserName {
    [self settingViews];
    [SVProgressHUD showWithStatus:@"載入中..." maskType:SVProgressHUDMaskTypeNone];
    [[PIXNETSDK new] getAccountWithCompletion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            NSDictionary *account = result[kAccount];
            self.name = account[kName];
            self.iconImageURL = account[kAvatar];
            self.monthValue = [NSString stringWithFormat:@"%f",[account[kQuota][kAlbumUploadUsage] floatValue] / [account[kQuota][kAlbumUploadQuota] floatValue]];
            self.totalValue = [NSString stringWithFormat:@"%f",[account[kQuota][kAlbumSpaceUsage] floatValue] / [account[kQuota][kAlbumSpaceQuota] floatValue]];
        }
        [SVProgressHUD dismiss];
    }];
    
    [[PIXAlbum new] getAlbumSetsWithUserName:UIAppDelegate.userName parentID:nil trimUser:NO page:1 perPage:100 shouldAuth:NO completion:^(BOOL succeed, id result, NSError *error) {
        if (succeed) {
            NSDictionary *dictionary = (NSDictionary *)result;
            NSArray *array = dictionary[@"sets"];
            self.albums = [NSString stringWithFormat:@"%@",dictionary[kTotalAlbums]];
            int pictures = 0;
            for (NSDictionary *dic in array) {
                NSString *totalPictures = dic[kTotalPictures];
                pictures += [totalPictures intValue];
            }
            self.pictures = [NSString stringWithFormat:@"%i",pictures];
        }
    }];
}

- (void)settingViews {
    //設定使用者大頭照
    [RACObserve(self, iconImageURL) subscribeNext:^(NSString *iconImageURL) {
        if (iconImageURL) {
            [self.userIconImageView useSDWebImageSetImage:iconImageURL];
        }
    }];
    //設定使用者名稱
    [RACObserve(self, name) subscribeNext:^(NSString *name) {
        if (name) {
            [self.userName setText:name];
        }
    }];
    //設定相簿總數量
    [RACObserve(self, albums) subscribeNext:^(NSString *albums) {
        if (albums) {
            [self.albumsCount setText:albums];
        }
    }];
    //設定相片總數量
    [RACObserve(self, pictures) subscribeNext:^(NSString *pictures) {
        if (pictures) {
            [self.picturesCount setText:pictures];
        }
    }];
    //設定本月上傳流量
    [RACObserve(self, monthValue) subscribeNext:^(NSString *monthValue) {
        if (monthValue) {
            self.monthProgress.progress = [monthValue floatValue];
        }
    }];
    //設定空間使用情況
    [RACObserve(self, totalValue) subscribeNext:^(NSString *totalValue) {
        if (totalValue) {
            self.totalProgress.progress = [totalValue floatValue];
        }
    }];
}
@end
