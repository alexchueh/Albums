//
//  AppDelegate.m
//  PIXUploadPhoto
//
//  Created by shadow on 2015/12/30.
//  Copyright © 2015年 shadow. All rights reserved.
//

#import "AppDelegate.h"
#import "PIXNETSDK.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Fabric with:@[[Crashlytics class]]];

    [[UINavigationBar appearance] setBarTintColor:[UIColor PIXNavigationBarLightBlueColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor PIXNavigationBarTintColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor PIXNavigationBarTintColor]}];
    [PIXNETSDK setConsumerKey:@"91326f6ca26fe2fcae60d51125b07d7a" consumerSecret:@"5237fbb8cf022a8167c9bfc731535ba6"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:kName];
    self.userName = userName;
    
    self.oneSignal = [[OneSignal alloc]
                      initWithLaunchOptions:launchOptions
                      appId:@"6b10e8dc-0bfa-47b0-9948-22071b9ebcd6"
                      handleNotification:^(NSString* message, NSDictionary* additionalData, BOOL isActive) {
                          NSLog(@"OneSignal Notification opened:\nMessage: %@", message);
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                          [alert show];
                          
                          if (additionalData) {
                              NSLog(@"additionalData: %@", additionalData);
                              
                              // Check for and read any custom values you added to the notification
                              // This done with the "Additional Data" section the dashboard.
                              // OR setting the 'data' field on our REST API.
                              NSString* customKey = additionalData[@"customKey"];
                              if (customKey)
                                  NSLog(@"customKey: %@", customKey);
                          }
                      }];
    
    [self.oneSignal registerForPushNotifications];
    

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveAnimation object:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    NSLog(@"userInfo:%@",userInfo);
}

@end
