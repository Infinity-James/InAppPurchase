//
//  AppDelegate.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SpecificIAPHelper.h"

#pragma mark - App Delegate Private Class Extension

@interface AppDelegate () {}

#pragma mark - Private Properties

@end

#pragma mark - App Delegate Implementation

@implementation AppDelegate

#pragma mark - UIApplicationDelegate Methods

/**
 *	Tells the delegate that the launch process is almost done and the app is almost ready to run.
 *
 *	@param	application					The delegating application object.
 *	@param	launchOptions				A dictionary indicating the reason the application was launched (if any).
 *
 *	@return	NO if the application cannot handle the URL resource, otherwise return YES.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window							= [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor			= [UIColor whiteColor];
	
	//	initialise the IAPHelper as soon as the app launches
	[SpecificIAPHelper sharedInstance];
	
	MainViewController *mainVC			= [[MainViewController alloc] init];
	UINavigationController *navigation	= [[UINavigationController alloc] initWithRootViewController:mainVC];
	self.window.rootViewController		= navigation;
	
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end