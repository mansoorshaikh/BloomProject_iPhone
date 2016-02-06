//
//  SplashscreenViewController.h
//  Bloom_Project
//
//  Created by arvind on 1/1/16.
//  Copyright © 2016 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SplashscreenViewController : UIViewController
@property(nonatomic,retain) NSMutableArray *tagsArray;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UIImageView *splashImg;
@end
