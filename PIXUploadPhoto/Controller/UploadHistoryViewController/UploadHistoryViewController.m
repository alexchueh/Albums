//
//  UploadHistoryViewController.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/2/4.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "UploadHistoryViewController.h"
#import "UploadHistoryTableViewCell.h"
#import "SelectAlbumsTableView.h"
#import "SelectAlbumsModel.h"

@interface UploadHistoryViewController ()
@property (nonatomic, strong) NSArray *historyData;
@end

@implementation UploadHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self getUploadHistoryData];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUploadHistoryData];
}

- (void)getUploadHistoryData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *defaultData = [defaults objectForKey:@"uploadHistory"];
    self.historyData = [NSKeyedUnarchiver unarchiveObjectWithData:defaultData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.historyData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UploadHistoryTableViewCell *cell = (UploadHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UploadHistoryTableViewCell"];
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"UploadHistoryTableViewCell" owner:self options:nil];
        cell = [objects objectAtIndex:0];
    }
    
    NSMutableDictionary *dictionary = self.historyData[indexPath.row];
    [cell.albumsPath setText:[NSString stringWithFormat:@"上傳至『%@』相簿",dictionary[@"path"]]];
    [cell.status setText:@"狀態：完成"];

//    [RACObserve([SelectAlbumsModel sharedInstance].selectAlbumsTableView, uploaded) subscribeNext:^(NSString *uploaded) {
//        
//    }];
    [cell.uploadDate setText:dictionary[@"date"]];;

    return cell;
}

@end
