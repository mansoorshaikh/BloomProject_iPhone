//
//  TestHomeViewController.m
//  Bloom_Project
//
//  Created by arvind on 12/15/15.
//  Copyright © 2015 MWC. All rights reserved.
//
#import "SDWebImage/UIImageView+WebCache.h"
#import "TestHomeViewController.h"
#import "SWRevealViewController/SWRevealViewController.h"
#import "SpotlightVO.h"
#import "AsyncImageView/AsyncImageView.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "SearchViewController.h"
#import "SeriesViewController.h"
#import "RegisterViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"
#import "MusicViewController.h"
#import "SeriesViewController.h"
#import "FeatureViewController.h"
#import "ShortsViewController.h"
#import "PodcastsViewController.h"
#import "DetailsViewController.h"
#import "EpisodeViewController.h"
#import "SeriesVO.h"
#import "ContinueWatchVO.h"
#import "PlayViewController.h"
#import "TagCategoryDataVO.h"
#import "MenuViewController.h"
#import "Reachability.h"
#import "HomeViewController.h"
#import "SignInViewController.h"
#import "MyAccountViewController.h"
@interface TestHomeViewController ()

@end

@implementation TestHomeViewController
@synthesize mainscrollview,spotlightScrollview,spotlightarray,testimgArray1,testimgarray2,tagnamearray,contiWatchArray,popularArray,TrabingnowArray,featureArray,shortArray,activityIndicator,popularScrollView,countiuneWacthScrollView,trendingNowScrollview,featureScrollview,appDelegate,seriesArray,podcastsArray,musicArray,shortScrollview,seriesScrollview,podcastsScrollview,musicScrollview,msgLbl,SignOut,overlayView,isMenuVisible,menuNameArray,menuNameButton,spotlightLBl,ContinuewatchLbl,PopularLbl,TrendingLbl,FeatureLbl,ShortLbl,SeriesLbl,MusicLbl,podcastsLbl,navigationmenuBtn,navigationSearchBtn,bloomimg;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [activityIndicator stopAnimating];
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    
    CGRect screenRectwidth = [[UIScreen mainScreen] bounds];
    bloomimg = [[UIImageView alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [bloomimg setFrame:CGRectMake(screenRectwidth.size.width/2-70,18, 170, 33)];
        [bloomimg setImage:[UIImage imageNamed:@"Bloom Project_Logo-white.png"]];
        navigationmenuBtn=[[UIButton alloc] initWithFrame:CGRectMake(20,18,30,30)];
        navigationSearchBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width-50,18,30,30)];
    }else{
        [bloomimg setImage:[UIImage imageNamed:@"Bloom Project_Logo-white_iphone.png"]];
        [bloomimg setFrame:CGRectMake(screenRectwidth.size.width/2-60,25, 122, 22)];
        navigationmenuBtn=[[UIButton alloc] initWithFrame:CGRectMake(16,25,21,21)];
        navigationSearchBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width-40,25,21,21)];
    }
        bloomimg.backgroundColor = [UIColor clearColor];
        bloomimg.alpha = 0.95;
        bloomimg.opaque = NO;
        [self.view addSubview:bloomimg];
        
        [navigationmenuBtn addTarget:self action:@selector(menuScreenAction)forControlEvents:UIControlEventTouchUpInside];
        [navigationmenuBtn setBackgroundImage: [UIImage imageNamed:@"revealicon.png"] forState:UIControlStateNormal];
        [self.view addSubview:navigationmenuBtn];
    
        [navigationSearchBtn addTarget:self action:@selector(SearchAction)forControlEvents:UIControlEventTouchUpInside];
        [navigationSearchBtn setBackgroundImage: [UIImage imageNamed:@"searchicon.png"] forState:UIControlStateNormal];
        [self.view addSubview:navigationSearchBtn];
        
    
    NSLog(@"stage 1");
    dispatch_async(dispatch_get_main_queue(), ^{
        
        tagnamearray=[[NSMutableArray alloc]initWithObjects:@"Spotlight",@"Popular",@"Trending Now",@"Feature Doc",@"Short Doc",@"Series",@"Podcast",@"Music", nil];
        
        self.navigationController.navigationBarHidden=YES;
        
        NSLog(@"stage 2");
        
        [self DisplayallView];
        
        NSLog(@"stage 3");
    });
    [self overlayDisplay];
}

