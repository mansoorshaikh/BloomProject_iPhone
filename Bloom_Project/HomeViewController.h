//
//  HomeViewController.h
//  Bloom_Project
//
//  Created by MWC on 12/9/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotlightVO.h"
#import "AppDelegate.h"
@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) IBOutlet UITableView *MainTableView;
@property(nonatomic,retain) SpotlightVO *sptlVO;
@property(nonatomic,retain) AppDelegate *appDelegate;

@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) NSMutableArray *spotlightarray,*testimgArray1,*testimgarray2,*tagnamearray,*contiWatchArray,*popularArray,*TrabingnowArray,*featureArray,*shortArray;
@property(nonatomic,retain) IBOutlet UIScrollView *mainscrollview,*spotlightScrollview;
@property(nonatomic,retain) IBOutlet UIBarButtonItem *revealButtonleft;
@end
