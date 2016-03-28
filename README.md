# GDLeachability
   用于检测网络变化（包含2G/3G/4G网络）

# 使用方法
```objc
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
    [self reachabilityStatus];
    
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
```
