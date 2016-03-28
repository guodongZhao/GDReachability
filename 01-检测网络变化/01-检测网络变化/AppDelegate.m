//
//  AppDelegate.m
//  01-检测网络变化
//
//  Created by andezhou on 16/3/1.
//  Copyright (c) 2016年 sxt. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

@interface AppDelegate ()

@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, assign) NetworkStatus status;

@end

@implementation AppDelegate

/**
 开始中，应该在哪里检测网络的变化？
 在application：didFinishLaunchingWithOptions：方法中检测
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.status = 10;
    // 1.注册一个检测网络变化的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityStatus) name:kReachabilityChangedNotification object:nil];
    
    // 2.实例化,获得当前的网络状态
    // HostName:要保证对应的服务器一直处于运行状态
    self.reachability = [Reachability reachabilityWithHostName:@"baidu.com"];
    
    // 3.开始对网络的检测
    [self.reachability startNotifier];
    
    // 4.输出对应的网络状态
//    [self reachabilityStatus];
    
    return YES;
}

// 输出对应的网络状态
- (void)reachabilityStatus
{
    NetworkStatus status = self.reachability.currentReachabilityStatus;
    if (status == self.status) {
        return;
    }

    self.status = status;
    
    switch (status) {
        case NotReachable:
            NSLog(@"没有联网");
            break;
            
        case ReachableViaWiFi:
            NSLog(@"连接的是WIFI");
            break;
            
        case ReachableVia4G:
            NSLog(@"连接的是4G");
            break;
            
        case ReachableVia3G:
            NSLog(@"连接的是3G");
            break;
            
        case ReachableVia2G:
            NSLog(@"连接的是2G");
            break;
            
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