-(void)overlayDisplay{
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil){
        
        menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"My Account",@"Settings", nil];
    }else{
        menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"Sign In",@"Register",@"Settings", nil];
        
    }
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0,45, self.view.bounds.size.width, self.view.bounds.size.height)];
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.alpha = 0.95;
    int yValue=10;
    int arraycount=[menuNameArray count];
    for (int count=0; count<[menuNameArray count]; count++) {
        menuNameButton=[[UIButton alloc] initWithFrame:CGRectMake(17, yValue, self.view.bounds.size.width, 38)];
        [menuNameButton setTitle:[menuNameArray objectAtIndex:count] forState:UIControlStateNormal];
        if (arraycount==8) {
            if (count==6) {
                menuNameButton.tag=count+100;
            }else if (count==7){
                menuNameButton.tag=count+1;
            }else{
                menuNameButton.tag=count;
                
            }
        }else{
            menuNameButton.tag=count;
        }
        if (count==8) {
            menuNameButton.titleLabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f];
        }else{
            menuNameButton.titleLabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f];
        }
        [menuNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuNameButton setBackgroundColor:[UIColor blackColor]];
        [menuNameButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        menuNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [overlayView addSubview:menuNameButton];
        
        yValue=yValue+50;
    }
    [self.view addSubview:overlayView];
    
    overlayView.hidden=true;
    isMenuVisible=false;

}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (BOOL)shouldAutorotate {
    // Return YES for supported orientations
    return YES;
}

