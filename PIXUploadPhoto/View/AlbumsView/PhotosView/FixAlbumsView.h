//
//  FixAlbumsView.h
//  PIXUploadPhoto
//
//  Created by shadow on 2016/2/2.
//  Copyright © 2016年 shadow. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "PhotosModel.h"
#import "CategoryTableView.h"
#import "CompetenceTableView.h"

@interface FixAlbumsView : BaseView<UITextFieldDelegate>

/**
 *  背景的ScrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *photosScrollView;
/**
 *  相片的Model
 */
@property (nonatomic, strong) PhotosModel *photosModel;
/**
 *  相簿名稱
 */
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *albumsNameTextField;
@property (nonatomic, copy) NSString *textFiledName;
/**
 *  相片描述
 */
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *albumsDescriptionTextField;
@property (nonatomic, copy) NSString *textFiledDescription;
/**
 *  選擇全站分類按鈕
 */
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
/**
 *  選擇瀏覽權限按鈕
 */
@property (weak, nonatomic) IBOutlet UIButton *competenceButton;
/**
 *  全站分類選擇列表
 */
@property (nonatomic, strong) CategoryTableView *categoryTableView;
/**
 *  瀏覽權限選擇列表
 */
@property (nonatomic, strong) CompetenceTableView *competenceTableView;

- (void)disMissKeyboard;

@end
