//
//  AlbumsViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/5.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "AlbumsViewController.h"
#import "CustomIOSAlertView.h"
#import "AlbumsModel.h"
#import "AddAlbumsView.h"
#import "AlbumsCollectionView.h"
#import "AlbumsCollectionModel.h"
#import "MJRefresh.h"

@interface AlbumsViewController ()
@property (nonatomic, strong) AlbumsCollectionView *albumsCollectionView;
@property (nonatomic, strong) AddAlbumsView *addAlbumsView;
@property (nonatomic, strong) AlbumsModel *albumsModel;
@end

@implementation AlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:kPixnetToken]);
    self.title = [NSString stringWithFormat:@"%@'Albums",UIAppDelegate.userName];
    self.tabBarItem.title = @"albums";
    [self addNavigationRightButton];
    self.albumsModel = [AlbumsModel sharedInstance];
    [self setAlbumsCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.albumsCollectionView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //移除AlbumsCell的動畫效果
    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveAnimation object:nil];
}

- (void)addNavigationRightButton {
    UIImage *image = [UIImage imageNamed:@"books67"];
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake(self.view.frame.origin.x , self.view.frame.origin.y , image.size.width , image.size.height)];
    [button addTarget:self action:@selector(addAlbums:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:customBtn];
}

- (void)touchView:(UIGestureRecognizer *)recognizer {
    //移除AlbumsCell的動畫效果
    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveAnimation object:nil];
}

- (void)setAlbumsCollectionView {
    [SVProgressHUD showWithStatus:@"載入中..." maskType:SVProgressHUDMaskTypeNone];
    [[AlbumsCollectionModel sharedInstance] getAlbumsListData:UIAppDelegate.userName completion:^(BOOL succeed, NSError *error) {
        if (succeed) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat height = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height;
                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
                self.albumsCollectionView = [[AlbumsCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height) collectionViewLayout:layout];
                self.albumsCollectionView.navigationController = self.navigationController;
                [self.view addSubview:self.albumsCollectionView];
            });
            [SVProgressHUD dismiss];
        }
    }];
}

- (IBAction)addAlbums:(id)sender {
    //移除AlbumsCell的動畫效果
    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveAnimation object:nil];
    [self.albumsModel creatAlbumsDictionary];
    self.albumsModel.albumsView = self.view;
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    self.addAlbumsView = [[AddAlbumsView alloc] initWithFrame:CGRectMake(0 , 0 , self.view.frame.size.width - 20 * 2 , self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20 * 2)];
    [alertView setContainerView:self.addAlbumsView];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"送出", nil]];
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1) {
            NSMutableDictionary *dictionary = self.albumsModel.albumsDictionary;
            //檢查必要參數是否都有填寫，若資料有缺少將不送出
            if ([self.albumsModel checkData:dictionary]) {
                [self.albumsModel creatAlbumsSets:^(BOOL succeed, NSError *error) {
                    
                }];
            }
        }
        [alertView close];
    }];
    [alertView show];
}

@end
