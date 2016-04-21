//
//  AlbumsView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/6.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "AddAlbumsView.h"

@implementation AddAlbumsView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
    }
    self.albumsModel = [AlbumsModel sharedInstance];
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setView];
}

- (void)setView {
    self.albumsNameTextField.delegate = self;
    self.albumsDescriptionTextField.delegate = self;
    [self.albumsNameTextField setToolBar];
    [self.albumsDescriptionTextField setToolBar];
    [RACObserve(self, textFiledName) subscribeNext:^(NSString *name) {
        if (name) {
            [self.albumsModel setAlbumsData:name key:kAlbumsName];
        }
    }];
    [RACObserve(self, textFiledDescription) subscribeNext:^(NSString *description) {
        if (description) {
            [self.albumsModel setAlbumsData:description key:kAlbumsDescription];
        }
    }];
    //取最後一個物件的高度當作ScrollView ContentSizeHeight（最後一個物件為選擇瀏覽權限）
    [self.albumsScrollView setContentSize:CGSizeMake(1 , self.competenceButton.frame.origin.y + self.competenceButton.frame.size.height)];
    self.categoryTableView = [[CategoryTableView alloc] init];
    [self.categoryTableView setFrame:CGRectMake(0 , 0 , self.frame.size.width , self.frame.size.height)];
    [[self.categoryTableView layer] setCornerRadius:10.0];
    [RACObserve(self.categoryTableView, categoryDictionary) subscribeNext:^(NSDictionary *categoryDictionary) {
        NSString *title = @"請選擇全站分類";
        if (categoryDictionary) {
            title = categoryDictionary[kCategoryTitle];
            if (categoryDictionary[kCategoryID]) {
                [self.albumsModel setAlbumsData:categoryDictionary[kCategoryID] key:kCategoryID];
            }
        }
        [self.categoryButton setTitle:title forState:UIControlStateNormal];
    }];

    self.competenceTableView = [[CompetenceTableView alloc] init];
    //因為瀏覽權限只有五個選項所以只設定五個Cell的高度
    [self.competenceTableView setFrame:CGRectMake(0 , 0 , self.frame.size.width , self.frame.size.height)];
    [[self.competenceTableView layer] setCornerRadius:10.0];
    [RACObserve(self.competenceTableView, competenceDictionary) subscribeNext:^(NSDictionary *competenceDictionary) {
        NSString *title = @"請選擇瀏覽權限";
        if (competenceDictionary) {
            title = competenceDictionary[kCategoryTitle];
            if (competenceDictionary[kCompetenceID]) {
                [self.albumsModel setAlbumsData:competenceDictionary[kCompetenceID] key:kCompetenceID];
            }
        }
        [self.competenceButton setTitle:title forState:UIControlStateNormal];
    }];
}

#pragma mark ButtonClick
- (IBAction)selectCategory:(id)sender {
    [self disMissKeyboard];
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    self.categoryTableView.alertView = alertView;
    [alertView setButtonTitles:NULL];
    [alertView setContainerView:self.categoryTableView];
    [alertView show];
}

- (IBAction)selectCompetence:(id)sender {
    [self disMissKeyboard];
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    self.competenceTableView.alertView = alertView;
    [alertView setButtonTitles:NULL];
    [alertView setContainerView:self.competenceTableView];
    [alertView show];
}

- (void)disMissKeyboard {
    [self.albumsNameTextField resignFirstResponder];
    [self.albumsDescriptionTextField resignFirstResponder];
}

#pragma mark TextFiledDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0: {
            NSString *name = textField.text;
            self.textFiledName = [name whenLastTextIsBlankDelete:name];
        }
            break;
        case 1: {
            NSString *description = textField.text;
            self.textFiledDescription = [description whenLastTextIsBlankDelete:description];
        }
            break;
            
        default:
            break;
    }
}



@end
