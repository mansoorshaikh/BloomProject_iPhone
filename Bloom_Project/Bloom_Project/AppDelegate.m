//
//  AppDelegate.m
//  Bloom_Project
//
//  Created by MWC on 12/9/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SplashscreenViewController.h"
#import "MainNavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize allEpisodeArray,allTagMainCategoriesArray,shouldRotate;

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.shouldRotate){
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            return UIInterfaceOrientationMaskLandscapeLeft;
        }else{
            return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
        }
    }
    
    else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            return UIInterfaceOrientationMaskLandscapeLeft;
        }else{
            return UIInterfaceOrientationMaskPortrait;
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if(allEpisodeArray==nil)
        allEpisodeArray=[[NSMutableArray alloc] init];
    if(allTagMainCategoriesArray == nil)
        allTagMainCategoriesArray=[[NSMutableArray alloc] init];
    SplashscreenViewController *splashvc;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        splashvc=[[SplashscreenViewController alloc] initWithNibName:@"SplashscreenViewController~ipad" bundle:nil];
    }else{
        splashvc=[[SplashscreenViewController alloc] initWithNibName:@"SplashscreenViewController" bundle:nil];
    }
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:splashvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.window.rootViewController=navController;
    [self.window makeKeyAndVisible];
    

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
