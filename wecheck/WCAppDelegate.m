//
//  WCAppDelegate.m
//  wecheck
//
//  Created by Wai Lok Tsang on 6/20/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "WCAppDelegate.h"

@implementation WCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //removing core data
    //[[self cdh] saveContext];
    if([[self das] isDatabaseExist])
    {
        [[self das] openDatabase];
        return YES;
    }
    else
    {
        return NO;
    }
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
    
    //removing core data
    //[[self cdh] saveContext];
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
    
    //removing core data
    //[[self cdh] saveContext];
    
    [[self das] closeDatabase];
}

#define debug 1
/*
 //removing core data
- (WCCoreDataHelper*)cdh {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (!_coreDataHelper) {
        _coreDataHelper = [WCCoreDataHelper new];
        [_coreDataHelper setupCoreData];
    }
    return _coreDataHelper;
}
*/

- (WCDataAccessSvc*)das {
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (!_dataAccessSvc) {
        _dataAccessSvc = [WCDataAccessSvc new];
        [_dataAccessSvc isDatabaseExist];
    }
    return _dataAccessSvc;
    
}
@end
