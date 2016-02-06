//
//  PlayViewController.m
//  Bloom_Project
//
//  Created by arvind on 12/28/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import "PlayViewController.h"
#import "Reachability.h"
@interface PlayViewController ()

@end

@implementation PlayViewController
@synthesize appDelegate,activityIndicator,player,playseconds,stopSeconds,durationTime,playerViewController,controlsVisible,webView,notification;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    controlsVisible=false;
    self.view.backgroundColor = [UIColor blackColor];
    self.view.opaque = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [activityIndicator stopAnimating];
        appDelegate=[[UIApplication sharedApplication] delegate];
        appDelegate.shouldRotate=YES;
        
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        
        NSString *fullpath=[NSString stringWithFormat:@"http://content.jwplatform.com/videos/%@-1920.mp4",appDelegate.videoPathStr];

        CGRect screenRect = [[UIScreen mainScreen] bounds];

        NSString *webviewString=[[NSString alloc] initWithFormat:
                                 @"<html><body onload='document.getElementById('vid').play()'; background-color: transparent; color:white; style=\"margin:0\" ><video width='%f' height='%f' controls='true' autoplay='autoplay' id='vid' x-webkit-airplay='allow'><source src='%@' type='video/mp4'></video><embed src='%@' width='%f' airplay='allow'></embed>;<preference name='orientation' value='landscape'/></html>",screenRect.size.width,screenRect.size.height,fullpath,fullpath,screenRect.size.width];
        /*NSString *webviewString=[[NSString alloc] initWithFormat:
                                 @"<html><body onload='document.getElementById('vid').play()'><video width='%f' height='%f' controls='true' autoplay='autoplay' id='vid'><source src='%@' type='video/mp4'></video></html>",screenRect.size.width,screenRect.size.height,fullpath];*/
        NSURL *fileURL = [NSURL URLWithString:fullpath];
        
        NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
        if([prefsid stringForKey:@"user_id"]==nil){
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:fileURL];
        webView.frame=CGRectMake(0, 0,screenRect.size.width,screenRect.size.height);
        [webView setBackgroundColor:[UIColor blackColor]];
        webView.delegate=self ;
        self.webView.mediaPlaybackRequiresUserAction = NO;
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setOpaque:NO];

        //[self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
        [webView loadHTMLString:webviewString baseURL:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(doneButtonClick:)
                                                         name:@"UIWindowDidBecomeHiddenNotification"
                                                       object:nil];
        }else{
        playerViewController = [[AVPlayerViewController alloc] init];
        AVURLAsset *asset = [AVURLAsset assetWithURL: fileURL];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
        player = [[AVPlayer alloc] initWithPlayerItem: item];
        [playerViewController.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        playerViewController.showsPlaybackControls = YES;
            player.allowsAirPlayVideo=YES;
            player.usesAirPlayVideoWhileAirPlayScreenIsActive=YES;
        playerViewController.player = player;
            player.allowsExternalPlayback = YES;
            player.usesExternalPlaybackWhileExternalScreenIsActive = YES;
        [player seekToTime:CMTimeMakeWithSeconds([appDelegate.timeStr floatValue], 10)];
        [player play];
            [self.view addSubview:playerViewController.view];
            NSLog(@"player.airPlayVideoActive %hhd",player.airPlayVideoActive);
         /* MPMoviePlayerController * moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
            [moviePlayerController.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            [self.view addSubview:moviePlayerController.view];
            moviePlayerController.fullscreen = YES;
            moviePlayerController.allowsAirPlay = true;
            moviePlayerController.controlStyle=MPMovieControlStyleEmbedded;
            [moviePlayerController play];
            */
        // Do any additional setup after loading the view from its nib.
        UIImageView *titleLabel = [[UIImageView alloc] init];
        [titleLabel setFrame:CGRectMake(50, 5, 170, 33)];
        [titleLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bloom Project_Logo-white.png"]]];    self.navigationItem.titleView = titleLabel;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        UIButton *transperentButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-250)];
        transperentButton.backgroundColor=[UIColor clearColor];
        [transperentButton addTarget:self action:@selector(showPlaybackControls) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:transperentButton];

        UIButton *doneButton;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
           doneButton =[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-80, self.view.bounds.size.height-45, 60, 40)];
        }else{
            doneButton =[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-120, self.view.bounds.size.height-45, 60, 40)];
        }
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [doneButton.layer setBorderWidth:3.0];
        doneButton.layer.cornerRadius = 3; // this value vary as per your desire
        doneButton.clipsToBounds = YES;
        [doneButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [doneButton addTarget:self action:@selector(donePlaying) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:doneButton];
        }
    });
}
- (UIButton *)findButtonInView:(UIView *)view {
    UIButton *button = nil;
    
    if ([view isMemberOfClass:[UIButton class]]) {
        return (UIButton *)view;
    }
    if (view.subviews && [view.subviews count] > 0) {
        for (UIView *subview in view.subviews) {
            button = [self findButtonInView:subview];
            if (button) return button;
        }
    }
    return button;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    UIButton *b = [self findButtonInView:webView];
    [b sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)doneButtonClick:(NSNotification*)aNotification{
        [self.navigationController popViewControllerAnimated:NO];
    
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
-(void)donePlaying{
    CMTime duration =player.currentItem.currentTime;
    stopSeconds = CMTimeGetSeconds(duration);
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil)
    [self VideoPostData];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)showPlaybackControls{
    if(controlsVisible==false){
        playerViewController.showsPlaybackControls = YES;
        controlsVisible=true;
    }else if(controlsVisible==true){
        playerViewController.showsPlaybackControls = NO;
        controlsVisible=false;
    }
    [player pause];
    [player play];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    //Do stuff here...
}


-(void)viewDidAppear:(BOOL)animated{
    CMTime duration =player.currentItem.asset.duration;
    playseconds = CMTimeGetSeconds(duration);
    NSLog(@"play duration: %.2f", playseconds);
 }

-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    CMTime duration =player.currentItem.currentTime;
    stopSeconds = CMTimeGetSeconds(duration);
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil)
         [self VideoPostData];
}

-(IBAction)menuScreenAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)VideoPostData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BloomProject" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
        
    }else{
        
        NSString *urlString;
        urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/continue_watching.php?type=add&video_id=%@&user_id=%@&time_paused=%f",appDelegate.videoPathStr,[prefsid objectForKey:@"user_id"],stopSeconds];
        
        NSLog(@"string url %@",urlString);
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                             
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
    }
}

- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
