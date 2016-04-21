//
//  AlbumsTableView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/8.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "AlbumsTableView.h"
#import "AlbumsTableViewCell.h"

@implementation AlbumsTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumsTableViewCell *cell = (AlbumsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AlbumsTableViewCell class])];
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AlbumsTableViewCell class]) owner:self options:nil];
        cell = [objects objectAtIndex:0];
    }
//    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}

@end
