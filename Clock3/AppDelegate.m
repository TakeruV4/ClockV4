//
//  AppDelegate.m
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

//@synthesize alermManager;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    self.subTables = [[NSMutableArray alloc]init];
    
    
	NSLog(@"データロード");
	// アラームを管理するマネージャを作成
	//alermManager = [[AlermManager alloc] init];
    NSMutableArray *loadArray = [[NSMutableArray alloc]init];
    
	// 前回の状態を復元
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"LOAD_ARRAY"];
    loadArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	if (loadArray) {
		[self.subTables arrayByAddingObjectsFromArray:loadArray];
	}
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"データセーブ");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.subTables];
    [defaults setObject:data forKey:@"LOAD_ARRAY"];
    /*
	[defaults setObject:self.alermManager.alermObjects
				 forKey:@"ALERM_OBJECTS"];
	[defaults synchronize];
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    	NSLog(@"データロード");
    self.subTables = [[NSMutableArray alloc]init];
    
    NSMutableArray *loadArray = [[NSMutableArray alloc]init];
    
	// 前回の状態を復元
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"LOAD_ARRAY"];
    loadArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	if (loadArray) {
		[self.subTables arrayByAddingObjectsFromArray:loadArray];
	}
	[defaults synchronize];
}

@end
