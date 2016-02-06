//
//  MusicViewController.h
//  Bloom_Project
//
//  Created by arvind on 12/17/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "AppDelegate.h"

@interface MusicViewController : UIViewController<UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) MainViewController *mvc;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *musicTableView;
@property(nonatomic,retain) NSMutableArray *musicArray;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;


@end
