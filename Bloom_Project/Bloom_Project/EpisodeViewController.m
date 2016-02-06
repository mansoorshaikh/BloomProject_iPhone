//
//  EpisodeViewController.m
//  Bloom_Project
//
//  Created by arvind on 12/28/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import "EpisodeViewController.h"
#import "SeriesVO.h"
#import "DetailsViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SearchViewController.h"
#import "PlayViewController.h"
@interface EpisodeViewController ()

@end

@implementation EpisodeViewController
@synthesize activityIndicator,episodeTableView,episodeArray,appDelegate,nameLbl,navigationmenuBtn,navigationSearchBtn,bloomimg;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    [activityIndicator stopAnimating];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
    [self.view addSubview:bloomimg];
    
    [navigationmenuBtn addTarget:self action:@selector(backAction)forControlEvents:UIControlEventTouchUpInside];
    [navigationmenuBtn setBackgroundImage: [UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:navigationmenuBtn];
    
    [navigationSearchBtn addTarget:self action:@selector(SearchAction)forControlEvents:UIControlEventTouchUpInside];
    [navigationSearchBtn setBackgroundImage: [UIImage imageNamed:@"searchicon.png"] forState:UIControlStateNormal];
    [self.view addSubview:navigationSearchBtn];
    
    episodeArray=[[NSMutableArray alloc]init];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        [episodeTableView removeFromSuperview];
        episodeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,110,self.view.bounds.size.width,self.view.bounds.size.height-360)];
        episodeTableView.backgroundColor=[UIColor clearColor];
        self.episodeTableView.separatorColor = [UIColor clearColor];
        [self.view addSubview:episodeTableView];
        [self.view bringSubviewToFront:episodeTableView];
        
    }else{
    if(height>=480 && height<568){
        
    }else if(height>=568 && height<600){
        [episodeTableView removeFromSuperview];
        episodeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,110,self.view.bounds.size.width,self.view.bounds.size.height-275)];
        episodeTableView.backgroundColor=[UIColor clearColor];
        self.episodeTableView.separatorColor = [UIColor clearColor];
        [self.view addSubview:episodeTableView];
        [self.view bringSubviewToFront:episodeTableView];
    }
    }
    episodeTableView.delegate = self;
    episodeTableView.dataSource = self;
    if ([appDelegate.SearchCheck isEqualToString:@"Search_Yes"]) {
        appDelegate.SearchCheck=@"";
        [self getEpisodeData];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    nameLbl.text=appDelegate.titleStr;

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
-(void)getEpisodeData{
    appDelegate.allEpisodeArray=[[NSMutableArray alloc]init];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/getVideo.php?tag=%@",appDelegate.series_name];
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
        [appDelegate.allEpisodeArray addObject:csvo];
        
    }
    
    
    [activityIndicator stopAnimating];
}
-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:NO];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [appDelegate.allEpisodeArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    
    
    SeriesVO *serVO=[appDelegate.allEpisodeArray objectAtIndex:indexPath.row];
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",serVO.key];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*3;
    CGFloat finalsswidth =yheightsspotlight/2;

    
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
        
        UIButton * titleNameBtn=[[UIButton alloc] initWithFrame:CGRectMake(20,finalHeghtspotlight+2,250,30)];
        [titleNameBtn setTitle:serVO.title forState:UIControlStateNormal];
        titleNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [titleNameBtn setBackgroundColor:[UIColor clearColor]];
        [titleNameBtn addTarget:self action:@selector(DisplayEpisodeList:) forControlEvents:UIControlEventTouchUpInside];
        titleNameBtn.tag=indexPath.row;
        titleNameBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
        [cell.contentView addSubview:titleNameBtn];
    UIImageView *iconBtn;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        iconBtn=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-20,finalsswidth-140, 50, 50)];

    }else{
        iconBtn=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-20,finalsswidth-60, 50, 50)];
    }
        iconBtn.backgroundColor=[UIColor clearColor];
        iconBtn.image=[UIImage imageNamed:@"playimg_1.png"] ;
        [cell.contentView addSubview:iconBtn];

    
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
    dispatch_async(dispatch_get_main_queue(), ^{
        // your navigation controller action goes here
        PlayViewController *play;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            play=[[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
            
        }else{
            play=[[PlayViewController alloc] initWithNibName:@"PlayViewController~ipad" bundle:nil];
            
        }
        SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:indexPath.row];
        appDelegate.videoPathStr=[NSString alloc];
        appDelegate.videoPathStr=svo.key;
        [self.navigationController pushViewController:play animated:NO];
    });
}

-(void)DisplayEpisodeList:(UIButton*)button{
    DetailsViewController * details;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
    }else{
        details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        
    }
    SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:button.tag];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.keyStr=[[NSString alloc]init];
    appDelegate.descStr=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.titleStr=svo.title;
    appDelegate.series_name=svo.series_name;
    appDelegate.descStr=svo.descr;
    appDelegate.keyStr=svo.key;
    appDelegate.countStr=button.tag+1;
    [self.navigationController pushViewController:details animated:NO];

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    
        appDelegate.shouldRotate=NO;
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];

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
