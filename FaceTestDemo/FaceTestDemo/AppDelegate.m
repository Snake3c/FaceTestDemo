//
//  AppDelegate.m
//  FaceTestDemo
//
//  Created by cc on 15/9/28.
//  Copyright © 2015年 Snake. All rights reserved.
//
#define blue [UIColor colorWithRed:19/255.0 green:47/255.0 blue:133/255.0 alpha:1]

#import "AppDelegate.h"
#import "CCAutoTabBar/CCAutoTabBarController.h"
#import "MainViewController.h"
#import "SDKsViewController.h"
#import "COntactViewController.h"
#import "FaceppAPI.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 初始化 SDK
    [FaceppAPI initWithApiKey:@"e713bea65312093991ba7061a67ea4a0" andApiSecret:@"ZnA9gGI0Q7qj7KpWnaSFuqCUAss1kfn0"
                    andRegion:APIServerRegionCN];
    
    /// 开始 Debug 模式
    // 如果设置 YES, 就会输出打印信息
    [FaceppAPI setDebugMode:NO];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    CCAutoTabBarController *vc = [[CCAutoTabBarController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:[MainViewController new]];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:[SDKsViewController new]];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:[COntactViewController new]];
    NSArray *arr = @[nav1,nav2,nav3];
    vc.tintColor = blue;
    NSArray *imageHL = @[@"SearchHL",@"Files",@"AddHL"];
    NSArray *imageN = @[@"Search",@"Files",@"Add"];

    [vc addChildViewControllers:arr];
    [vc addNormalImages:imageN andHightedImages:imageHL];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTintColor:blue];
    
    
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
