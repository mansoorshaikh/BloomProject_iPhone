//
//  PlayViewController.h
//  Bloom_Project
//
//  Created by arvind on 12/28/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>
#import <MediaPlayer/MediaPlayer.h>
@import AVFoundation;
@import AVKit;

@interface PlayViewController : UIViewController<UIWebViewDelegate>
{
    UIDeviceOrientation orientation;
}
@property(nonatomic,readwrite) BOOL controlsVisible;
@property(nonatomic,retain)  AVPlayerViewController *playerViewController;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AVPlayer *player;
@property(nonatomic,readwrite) float playseconds,stopSeconds;
@property(nonatomic,retain) NSString *durationTime;
@property(nonatomic,retain) IBOutlet UIView *landscapeView;
@property(nonatomic,strong) IBOutlet UIWebView *webView;
@property(nonatomic,retain) NSNotification *notification;
@end
