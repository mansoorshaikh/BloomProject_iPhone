//
//  TestHomeViewController.h
//  Bloom_Project
//
//  Created by arvind on 12/15/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface TestHomeViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIScrollView *mainscrollview,*spotlightScrollview,*popularScrollView,*countiuneWacthScrollView,*trendingNowScrollview,*featureScrollview,*shortScrollview,*seriesScrollview,*podcastsScrollview,*musicScrollview;
@property(nonatomic,retain) NSMutableArray *spotlightarray,*testimgArray1,*testimgarray2,*tagnamearray,*contiWatchArray,*popularArray,*TrabingnowArray,*featureArray,*shortArray,*seriesArray,*podcastsArray,*musicArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) UILabel *msgLbl;
@property(nonatomic,retain) UIImageView *bloomimg;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain)IBOutlet UIButton *SignOut;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *spotlightLBl,*ContinuewatchLbl,*PopularLbl,*TrendingLbl,*FeatureLbl,*ShortLbl,*SeriesLbl,*MusicLbl,*podcastsLbl;
@end
