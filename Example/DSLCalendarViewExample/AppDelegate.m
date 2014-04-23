//
//  AppDelegate.m
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright (c) 2012 Pete Callaway. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "DSLCalendarDayView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[DSLCalendarDayView appearance] setFillColorNotCurrentMonth:[UIColor colorWithRed:0.157 green:0.149 blue:0.227 alpha:1.000]];
    [[DSLCalendarDayView appearance] setFillColor:[UIColor colorWithRed:0.157 green:0.149 blue:0.227 alpha:1.000]];
    [[DSLCalendarDayView appearance] setTextFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0f]];
    [[DSLCalendarDayView appearance] setTextFontNotInMonth:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0f]];
    [[DSLCalendarDayView appearance] setSelectedTextFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0f]];
    
    [[DSLCalendarDayView appearance] setBorderColor:[UIColor colorWithRed:0.102 green:0.098 blue:0.165 alpha:1.000]];
    [[DSLCalendarDayView appearance] setBevelColor:[UIColor colorWithRed:0.173 green:0.165 blue:0.243 alpha:1.000]];
    [[DSLCalendarDayView appearance] setBevelColorNotCurrentMonth:[UIColor colorWithRed:0.173 green:0.165 blue:0.243 alpha:1.000]];

    UIImage *selectedImage = [[UIImage imageNamed:@"calendar_selection"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 9, 7, 9)];
    [[DSLCalendarDayView appearance] setSelectedLeftBackgroundImage:selectedImage];
    [[DSLCalendarDayView appearance] setSelectedRightBackgroundImage:selectedImage];
    [[DSLCalendarDayView appearance] setSelectedMiddleBackgroundImage:selectedImage];
    [[DSLCalendarDayView appearance] setSelectedWholeBackgroundImage:selectedImage];
    
    [[DSLCalendarDayView appearance] setTextColor:[UIColor whiteColor]];
    [[DSLCalendarDayView appearance] setSelectedTextColor:[UIColor whiteColor]];
    [[DSLCalendarDayView appearance] setTextColorNotInMonth:[UIColor colorWithRed:0.478 green:0.475 blue:0.522 alpha:1.000]];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
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
}

@end
