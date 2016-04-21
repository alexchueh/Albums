//
//  CategoryTableView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/6.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "CategoryTableView.h"

@implementation CategoryTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    self.categoryArray = [[AlbumsModel sharedInstance] getCategory];
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
    NSString *string = @"相簿分類";
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor PIXTableViewHeaderTextColor]];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    NSString *string = self.categoryArray[indexPath.row][kCategoryTitle];
    cell.textLabel.text = string;
    [cell.textLabel setFrame:CGRectMake(100, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width - 100, cell.textLabel.frame.size.height)];

    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.lastIndexPath = indexPath;
    [tableView reloadData];
    [self.alertView close];
    self.categoryDictionary = self.categoryArray[indexPath.row];
}



@end