-(IBAction)featureViewAction{
    FeatureViewController * feature;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController~ipad" bundle:nil];
        
    }else{
        feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController" bundle:nil];
    }
    [self.navigationController pushViewController:feature animated:NO];
}
-(IBAction)shortViewAction{
    ShortsViewController * shorts;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController~ipad" bundle:nil];
    }else{
        shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController" bundle:nil];
    }
    [self.navigationController pushViewController:shorts animated:NO];
}
-(IBAction)seriesViewAction{
    SeriesViewController * series;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewControoler~ipad" bundle:nil];
        
    }else{
        series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewController" bundle:nil];
    }
    [self.navigationController pushViewController:series animated:NO];
}
-(IBAction)podcastsViewAction{
    PodcastsViewController * podcasts;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        podcasts = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController~ipad" bundle:nil];
        
    }else{
        podcasts = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController" bundle:nil];
    }
    [self.navigationController pushViewController:podcasts animated:NO];
}
-(IBAction)musicViewAction{
    MusicViewController * music;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        music = [[MusicViewController alloc] initWithNibName:@"MusicViewController~ipad" bundle:nil];
    }else{
        music = [[MusicViewController alloc] initWithNibName:@"MusicViewController" bundle:nil];
    }
    [self.navigationController pushViewController:music animated:NO];
}
-(void)menuButtonAction:(UIButton *)button{
    int tags=button.tag;
    if (tags==0) {
        if(!isMenuVisible)
        {
            overlayView.hidden=false;
            isMenuVisible=true;
        }else{
            overlayView.hidden=true;
            isMenuVisible=false;
        }

    }else if (tags==1){
        FeatureViewController * feature;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController~ipad" bundle:nil];
            
        }else{
            feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController" bundle:nil];
        }
        [self.navigationController pushViewController:feature animated:NO];
    }else if (tags==2){
        ShortsViewController * shorts;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController~ipad" bundle:nil];
            
        }else{
            shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController" bundle:nil];
        }
        [self.navigationController pushViewController:shorts animated:NO];
    }else if (tags==3){
        SeriesViewController * series;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewControoler~ipad" bundle:nil];
            
        }else{
            series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewController" bundle:nil];
        }
        [self.navigationController pushViewController:series animated:NO];
    }else if (tags==4){
        PodcastsViewController * podcasts;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            podcasts = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController~ipad" bundle:nil];
            
        }else{
            podcasts = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController" bundle:nil];
        }
        [self.navigationController pushViewController:podcasts animated:NO];
    }else if (tags==5){
        MusicViewController * music;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            music = [[MusicViewController alloc] initWithNibName:@"MusicViewController~ipad" bundle:nil];
            
        }else{
            music = [[MusicViewController alloc] initWithNibName:@"MusicViewController" bundle:nil];
        }
        [self.navigationController pushViewController:music animated:NO];
    }else if (tags==6){
        SignInViewController * signin;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController~ipad" bundle:nil];
            
        }else{
            signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
        }
        [self.navigationController pushViewController:signin animated:NO];
    }else if (tags==7){
        RegisterViewController * registers;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            registers = [[RegisterViewController alloc] initWithNibName:@"RegisterViewContoller~ipad" bundle:nil];
            
        }else{
            registers = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
        }
        [self.navigationController pushViewController:registers animated:NO];
    }else if (tags==8){
        SettingViewController * setting;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController~ipad" bundle:nil];
            
        }else{
            setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        }
        [self.navigationController pushViewController:setting animated:NO];
    }else if (tags==106){
        MyAccountViewController * myaccount;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            myaccount = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController~ipad" bundle:nil];
            
        }else{
            myaccount = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];
        }
        [self.navigationController pushViewController:myaccount animated:NO];
    }
}
-(IBAction)menuScreenAction{
    if(!isMenuVisible)
    {
        overlayView.hidden=false;
        isMenuVisible=true;
    }else{
        overlayView.hidden=true;
        isMenuVisible=false;
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



-(IBAction)SearchAction{
    SearchViewController *search;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        search=[[SearchViewController alloc] initWithNibName:@"SearchViewController~ipad" bundle:nil];
        [self.navigationController pushViewController:search animated:NO];
    }else{
        search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        [self.navigationController pushViewController:search animated:NO];
    }
}

-(void)continueWatchingData{
    contiWatchArray=[[NSMutableArray alloc]init];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];

    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BloomProject" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
      //  [activityIndicator stopAnimating];
        
    }else{
        
            NSString *urlString;
            urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/continue_watching.php?type=list&user_id=%@",[prefsid objectForKey:@"user_id"]];
            NSLog(@"string url %@",urlString);
            NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                 
                                                          length:[mydata length] encoding: NSUTF8StringEncoding];
            NSError *error;
            
            NSArray *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            int counter=0;
            if([userDict count]>=5)
                counter=[userDict count]-5;
            for (int count=counter; count<[userDict count]; count++) {
                NSDictionary *activityDatas=[userDict objectAtIndex:count];
                ContinueWatchVO *csvo=[[ContinueWatchVO alloc] init];
                
                csvo.user_id=[[NSString alloc] init];
                csvo.video_id=[[NSString alloc] init];
                csvo.time_paused=[[NSString alloc] init];
                if ([activityDatas objectForKey:@"user_id"] != [NSNull null])
                    csvo.user_id=[activityDatas objectForKey:@"user_id"];
                csvo.video_id=[activityDatas objectForKey:@"video_id"];
                csvo.time_paused=[activityDatas objectForKey:@"time_paused"];
                [contiWatchArray addObject:csvo];
            }
    [activityIndicator stopAnimating];
        }
}

-(void)viewWillAppear:(BOOL)animated{
}

-(void)viewDidAppear:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^{

    appDelegate.shouldRotate=NO;
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];

    
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil){
        
        [[[SDWebImageManager sharedManager] imageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        
        [self continueWatchingData];
        
        [ContinuewatchLbl setTitle:@"Continue Watching" forState:UIControlStateNormal];
        ContinuewatchLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [ContinuewatchLbl setBackgroundColor:[UIColor clearColor]];
        ContinuewatchLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
        
        int imageXValues=0;
        int imageXValwidths=self.view.bounds.size.width/2;
        for (int count=0; count<[contiWatchArray count]; count++) {
            if (count==5) {
                break;
            }
            ContinueWatchVO *cvo=[contiWatchArray objectAtIndex:count];
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",cvo.video_id];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXValues,0,imageXValwidths,self.countiuneWacthScrollView.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imageXValues,0,imageXValwidths,self.countiuneWacthScrollView.bounds.size.height)];
            imgview.clipsToBounds = YES;
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.countiuneWacthScrollView addSubview:indicator];
            
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            
            [countiuneWacthScrollView addSubview:imgview];
            imageXValues=imageXValues+imageXValwidths+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=count+100;
            [transperentBtn addTarget:self action:@selector(ContinueWatAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.countiuneWacthScrollView bringSubviewToFront:imgview];
            [self.countiuneWacthScrollView addSubview:imgview];
            [self.countiuneWacthScrollView addSubview:transperentBtn];
            [self.countiuneWacthScrollView bringSubviewToFront:transperentBtn];
        }
    }
    });

}

