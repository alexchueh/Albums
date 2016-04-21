//
//  SelectUploadImageViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "SelectUploadImageViewController.h"
#import "SelectUploadImageModel.h"

@interface SelectUploadImageViewController ()

@end

@implementation SelectUploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectUploadImage:) name:kSelectUploadImage object:nil];

    [self creatImagePicker];
    [self creatSelectAlbumsTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)selectUploadImage:(NSNotification*)notification{
    [self creatImagePicker];
}

- (void)creatImagePicker {
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 100;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];

    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)creatSelectAlbumsTableView {
    self.selectAlbumsTableView = [[SelectAlbumsTableView alloc] init];
    [self.selectAlbumsTableView setFrame:CGRectMake(0 , 0 , self.view.frame.size.width - 40 , self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 40)];
    [[self.selectAlbumsTableView layer] setCornerRadius:10.0];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    self.selectImageArray = [NSMutableArray array];
    for (int i = 0; i < [assets count] ; i++) {
        ALAsset *asset=assets[i];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [self.selectImageArray addObject:image];
    }
    if ([self.selectImageArray count] > 0) {
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        self.selectAlbumsTableView.selectImageArray = self.selectImageArray;
        self.selectAlbumsTableView.alertView = alertView;
        [alertView setButtonTitles:NULL];
        [alertView setContainerView:self.selectAlbumsTableView];
        [alertView show];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未選擇任何一張照片" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
