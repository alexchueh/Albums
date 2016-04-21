//
//  CompetenceTableView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/7.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "CompetenceTableView.h"
#import "PasswordTableViewCell.h"
#import "ReactiveCocoa.h"
#import "UITextField+PIXTextFieldCategory.h"
#import "NSString+DeleteBlankText.h"

@implementation CompetenceTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    self.needPassword = NO;
    self.albumsModel = [AlbumsModel sharedInstance];
    self.photosModel = [PhotosModel sharedInstance];
    self.competenceArray = [[AlbumsModel sharedInstance] getCompetence];
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    [label setTextAlignment:NSTextAlignmentCenter];
    NSString *string = @"瀏覽權限";
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor PIXTableViewHeaderTextColor]];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = kCellHeight;
    if (self.needPassword && indexPath.row == 3) {
        height = kPasswordCellHeight;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = (int)[self.competenceArray count];
    if (self.needPassword) {
        count ++;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (self.needPassword) {
        if (indexPath.row == 3) {
            cell = (PasswordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PasswordTableViewCell class])];
            if (cell == nil) {
                NSArray *objects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PasswordTableViewCell class]) owner:self options:nil];
                cell = [objects objectAtIndex:0];
            }
            ((PasswordTableViewCell *)cell).alertView = self.alertView;
            ((PasswordTableViewCell *)cell).passwordTextField.delegate = self;
            ((PasswordTableViewCell *)cell).promptTextField.delegate = self;
            [((PasswordTableViewCell *)cell).passwordTextField setToolBar];
            [((PasswordTableViewCell *)cell).promptTextField setToolBar];
        }else {
            cell = [self creatDefaultCell:tableView indexPath:indexPath];
            int index = (int)indexPath.row;
            if (indexPath.row > 3) {
                index --;
            }
            NSString *string = self.competenceArray[index][kCompetenceTitle];
            cell.textLabel.text = string;
        }
    }else {
        cell = [self creatDefaultCell:tableView indexPath:indexPath];
        NSString *string = self.competenceArray[indexPath.row][kCompetenceTitle];
        cell.textLabel.text = string;
    }
    
    return cell;
}

- (UITableViewCell *)creatDefaultCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *newIndexPath = indexPath;
    int index = (int)indexPath.row;
    if (indexPath.row > 3 && self.needPassword == YES) {
        index --;
        newIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    }
    self.competenceDictionary = self.competenceArray[newIndexPath.row];
    self.lastIndexPath = newIndexPath;
    if (indexPath.row == 2) {
        self.needPassword = YES;
    }else {
        self.needPassword = NO;
        [self.alertView close];
    }
    [tableView reloadData];
}

#pragma mark TextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *string = [textField.text whenLastTextIsBlankDelete:textField.text];
    switch (textField.tag) {
        case 0: {
            [self.albumsModel setAlbumsData:string key:kAlbumsPassword];
            [self.photosModel setAlbumsData:string key:kAlbumsPassword];
        }
            break;
        case 1: {
            [self.albumsModel setAlbumsData:string key:kAlbumsPrompt];
            [self.photosModel setAlbumsData:string key:kAlbumsPrompt];
        }
            break;
            
        default:
            break;
    }
}

@end
