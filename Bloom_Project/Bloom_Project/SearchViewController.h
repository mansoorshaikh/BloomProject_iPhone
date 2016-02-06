//
//  SearchViewController.h
//  Bloom_Project
//
//  Created by arvind on 12/16/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "AppDelegate.h"

@interface SearchViewController : UIViewController<UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain) MainViewController *mvc;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *SearchTableView;
@property(nonatomic,retain) NSMutableArray *searchArray;
@property(nonatomic,retain)IBOutlet UISearchBar *SearchBar;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;
@property(nonatomic,retain)IBOutlet UITextField *SearchText;
@property(nonatomic,retain)UILabel * searchLblinfo;
@property(nonatomic,readwrite) BOOL viewUp;
@property(nonatomic,retain) IBOutlet UIScrollView *mainscrollview;

@end
