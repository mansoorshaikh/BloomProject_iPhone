//
//  MainViewController.m
//  CommunicationApp
//
//  Created by mansoor shaikh on 13/04/14.
//  Copyright (c) 2014 MobiWebCode. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "HomeViewController.h"
#import "RegisterViewController.h"
#import "SeriesViewController.h"
#import "TestHomeViewController.h"
#import "SettingViewController.h"
#import "MusicViewController.h"
#import "SearchViewController.h"
#import "ShortsViewController.h"
#import "FeatureViewController.h"
#import "PodcastsViewController.h"
@interface MainViewController ()<SWRevealViewControllerDelegate>

@end

@implementation MainViewController
@synthesize viewController = _viewController;
@synthesize appDelegate,searchString,postupload;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - SWRevealViewDelegate

#define LogDelegates 0
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeftSideMostRemoved ) str = @"FrontViewPositionLeftSideMostRemoved";
    if ( position == FrontViewPositionLeftSideMost) str = @"FrontViewPositionLeftSideMost";
    if ( position == FrontViewPositionLeftSide) str = @"FrontViewPositionLeftSide";
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}

- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    UINavigationController *frontNavigationController;

    RearViewController *rearViewController = [[RearViewController alloc] init];
    HomeViewController *mainFeeds;
    SearchViewController *searchvc;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        mainFeeds=[[HomeViewController alloc] initWithNibName:@"HomeViewController~ipad" bundle:nil];
    }else{
        mainFeeds=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        searchvc=[[SearchViewController alloc] initWithNibName:@"SearchViewController~ipad" bundle:nil];
    }else{
        searchvc=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        
    }
    
    RegisterViewController *registers;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        registers=[[RegisterViewController alloc]initWithNibName:@"RegisterViewContoller~ipad" bundle:nil];
    }else{
        registers=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];

    }
    SeriesViewController *series;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        series=[[SeriesViewController alloc]initWithNibName:@"SeriesViewControoler~ipad" bundle:nil];
    }else{
        series=[[SeriesViewController alloc]initWithNibName:@"SeriesViewController" bundle:nil];
    }

    TestHomeViewController *testhome;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        testhome=[[TestHomeViewController alloc] initWithNibName:@"TestHomeViewContoller~ipad" bundle:nil];
    }else{
        testhome=[[TestHomeViewController alloc]initWithNibName:@"TestHomeViewController" bundle:nil];
    }
    SettingViewController *setting;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        setting=[[SettingViewController alloc]initWithNibName:@"SettingViewController~ipad" bundle:nil];
    }else{
    setting=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    }
    MusicViewController *music;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        music=[[MusicViewController alloc]initWithNibName:@"MusicViewController~ipad" bundle:nil];
    }else{
        music=[[MusicViewController alloc]initWithNibName:@"MusicViewController" bundle:nil];
    }
    FeatureViewController *feature;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        feature=[[FeatureViewController alloc]initWithNibName:@"FeatureViewController~ipad" bundle:nil];
    }else{
        feature=[[FeatureViewController alloc]initWithNibName:@"FeatureViewController" bundle:nil];
    }

    ShortsViewController *shorts;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        shorts=[[ShortsViewController alloc]initWithNibName:@"ShortsViewController~ipad" bundle:nil];
    }else{
        shorts=[[ShortsViewController alloc]initWithNibName:@"ShortsViewController" bundle:nil];
    }

    PodcastsViewController *podcasts;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        podcasts=[[PodcastsViewController alloc]initWithNibName:@"PodcastsViewController~ipad" bundle:nil];
    }else{
        podcasts=[[PodcastsViewController alloc]initWithNibName:@"PodcastsViewController" bundle:nil];
    }

    
    if(appDelegate.index==0)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:testhome];
    if(appDelegate.index==1)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:feature];
    if(appDelegate.index==2)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:shorts];
    if(appDelegate.index==3)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:series];
    if(appDelegate.index==4)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:podcasts];
    if(appDelegate.index==5)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:music];
    if(appDelegate.index==6)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:registers];
    if(appDelegate.index==7)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:registers];
    if(appDelegate.index==8)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:setting];
    
    if(appDelegate.index==9)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:searchvc];

    
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;

    
    self.viewController = revealController;
	
	 [[[UIApplication sharedApplication] delegate] window].rootViewController = self.viewController;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
