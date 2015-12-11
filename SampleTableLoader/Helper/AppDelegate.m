//  AppDelegate.m
//  SampleTableLoader
//  Created by Seetha on 09/12/15.
//  Copyright (c) 2015 CTS. All rights reserved.

#import "AppDelegate.h"
#import "ConnectionManager.h"
#import "ListDataController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

/*
 This class will holds the object ListDataController. So we can access JSON data easity though this object
 ListDataController class will manage the JSON data
*/ 

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Going to create object for ConnectionManager and ListDataController
    [self createListDataController];

    // Adding notication to get the orientation callback
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didOrientationChanged:)  name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];

    // Showing view on the main window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    mViewController = [[ViewController alloc]init];
    self.window.rootViewController = mViewController;
    [self.window makeKeyAndVisible];

    return YES;
}

-(void) createListDataController
{
    // creating object for the ListDataController, which will manages the JSON data
    if( self.mListDataController == 0x0 )
        self.mListDataController = [[ListDataController alloc] init];
}

+(AppDelegate*) sharedObj;
{
    // This class method returns the Appdelegate instance
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

-(void) reloadDataOnResponse
{
    // On success of download process, we are reloading table content
    if( mViewController != 0x0 )
    {
        [mViewController stopActivityIndicator];
        [mViewController reloadTableData];
    }
}

- (void) didOrientationChanged:(NSNotification *) notification
{
    // This is the notification for the orientation changes
    // From here we are adjusting tablecells frame
    
    if( mViewController != 0x0 )
    {
        [mViewController performSelector:@selector(adjustActivityIndicator) withObject:nil afterDelay:0.1];
        [mViewController reloadTableData];
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
