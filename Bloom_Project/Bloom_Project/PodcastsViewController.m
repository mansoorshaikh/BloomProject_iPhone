//
//  PodcastsViewController.m
//  Bloom_Project
//
//  Created by arvind on 12/28/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import "PodcastsViewController.h"
#import "HomeViewController.h"
#import "EpisodeViewController.h"
#import "DetailsViewController.h"
#import "SeriesVO.h"
#import "SearchViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "TagCategoryDataVO.h"
#import "RegisterViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"
#import "MusicViewController.h"
#import "SeriesViewController.h"
#import "FeatureViewController.h"
#import "ShortsViewController.h"
#import "PodcastsViewController.h"
#import "TestHomeViewController.h"
#import "SignInViewController.h"
#import "MyAccountViewController.h"
@interface PodcastsViewController ()

@end

@implementation PodcastsViewController
@synthesize activityIndicator,podcastsTableView,podcastsArray,appDelegate,overlayView,isMenuVisible,menuNameArray,menuNameButton,navigationmenuBtn,navigationSearchBtn,bloomimg;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    
    [activityIndicator stopAnimating];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden=YES;

    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil){
        
        menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"My Account",@"Settings", nil];
    }else{
        menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"Sign In",@"Register",@"Settings", nil];
        
    }
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0,55, self.view.bounds.size.width, self.view.bounds.size.height)];
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
    [self.view addSubview:bloomimg];
    
    [navigationmenuBtn addTarget:self action:@selector(menuScreenAction)forControlEvents:UIControlEventTouchUpInside];
    [navigationmenuBtn setBackgroundImage: [UIImage imageNamed:@"revealicon.png"] forState:UIControlStateNormal];
    [self.view addSubview:navigationmenuBtn];
    
    [navigationSearchBtn addTarget:self action:@selector(SearchAction)forControlEvents:UIControlEventTouchUpInside];
    [navigationSearchBtn setBackgroundImage: [UIImage imageNamed:@"searchicon.png"] forState:UIControlStateNormal];
    [self.view addSubview:navigationSearchBtn];
    //SeriesTableView.backgroundColor=[UIColor blackColor];
    podcastsArray=[[NSMutableArray alloc]init];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        [podcastsTableView removeFromSuperview];
        podcastsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,110,self.view.bounds.size.width,self.view.bounds.size.height-360)];
        podcastsTableView.backgroundColor=[UIColor clearColor];
        self.podcastsTableView.separatorColor = [UIColor clearColor];
        [self.view addSubview:podcastsTableView];
        [self.view bringSubviewToFront:podcastsTableView];
        
    }else{

    if(height>=480 && height<568){
        
    }else if(height>=568 && height<600){
        [podcastsTableView removeFromSuperview];
        podcastsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,110,self.view.bounds.size.width,self.view.bounds.size.height-265)];
        podcastsTableView.backgroundColor=[UIColor clearColor];
        self.podcastsTableView.separatorColor = [UIColor clearColor];
        [self.view addSubview:podcastsTableView];
        [self.view bringSubviewToFront:podcastsTableView];
    }
    }
    podcastsTableView.delegate = self;
    podcastsTableView.dataSource = self;

    
    //[self getSeriesData];
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Podcast"]){
            [podcastsArray addObject:slvos];
        }
    }

    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    else
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    // Use this to allow upside down as well
    //return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

