//
//  SelectAlbumsTableView.m
//  PIXUploadPhoto
//
//  Created by shadow on 2016/1/12.
//  Copyright © 2016年 shadow. All rights reserved.
//

#import "SelectAlbumsTableView.h"
#import "SelectAlbumsModel.h"
#import "SelectUploadImageModel.h"
#import "AlbumsModel.h"
#import "AddAlbumsView.h"
#import "AlbumsCollectionModel.h"

@interface SelectAlbumsTableView ()
@property (nonatomic, strong) SelectAlbumsModel *selectAlbumsModel;
@property (nonatomic, strong) AddAlbumsView *addAlbumsView;
@property (nonatomic, strong) AlbumsModel *albumsModel;
@property (nonatomic, strong) AlbumsCollectionModel *albumsCollectionModel;
@end

@implementation SelectAlbumsTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    self.selectAlbumsModel = [SelectAlbumsModel sharedInstance];
    [self.selectAlbumsModel getAlbumsFolder];
    self.selectAlbumsModel.selectAlbumsTableView = self;
    self.albumsModel = [AlbumsModel sharedInstance];
    self.albumsCollectionModel = [AlbumsCollectionModel sharedInstance];
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    [label setTextAlignment:NSTextAlignmentCenter];
    NSString *string = @"請選擇一本相簿";
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor PIXTableViewHeaderTextColor]];
    
    UIImage *image = [UIImage imageNamed:@"books67"];
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake(view.frame.size.width - image.size.width - 10 , (44 - image.size.height) / 2, image.size.width , image.size.height)];
    [button addTarget:self action:@selector(addAlbums:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectAlbumsModel.albumsArray count];
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
    NSString *string = self.selectAlbumsModel.albumsArray[indexPath.row][kAlbumsTitle];
    cell.textLabel.text = string;
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.lastIndexPath = indexPath;
    [tableView reloadData];
    [self.alertView close];
    self.albumsDicitonary = self.selectAlbumsModel.albumsArray[indexPath.row];
    NSString *albumsID = self.albumsDicitonary[kAlbumsID];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"set_id"] = albumsID;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *defaultData = [defaults objectForKey:@"uploadHistory"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:defaultData];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:self.albumsDicitonary[kAlbumsTitle] forKey:@"path"];
    [dictionary setObject:[NSNumber numberWithInt:(int)[self.selectImageArray count]] forKey:@"count"];
    [dictionary setObject:[self getTime:[NSDate date]] forKey:@"date"];
    [array insertObject:dictionary atIndex:0];

    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    [alertView setButtonTitles:NULL];
    M13ProgressViewRing *ring = [[M13ProgressViewRing alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    for (int i = 0 ; i < [self.selectImageArray count] ; i++) {
        UIImage *image = self.selectImageArray[i];
        [[SelectUploadImageModel sharedInstance] uploadImageToPIXNETAlbums:image parameters:parameters uploadImageCallback:^(BOOL succeed, NSError *error) {
            NSLog(@"succeed:%@",succeed?@"YES":@"NO");
            static int count = 0;
            count++;
            [ring setProgress:count/[self.selectImageArray count] animated:YES];
            if (count == [self.selectImageArray count] - 1) {
                [self performBlock:^{
                    count = 0;
                    [alertView close];
                    [self.albumsCollectionModel getAlbumsListData:UIAppDelegate.userName completion:^(BOOL succeed, NSError *error) {
                        [self.albumsCollectionModel.albumsCollectionView reloadData];
                    }];
                }  afterDelay:.5];
            }
        }];
    }
    [alertView setContainerView:ring];
    [alertView show];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [defaults setObject:data forKey:@"uploadHistory"];
    [defaults synchronize];
    
    //建立kTabBarSecondControllerDisMiss的訊息，當上傳相簿頁面被DisMiss的時候發出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kTabBarSecondControllerDisMiss object:nil];
}

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

#pragma mark CreatNewAblums Method

- (IBAction)addAlbums:(id)sender {
    [self.albumsModel creatAlbumsDictionary];
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    self.addAlbumsView = [[AddAlbumsView alloc] initWithFrame:CGRectMake(0 , 0 , self.frame.size.width , self.frame.size.height - 40)];
    [alertView setContainerView:self.addAlbumsView];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"送出", nil]];
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1) {
            NSMutableDictionary *dictionary = self.albumsModel.albumsDictionary;
            //檢查必要參數是否都有填寫，若資料有缺少將不送出
            if ([self.albumsModel checkData:dictionary]) {
                [self.albumsModel creatAlbumsSets:^(BOOL succeed, NSError *error) {
                    if (succeed) {

                    }
                }];
            }
        }
        [alertView close];
    }];
    [alertView show];
}

- (NSString *)getTime:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [format stringFromDate:date];
    return dateString;
}

@end