-(void)DisplayallView{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for (UIView *v in mainscrollview.subviews) {
                [v removeFromSuperview];
        }
        
        
        [[[SDWebImageManager sharedManager] imageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];

        [self.popularScrollView delegate];
        [self.spotlightScrollview delegate];
        [self.trendingNowScrollview delegate];
        [self.countiuneWacthScrollView delegate];
        
        [self.featureScrollview delegate];
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat yheights = screenRect.size.width/3;
        CGFloat yheightscont = screenRect.size.width/2;
        
        CGFloat yheightsspotlight = screenRect.size.width;
        CGFloat finalHeght=(yheights/9)*13;
        CGFloat finalHeghtspotlight=yheightsspotlight/4*3;
        CGFloat finalHeghtconts=yheightscont/4*3;
        
        [spotlightScrollview removeFromSuperview];
        spotlightScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 15, self.view.bounds.size.width, finalHeghtspotlight)];
        
        int yheight=finalHeghtspotlight+60;
        
        NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
        if([prefsid stringForKey:@"user_id"]!=nil)
            [self continueWatchingData];
        
        if (contiWatchArray.count==0) {
        }else{
            [countiuneWacthScrollView removeFromSuperview];
            ContinuewatchLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
            countiuneWacthScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width,finalHeghtconts)];
            yheight=yheight+finalHeghtconts+40;
        }
        
        [popularScrollView removeFromSuperview];
        [trendingNowScrollview removeFromSuperview];
        [featureScrollview removeFromSuperview];
        [shortScrollview removeFromSuperview];
        [seriesScrollview removeFromSuperview];
        [podcastsScrollview removeFromSuperview];
        [musicScrollview removeFromSuperview];
        
        
        PopularLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
        popularScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
        yheight=yheight+finalHeght+40;
        TrendingLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
        trendingNowScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
        yheight=yheight+finalHeght+40;
        FeatureLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
        featureScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
        yheight=yheight+finalHeght+40;
        ShortLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
        shortScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
        yheight=yheight+finalHeght+40;
        SeriesLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
        seriesScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
        yheight=yheight+finalHeght+40;
        podcastsLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
        podcastsScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
        yheight=yheight+finalHeght+40;
        MusicLbl=[[UIButton alloc] initWithFrame:CGRectMake(18,yheight-30,200,30)];
        musicScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
        yheight=yheight+finalHeght+20;
        
        SignOut = [[UIButton alloc] initWithFrame:CGRectMake(18,yheight,100,30)];
        yheight=yheight+30;
        
        msgLbl=[[UILabel alloc] initWithFrame:CGRectMake(18,yheight,250,60)];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            mainscrollview.contentSize = CGSizeMake(width,yheight+800);
            
        }else{
            mainscrollview.contentSize = CGSizeMake(width,yheight+300);
        }
        mainscrollview.scrollEnabled=YES;
        
    
    //spotlightScrollview area
    //postImagesScrollview.layer.frame=CGRectMake(10,0,800,100);
    spotlightLBl=[[UIButton alloc] initWithFrame:CGRectMake(18,-15,200,25)];
    [spotlightLBl setTitle:[tagnamearray objectAtIndex:0] forState:UIControlStateNormal];
    spotlightLBl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [spotlightLBl setBackgroundColor:[UIColor clearColor]];
    //[spotlightLBl addTarget:self action:@selector(SpotlightAction:) forControlEvents:UIControlEventTouchUpInside];
    spotlightLBl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    NSLog(@"stage 4");

    int imageXValue=0,activitCounter=0,contuwatchWidth=self.view.bounds.size.width/2;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        spotlightScrollview.contentSize= CGSizeMake(self.view.bounds.size.width*3+350,self.spotlightScrollview.bounds.size.height);
    }else{
        spotlightScrollview.contentSize= CGSizeMake(self.view.bounds.size.width*3,self.spotlightScrollview.bounds.size.height);
    }
    countiuneWacthScrollView.contentSize= CGSizeMake(contuwatchWidth*5+160,self.countiuneWacthScrollView.bounds.size.height);
    popularScrollView.contentSize= CGSizeMake(self.view.bounds.size.width+10,self.popularScrollView.bounds.size.height);
    trendingNowScrollview.contentSize= CGSizeMake(self.view.bounds.size.width+10,self.trendingNowScrollview.bounds.size.height);
    featureScrollview.contentSize= CGSizeMake(self.view.bounds.size.width+10,self.featureScrollview.bounds.size.height);
    shortScrollview.contentSize= CGSizeMake(self.view.bounds.size.width+10,self.shortScrollview.bounds.size.height);
    seriesScrollview.contentSize= CGSizeMake(self.view.bounds.size.width+10,self.seriesScrollview.bounds.size.height);
    podcastsScrollview.contentSize= CGSizeMake(self.view.bounds.size.width+10,self.podcastsScrollview.bounds.size.height);
    musicScrollview.contentSize= CGSizeMake(self.view.bounds.size.width+10,self.musicScrollview.bounds.size.height);
    
    int maincounter=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincounter++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Spotlight"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXValue,2,screenRect.size.width,self.spotlightScrollview.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imageXValue,2, screenRect.size.width,self.spotlightScrollview.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.spotlightScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            
            [spotlightScrollview addSubview:imgview];
            imageXValue=imageXValue+screenRect.size.width;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincounter+100;
            
            [transperentBtn addTarget:self action:@selector(SpotlightAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.spotlightScrollview bringSubviewToFront:imgview];
            [self.spotlightScrollview addSubview:imgview];
            [self.spotlightScrollview addSubview:transperentBtn];
            [self.spotlightScrollview bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:spotlightScrollview];
        [self.mainscrollview bringSubviewToFront:spotlightScrollview];
        [self.mainscrollview addSubview:spotlightLBl];
    }
    NSLog(@"stage 5");

    maincounter=0;
    //countiuneWacthScrollview area
    
    if([contiWatchArray count]>0){
        [ContinuewatchLbl setTitle:@"Continue Watching" forState:UIControlStateNormal];
        ContinuewatchLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [ContinuewatchLbl setBackgroundColor:[UIColor clearColor]];
        ContinuewatchLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
        
        int imageXValues=0;
        int imageXValwidths=self.view.bounds.size.width/2;
        for (int count=0; count<[contiWatchArray count]; count++) {
            if (count==5) {
                break;
            }
            ContinueWatchVO *cvo=[contiWatchArray objectAtIndex:count];
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",cvo.video_id];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXValues,0,imageXValwidths,self.countiuneWacthScrollView.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imageXValues,0,imageXValwidths,self.countiuneWacthScrollView.bounds.size.height)];
            imgview.clipsToBounds = YES;
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.countiuneWacthScrollView addSubview:indicator];
            
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            
            [countiuneWacthScrollView addSubview:imgview];
            imageXValues=imageXValues+imageXValwidths+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=count+100;
            [transperentBtn addTarget:self action:@selector(ContinueWatAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.countiuneWacthScrollView bringSubviewToFront:imgview];
            [self.countiuneWacthScrollView addSubview:imgview];
           [self.countiuneWacthScrollView addSubview:transperentBtn];
            [self.countiuneWacthScrollView bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:countiuneWacthScrollView];
        [self.mainscrollview bringSubviewToFront:countiuneWacthScrollView];
        [self.mainscrollview addSubview:ContinuewatchLbl];
    }
    NSLog(@"stage 6");
    //popularScrollView area
    [PopularLbl setTitle:[tagnamearray objectAtIndex:1] forState:UIControlStateNormal];
    PopularLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [PopularLbl setBackgroundColor:[UIColor clearColor]];
    PopularLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    
    int imageXValus=2;
    int imageXValwidth=self.view.bounds.size.width/3;
    int mainconter=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        mainconter++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"popular"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXValus,0,yheights,self.popularScrollView.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imageXValus,0, yheights, self.popularScrollView.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.popularScrollView addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            
            [popularScrollView addSubview:imgview];
            imageXValus=imageXValus+yheights+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=mainconter+100;
            [transperentBtn addTarget:self action:@selector(PopularAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.popularScrollView bringSubviewToFront:imgview];
            [self.popularScrollView addSubview:imgview];
            [self.popularScrollView addSubview:transperentBtn];
            [self.popularScrollView bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:popularScrollView];
        [self.mainscrollview bringSubviewToFront:popularScrollView];
        [self.mainscrollview addSubview:PopularLbl];
    }
    NSLog(@"stage 7");

    mainconter=0;
    //trendingNowScrollview area
    [TrendingLbl setTitle:[tagnamearray objectAtIndex:2] forState:UIControlStateNormal];
    TrendingLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [TrendingLbl setBackgroundColor:[UIColor clearColor]];
    TrendingLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    
    int imageXVals=2;
    int maincoter=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincoter++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"trending"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXVals,0,imageXValwidth,self.trendingNowScrollview.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imageXVals,0, imageXValwidth, self.trendingNowScrollview.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.trendingNowScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            
            [trendingNowScrollview addSubview:imgview];
            imageXVals=imageXVals+imageXValwidth+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincoter+100;
            [transperentBtn addTarget:self action:@selector(TrendingAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.trendingNowScrollview bringSubviewToFront:imgview];
            [self.trendingNowScrollview addSubview:imgview];
            [self.trendingNowScrollview addSubview:transperentBtn];
            [self.trendingNowScrollview bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:trendingNowScrollview];
        [self.mainscrollview bringSubviewToFront:trendingNowScrollview];
        [self.mainscrollview addSubview:TrendingLbl];
    }
    NSLog(@"stage 8");

    maincoter=0;
    
    //featureScrollview area
    [FeatureLbl setTitle:[tagnamearray objectAtIndex:3] forState:UIControlStateNormal];
    FeatureLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [FeatureLbl setBackgroundColor:[UIColor clearColor]];
    [FeatureLbl addTarget:self action:@selector(featureViewAction) forControlEvents:UIControlEventTouchUpInside];
    FeatureLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    
    int imageXValss=2;
    int maincounters=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincounters++;
        
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Feature Doc"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXValss,0,yheights,self.featureScrollview.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imageXValss,0, yheights, self.featureScrollview.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.featureScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            
            [featureScrollview addSubview:imgview];
            imageXValss=imageXValss+yheights+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincounters+100;
            [transperentBtn addTarget:self action:@selector(FeatureAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.featureScrollview bringSubviewToFront:imgview];
            [self.featureScrollview addSubview:imgview];
            [self.featureScrollview addSubview:transperentBtn];
            [self.featureScrollview bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:featureScrollview];
        [self.mainscrollview bringSubviewToFront:featureScrollview];
        [self.mainscrollview addSubview:FeatureLbl];
    }
    NSLog(@"stage 9");

    maincounters=0;
    
    //shortScrollview area
    [ShortLbl setTitle:[tagnamearray objectAtIndex:4] forState:UIControlStateNormal];
    ShortLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [ShortLbl setBackgroundColor:[UIColor clearColor]];
    [ShortLbl addTarget:self action:@selector(shortViewAction) forControlEvents:UIControlEventTouchUpInside];
    ShortLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    
    int imgeXValss=2;
    
    int maincountr=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincountr++;
        
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Short Doc"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imgeXValss,0,imageXValwidth,self.shortScrollview.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imgeXValss,0, imageXValwidth, self.shortScrollview.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.shortScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [shortScrollview addSubview:imgview];
            imgeXValss=imgeXValss+imageXValwidth+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincountr+100;
            [transperentBtn addTarget:self action:@selector(ShortsAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.shortScrollview bringSubviewToFront:imgview];
            [self.shortScrollview addSubview:imgview];
            [self.shortScrollview addSubview:transperentBtn];
            [self.shortScrollview bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:shortScrollview];
        [self.mainscrollview bringSubviewToFront:shortScrollview];
        [self.mainscrollview addSubview:ShortLbl];
    }
    NSLog(@"stage 10");

    maincountr=0;
    //seriesScrollview area
    [SeriesLbl setTitle:[tagnamearray objectAtIndex:5] forState:UIControlStateNormal];
    SeriesLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [SeriesLbl setBackgroundColor:[UIColor clearColor]];
    [SeriesLbl addTarget:self action:@selector(seriesViewAction) forControlEvents:UIControlEventTouchUpInside];
    SeriesLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    
    int imgXValss=2;
    
    int maincouters=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincouters++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"series,primary video"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imgXValss,0,imageXValwidth,self.seriesScrollview.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imgXValss,0, imageXValwidth, self.seriesScrollview.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.seriesScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            
            [seriesScrollview addSubview:imgview];
            imgXValss=imgXValss+imageXValwidth+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincouters+100;
            [transperentBtn addTarget:self action:@selector(SeriesAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.seriesScrollview bringSubviewToFront:imgview];
            [self.seriesScrollview addSubview:imgview];
            [self.seriesScrollview addSubview:transperentBtn];
            [self.seriesScrollview bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:seriesScrollview];
        [self.mainscrollview bringSubviewToFront:seriesScrollview];
        [self.mainscrollview addSubview:SeriesLbl];
    }
    NSLog(@"stage 11");

    maincouters=0;
    //podcastsScrollview area
    [podcastsLbl setTitle:[tagnamearray objectAtIndex:6] forState:UIControlStateNormal];
    podcastsLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [podcastsLbl setBackgroundColor:[UIColor clearColor]];
    [podcastsLbl addTarget:self action:@selector(podcastsViewAction) forControlEvents:UIControlEventTouchUpInside];
    podcastsLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    
    int igXVals=2;
    int maincount=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincount++;
        
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Podcast"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(igXVals,0,imageXValwidth,self.podcastsScrollview.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(igXVals,0, imageXValwidth, self.podcastsScrollview.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.podcastsScrollview addSubview:indicator];
            
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [podcastsScrollview addSubview:imgview];
            igXVals=igXVals+imageXValwidth+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincount+100;
            [transperentBtn addTarget:self action:@selector(PodcastsAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.podcastsScrollview bringSubviewToFront:imgview];
            [self.podcastsScrollview addSubview:imgview];
            [self.podcastsScrollview addSubview:transperentBtn];
            [self.podcastsScrollview bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:podcastsScrollview];
        [self.mainscrollview bringSubviewToFront:podcastsScrollview];
        [self.mainscrollview addSubview:podcastsLbl];
    }
    NSLog(@"stage 12");

    maincount=0;
    // musicScrollview area
    [MusicLbl setTitle:[tagnamearray objectAtIndex:7] forState:UIControlStateNormal];
    MusicLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [MusicLbl setBackgroundColor:[UIColor clearColor]];
    [MusicLbl addTarget:self action:@selector(musicViewAction) forControlEvents:UIControlEventTouchUpInside];
    MusicLbl.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    
    int imgXVals=2;
    int maincounts=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincounts++;
        
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Music"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imgXVals,0,imageXValwidth,self.musicScrollview.bounds.size.height)];
            UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(imgXVals,0, imageXValwidth, self.musicScrollview.bounds.size.height)];
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.musicScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [indicator stopAnimating];
                [activityIndicator stopAnimating];
            }];

            imgview.backgroundColor=[UIColor clearColor];
            
            [musicScrollview addSubview:imgview];
            imgXVals=imgXVals+imageXValwidth+5;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincounts+100;
            [transperentBtn addTarget:self action:@selector(MusicAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.musicScrollview bringSubviewToFront:imgview];
            [self.musicScrollview addSubview:imgview];
            [self.musicScrollview addSubview:transperentBtn];
            [self.musicScrollview bringSubviewToFront:transperentBtn];
        }
        [self.mainscrollview addSubview:musicScrollview];
        [self.mainscrollview bringSubviewToFront:musicScrollview];
        [self.mainscrollview addSubview:MusicLbl];
    }
    
    NSLog(@"stage 13");

    maincounts=0;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"firstname"]!=nil){
        [SignOut setTitle:@"Sign Out" forState:UIControlStateNormal];
        [SignOut addTarget:self action:@selector(LogOut) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        [SignOut setTitle:@"Sign In" forState:UIControlStateNormal];
        [SignOut addTarget:self action:@selector(SignInAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    SignOut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [SignOut setBackgroundColor:[UIColor clearColor]];
    SignOut.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    [self.mainscrollview addSubview:SignOut];
    
    
    [msgLbl setFont:[UIFont boldSystemFontOfSize:16.0]];
    msgLbl.lineBreakMode = NSLineBreakByWordWrapping;
    msgLbl.numberOfLines = 0;
    [msgLbl setTextColor:[UIColor whiteColor]];
    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    
    NSString *lastChargoalwght =[prefs objectForKey:@"firstname"];
    NSString *wiglblstr=[prefss objectForKey:@"lastname"];
    NSString* firstBit = @"Signed in As ";
    NSString* firstBits = @"\nVersion .01\nPrivacy Policy";
    NSString *texts;
    if ([prefs objectForKey:@"firstname"]!=nil) {
        texts = [NSString stringWithFormat:@"%@ %@ %@ %@",
                 firstBit,
                 lastChargoalwght,wiglblstr,firstBits];
        msgLbl.text=texts;
        
    }else{
        msgLbl.text=@"Version .01\nPrivacy Policy";
    }
    
    [self.mainscrollview addSubview:msgLbl];
    
    });


}
-(IBAction)LogOut{
        contiWatchArray=[[NSMutableArray alloc] init];
        NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
        [prefsid removeObjectForKey:@"user_id"];
        [prefss removeObjectForKey:@"firstname"];
        [prefs removeObjectForKey:@"lastname"];
        [self DisplayallView];
   
    [self overlayDisplay];
    
}

-(IBAction)SignInAction{
    SignInViewController * signin;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController~ipad" bundle:nil];
        
    }else{
        signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
    }
    [self.navigationController pushViewController:signin animated:NO];
}
-(IBAction)ContinueWatAction:(UIButton*)button{
    ContinueWatchVO *cwvo=[contiWatchArray objectAtIndex:button.tag-100];
    appDelegate.videoPathStr=[[NSString alloc]init];
    appDelegate.timeStr=[[NSString alloc]init];

    PlayViewController *play;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        play=[[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        
    }else{
        play=[[PlayViewController alloc] initWithNibName:@"PlayViewController~ipad" bundle:nil];
        
    }
    appDelegate.videoPathStr=cwvo.video_id;
    appDelegate.timeStr=cwvo.time_paused;
    [self.navigationController pushViewController:play animated:NO];
}
-(IBAction)SpotlightAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
    }
}
-(IBAction)PopularAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
    }
    
}-(IBAction)TrendingAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
    }
}
-(IBAction)FeatureAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
            
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
    }
}
-(IBAction)ShortsAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
            
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
            
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }

}
-(IBAction)MusicAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
            
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
            
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
            
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
}
-(IBAction)SeriesAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
            
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
            
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
            
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }

}