-(void)menuButtonAction:(UIButton *)button{
    int tags=button.tag;
    if (tags==0) {
        TestHomeViewController * home;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            home = [[TestHomeViewController alloc] initWithNibName:@"TestHomeViewContoller~ipad" bundle:nil];
            
        }else{
            home = [[TestHomeViewController alloc] initWithNibName:@"TestHomeViewController" bundle:nil];
        }
        [self.navigationController pushViewController:home animated:NO];
        
        
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
        if(!isMenuVisible)
        {
            overlayView.hidden=false;
            isMenuVisible=true;
            [self.view bringSubviewToFront:overlayView];
            
        }else{
            overlayView.hidden=true;
            isMenuVisible=false;
        }
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
        [self.view bringSubviewToFront:overlayView];

    }else{
        overlayView.hidden=true;
        isMenuVisible=false;
    }
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
-(void)getSeriesData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/getVideo.php?tag=Podcast"];
    NSLog(@"string url %@",urlString);
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    NSError *error;
    
    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
    
    NSArray *userArray = [userDict objectForKey:@"videos"];
    for (int count=0; count<[userArray count]; count++) {
        
        NSDictionary *activityData=[userArray objectAtIndex:count];
        SeriesVO *csvo=[[SeriesVO alloc] init];
        
        csvo.status=[[NSString alloc] init];
        csvo.sourceurl=[[NSString alloc] init];
        csvo.descr=[[NSString alloc] init];
        csvo.title=[[NSString alloc] init];
        csvo.views=[[NSString alloc] init];
        csvo.tags=[[NSString alloc] init];
        csvo.sourceformat=[[NSString alloc] init];
        csvo.mediatype=[[NSString alloc] init];
        csvo.custom=[[NSString alloc] init];
        csvo.series_name=[[NSString alloc] init];
        csvo.duration=[[NSString alloc] init];
        csvo.upload_session_id=[[NSString alloc] init];
        csvo.link=[[NSString alloc] init];
        csvo.author=[[NSString alloc] init];
        csvo.key=[[NSString alloc] init];
        csvo.error=[[NSString alloc] init];
        csvo.date=[[NSString alloc] init];
        csvo.md5=[[NSString alloc] init];
        csvo.sourcetype=[[NSString alloc] init];
        csvo.size=[[NSString alloc] init];
        if ([activityData objectForKey:@"status"] != [NSNull null])
            csvo.status=[activityData objectForKey:@"status"];
        csvo.sourceurl=[activityData objectForKey:@"sourceurl"];
        csvo.descr=[activityData objectForKey:@"description"];
        csvo.title=[activityData objectForKey:@"title"];
        csvo.views=[activityData objectForKey:@"views"];
        csvo.tags=[activityData objectForKey:@"tags"];
        csvo.sourceformat=[activityData objectForKey:@"sourceformat"];
        csvo.mediatype=[activityData objectForKey:@"mediatype"];
        csvo.custom=[activityData objectForKey:@"custom"];
        NSArray *userArrays=[activityData objectForKey:@"custom"];
        if (![userArrays isKindOfClass:[NSArray class]]){
            NSDictionary *activityDatas=[activityData objectForKey:@"custom"];
            csvo.series_name=[activityDatas objectForKey:@"series_name"];
        }
        csvo.duration=[activityData objectForKey:@"duration"];
        csvo.upload_session_id=[activityData objectForKey:@"upload_session_id"];
        csvo.link=[activityData objectForKey:@"link"];
        csvo.author=[activityData objectForKey:@"author"];
        csvo.key=[activityData objectForKey:@"key"];
        csvo.error=[activityData objectForKey:@"error"];
        csvo.date=[activityData objectForKey:@"date"];
        csvo.md5=[activityData objectForKey:@"md5"];
        csvo.sourcetype=[activityData objectForKey:@"sourcetype"];
        csvo.size=[activityData objectForKey:@"size"];
        [podcastsArray addObject:csvo];
        
    }
    
    
    [activityIndicator stopAnimating];
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [podcastsArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    
    
    SeriesVO *serVO=[podcastsArray objectAtIndex:indexPath.row];
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",serVO.key];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*3;
    
    UIImageView *imgview;
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,finalHeghtspotlight)];
    imgview.clipsToBounds = YES;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [indicator setCenter:imgview.center];
    [cell.contentView addSubview:indicator];
    
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    [imgview removeFromSuperview];
    [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [indicator stopAnimating];
    }];
    imgview.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:imgview];
    
    UILabel * userLblName=[[UILabel alloc] initWithFrame:CGRectMake(21,finalHeghtspotlight+2,250,20)];
    userLblName.lineBreakMode = NSLineBreakByWordWrapping;
    userLblName.numberOfLines = 0;
    [userLblName setFont:[UIFont boldSystemFontOfSize: 16]];
    userLblName.text=serVO.title;
    userLblName.textColor=[UIColor whiteColor];
    [cell.contentView addSubview:userLblName];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*3;
    return finalHeghtspotlight+35;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCategoryDataVO *svo=[podcastsArray objectAtIndex:indexPath.row];
    appDelegate.series_name=[[NSString alloc]init];
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
        appDelegate.titleStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=indexPath.row+1;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
