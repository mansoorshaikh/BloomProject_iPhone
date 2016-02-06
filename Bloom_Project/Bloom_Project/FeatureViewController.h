//
//  FeatureViewController.h
//  Bloom_Project
//
//  Created by arvind on 12/28/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface FeatureViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *featureTableView;
@property(nonatomic,retain) NSMutableArray *featureArray;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;

@end