-(IBAction)PodcastsAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
            
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
            
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
            
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView == spotlightScrollview)
        scrollView.scrollEnabled = NO;
    
    else if (scrollView == countiuneWacthScrollView)
        scrollView.scrollEnabled = NO;
    else if (scrollView == popularScrollView)
        scrollView.scrollEnabled = NO;
    else if (scrollView == trendingNowScrollview)
        scrollView.scrollEnabled = NO;
    else if (scrollView == featureScrollview)
        scrollView.scrollEnabled = NO;
    else
        scrollView.scrollEnabled = YES;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == spotlightScrollview)
    {
        if(spotlightScrollview.contentOffset.x + spotlightScrollview.frame.size.width == spotlightScrollview.contentSize.width)
        {
            scrollView.scrollEnabled = NO;
        }
        else
        {
            scrollView.scrollEnabled = YES;
        }
    }
    if(scrollView == countiuneWacthScrollView)
    {
        if(countiuneWacthScrollView.contentOffset.x + countiuneWacthScrollView.frame.size.width == countiuneWacthScrollView.contentSize.width)
        {
            scrollView.scrollEnabled = NO;
        }
        else
        {
            scrollView.scrollEnabled = YES;
        }
    }
    if(scrollView == popularScrollView)
    {
        if(popularScrollView.contentOffset.x + popularScrollView.frame.size.width == popularScrollView.contentSize.width)
        {
            scrollView.scrollEnabled = NO;
        }
        else
        {
            scrollView.scrollEnabled = YES;
        }
    }
    if(scrollView == trendingNowScrollview)
    {
        if(trendingNowScrollview.contentOffset.x + trendingNowScrollview.frame.size.width == trendingNowScrollview.contentSize.width)
        {
            scrollView.scrollEnabled = NO;
        }
        else
        {
            scrollView.scrollEnabled = YES;
        }
    }
    if(scrollView == featureScrollview)
    {
        if(featureScrollview.contentOffset.x + featureScrollview.frame.size.width == featureScrollview.contentSize.width)
        {
            scrollView.scrollEnabled = NO;
        }
        else
        {
            scrollView.scrollEnabled = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
