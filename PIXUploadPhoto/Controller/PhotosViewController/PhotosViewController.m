//
//  PhotosViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/13.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotosCollectionModel.h"
#import "PhotosCollectionView.h"
#import "CustomIOSAlertView.h"
#import "FixAlbumsView.h"
#import "PhotosModel.h"

@interface PhotosViewController ()
@property (nonatomic, strong) PhotosCollectionView *photosCollectionView;
@property (nonatomic, strong) FixAlbumsView *fixAlbumsView;
@property (nonatomic, strong) PhotosModel *photosModel;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosModel = [PhotosModel sharedInstance];
    [self setPhotosCollectionView];
    [self addNavigationRightButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNavigationRightButton {
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"編輯" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor PIXNavigationBarTintColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(self.view.frame.origin.x , self.view.frame.origin.y , 60 , 44)];
    [button addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:customBtn];
}

- (IBAction)editClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"完成"]) {
        [button setTitle:@"編輯" forState:UIControlStateNormal];
        self.photosCollectionView.canDelete = NO;
        [self.photosCollectionView reloadData];
        return;
    }
    [ActionSheetStringPicker showPickerWithTitle:@"操作選項"
                                            rows:@[@"修改",@"刪除"]
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           switch (selectedIndex) {
                                               case 0: {
                                                   [self.photosModel creatAlbumsDictionary];
                                                   self.photosModel.albumsView = self.view;
                                                   self.photosModel.setID = self.setID;
                                                   [self.photosModel setAlbumsData:self.title key:kAlbumsName];
                                                   CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
                                                   self.fixAlbumsView = [[FixAlbumsView alloc] initWithFrame:CGRectMake(0 , 0 , self.view.frame.size.width - 20 * 2 , self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20 * 2)];
                                                   [alertView setContainerView:self.fixAlbumsView];
                                                   [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"送出", nil]];
                                                   [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                                                       if (buttonIndex == 1) {
                                                           NSMutableDictionary *dictionary = self.photosModel.albumsDictionary;
                                                           //檢查必要參數是否都有填寫，若資料有缺少將不送出
                                                           [self.fixAlbumsView disMissKeyboard];
                                                           if ([self.photosModel checkData:dictionary]) {
                                                               [self.photosModel fixAlbumsSets:^(BOOL succeed, NSError *error) {
                                                                   if (succeed) {
                                                                       self.title = self.photosModel.albumsTitle;
                                                                   }
                                                               }];
                                                           }
                                                       }
                                                       [alertView close];
                                                   }];
                                                   [alertView show];
                                               }
                                                   break;
                                               case 1: {
                                                   if ([button.titleLabel.text isEqualToString:@"編輯"]) {
                                                       [button setTitle:@"完成" forState:UIControlStateNormal];
                                                       self.photosCollectionView.canDelete = YES;
                                                   }
                                                   [self.photosCollectionView reloadData];
                                               }
                                                   break;
                                                   
                                               default:
                                                   break;
                                           }
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                     }
                                          origin:sender];
}

- (void)setPhotosCollectionView {
    [SVProgressHUD showWithStatus:@"載入中..." maskType:SVProgressHUDMaskTypeNone];
    [[PhotosCollectionModel sharedInstance] getPhotosData:UIAppDelegate.userName setID:self.setID completion:^(BOOL succeed, NSError *error) {
        if (succeed) {
            CGFloat height = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height;
            dispatch_async(dispatch_get_main_queue(), ^{
                UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
                self.photosCollectionView = [[PhotosCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height) collectionViewLayout:layout];
                self.photosCollectionView.photosArray = [PhotosCollectionModel sharedInstance].photosArray;
                self.photosCollectionView.largeArray = [PhotosCollectionModel sharedInstance].largeArray;
                self.photosCollectionView.viewController = self;
                [self.view addSubview:self.photosCollectionView];
            });
        }else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"密碼錯誤請重新確認" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        [SVProgressHUD dismiss];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
