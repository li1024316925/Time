//
//  AppDelegate.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //添加窗口
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    [self.window makeKeyAndVisible];
    
    //判断当前是否为第一次打开本应用程序
    //创建本地化字典
    BOOL first = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"];
    if (first == NO) {
        //first不存在，说明是第一次打开本应用，先展示海报
        self.window.rootViewController = [[FirstViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
        
    }else{
        
        //first存在，不是第一次加载，直接展示main
        self.window.rootViewController = [[MainViewController alloc] init];
        
    }
    
    return YES;
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
