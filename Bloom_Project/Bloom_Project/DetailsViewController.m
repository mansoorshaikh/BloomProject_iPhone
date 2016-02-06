//
//  DetailsViewController.m
//  Bloom_Project
//
//  Created by arvind on 12/28/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import "DetailsViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "PlayViewController.h"
#import "SeriesVO.h"
#import "SearchViewController.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize appDelegate,activityIndicator,userLblName,episodesynopsisLbl,descLbl,episodeNameLbl,episodeguideLbl,playBtn,imgview,transperentBtn,navigationmenuBtn,navigationSearchBtn,bloomimg,mainscrollview;
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
    
    
    UIButton *PreviewBtn,*AddtoMyListBtn,*ShareIconBtn,*iconBtn;
    CGFloat yheightsspotlight = screenRectwidth.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*3;
    CGFloat finalsswidth =finalHeghtspotlight/2;

    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",appDelegate.keyStr];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        userLblName=[[UILabel alloc] initWithFrame:CGRectMake(10,2,450,40)];
        [userLblName setFont:[UIFont systemFontOfSize:30]];
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,50,screenRectwidth.size.width,finalHeghtspotlight)];
        transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,60,screenRectwidth.size.width, finalHeghtspotlight)];
        iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width/2-40,finalsswidth-40,90, 90)];
        finalHeghtspotlight=finalHeghtspotlight+70;
        PreviewBtn=[[UIButton alloc] initWithFrame:CGRectMake(35,finalHeghtspotlight,160, 40)];
        AddtoMyListBtn=[[UIButton alloc] initWithFrame:CGRectMake(250,finalHeghtspotlight,300, 40)];
        ShareIconBtn=[[UIButton alloc] initWithFrame:CGRectMake(540,finalHeghtspotlight, 200, 40)];
        [PreviewBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
        [AddtoMyListBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
        [ShareIconBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
        finalHeghtspotlight=finalHeghtspotlight+50;
        episodesynopsisLbl=[[UILabel alloc] initWithFrame:CGRectMake(20,finalHeghtspotlight,screenRectwidth.size.width-10,30)];
        [episodesynopsisLbl setFont:[UIFont boldSystemFontOfSize:24]];
        finalHeghtspotlight=finalHeghtspotlight+50;
        descLbl=[[UILabel alloc] initWithFrame:CGRectMake(20,finalHeghtspotlight,screenRectwidth.size.width-60,70)];
        [descLbl setFont:[UIFont boldSystemFontOfSize:24]];
        //finalHeghtspotlight=finalHeghtspotlight+40;
        //episodeguideLbl=[[UILabel alloc] initWithFrame:CGRectMake(20,finalHeghtspotlight,250,30)];
        //[episodeguideLbl setFont:[UIFont boldSystemFontOfSize:24]];

    }else{
        userLblName=[[UILabel alloc] initWithFrame:CGRectMake(10,2,250,30)];
        [userLblName setFont:[UIFont boldSystemFontOfSize:18]];
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,40,screenRectwidth.size.width,finalHeghtspotlight)];
        transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,50,screenRectwidth.size.width, finalHeghtspotlight)];
        iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width/2-25,finalsswidth+10, 50, 50)];
        finalHeghtspotlight=finalHeghtspotlight+60;
        PreviewBtn=[[UIButton alloc] initWithFrame:CGRectMake(5,finalHeghtspotlight,80, 30)];
        AddtoMyListBtn=[[UIButton alloc] initWithFrame:CGRectMake(80,finalHeghtspotlight,140, 30)];
        ShareIconBtn=[[UIButton alloc] initWithFrame:CGRectMake(220,finalHeghtspotlight, 90, 30)];
        [PreviewBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [AddtoMyListBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [ShareIconBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        finalHeghtspotlight=finalHeghtspotlight+30;
        episodesynopsisLbl=[[UILabel alloc] initWithFrame:CGRectMake(10,finalHeghtspotlight,screenRectwidth.size.width-10,40)];
        [episodesynopsisLbl setFont:[UIFont boldSystemFontOfSize:16]];
        finalHeghtspotlight=finalHeghtspotlight+40;
        descLbl=[[UILabel alloc] initWithFrame:CGRectMake(10,finalHeghtspotlight,screenRectwidth.size.width-30,60)];
        [descLbl setFont:[UIFont boldSystemFontOfSize:16]];
        //finalHeghtspotlight=finalHeghtspotlight+60;
        //episodeguideLbl=[[UILabel alloc] initWithFrame:CGRectMake(10,finalHeghtspotlight,250,30)];
        //[episodeguideLbl setFont:[UIFont boldSystemFontOfSize:16]];

    }
    userLblName.text=appDelegate.titleStr;
    userLblName.textColor=[UIColor whiteColor];
    [self.mainscrollview addSubview:userLblName];

    imgview.clipsToBounds = YES;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [indicator setCenter:imgview.center];
    [self.mainscrollview addSubview:indicator];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    [imgview removeFromSuperview];
    [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [indicator stopAnimating];
    }];
    imgview.backgroundColor=[UIColor clearColor];
    [self.mainscrollview addSubview:imgview];

    
    transperentBtn.backgroundColor=[UIColor clearColor];
    [transperentBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mainscrollview addSubview:transperentBtn];
    
    iconBtn.backgroundColor=[UIColor clearColor];
    [iconBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventTouchUpInside];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"playimg_1.png"] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:iconBtn];

       //[PreviewBtn addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [PreviewBtn setTitle: @"Preview" forState: UIControlStateNormal];
    [PreviewBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:PreviewBtn];

  
    //[AddtoMyListBtn addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [AddtoMyListBtn setTitle: @"Add to My List" forState: UIControlStateNormal];
    [AddtoMyListBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:AddtoMyListBtn];
    
  
    //[ShareIconBtn addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [ShareIconBtn setTitle: @"Share Icon" forState: UIControlStateNormal];
    [ShareIconBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:ShareIconBtn];
    
    NSString *episStr;
    if([appDelegate.allEpisodeArray count]>0)
    episStr=[NSString stringWithFormat:@"Episode %@ - Synopsis",appDelegate.titleStr];
    else
    episStr=[NSString stringWithFormat:@"%@ - Synopsis",appDelegate.titleStr];
    episodesynopsisLbl.text=episStr;
    episodesynopsisLbl.lineBreakMode = NSLineBreakByWordWrapping;
    episodesynopsisLbl.numberOfLines = 0;
    episodesynopsisLbl.textColor=[UIColor whiteColor];
    [self.mainscrollview addSubview:episodesynopsisLbl];
    
    
 
    descLbl.text=appDelegate.descStr;
    descLbl.lineBreakMode = NSLineBreakByWordWrapping;
    descLbl.numberOfLines = 0;
    descLbl.textColor=[UIColor whiteColor];
    [self.mainscrollview addSubview:descLbl];
    
  
    finalHeghtspotlight=finalHeghtspotlight+80;

    for (int count=0; count<[appDelegate.allEpisodeArray count]; count++) {
        SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:count];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            episodeNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(30,finalHeghtspotlight,500,30)];
            [episodeNameLbl setFont:[UIFont systemFontOfSize:26]];
            playBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width-180,finalHeghtspotlight,150, 30)];
            [playBtn.titleLabel setFont:[UIFont systemFontOfSize:26]];
        }else{
            episodeNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(10,finalHeghtspotlight,200,30)];
            [episodeNameLbl setFont:[UIFont systemFontOfSize:16]];
            playBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width-100,finalHeghtspotlight,100, 30)];
            [playBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        }
        
        NSString *episStr=[NSString stringWithFormat:@"Episode %@",svo.title];
        episodeNameLbl.text=episStr;
        episodeNameLbl.textColor=[UIColor whiteColor];
        [self.mainscrollview addSubview:episodeNameLbl];
 
        [playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        playBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        playBtn.tag=count+100;
        [playBtn setTitle: @"Play Button" forState: UIControlStateNormal];
        [playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.mainscrollview addSubview:playBtn];
        finalHeghtspotlight=finalHeghtspotlight+45;
        
    }

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
    mainscrollview.contentSize = CGSizeMake(width,finalHeghtspotlight+500);
    }else{
        mainscrollview.contentSize = CGSizeMake(width,finalHeghtspotlight+200);
    }
        mainscrollview.scrollEnabled=YES;

}
-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:NO];
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
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
        appDelegate.shouldRotate=NO;
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];

    
}



-(IBAction)playBtnAction:(UIButton*)button{
    
    SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:button.tag-100];
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",svo.key];
    appDelegate.keyStr=svo.key;
    UIButton *iconBtn;
    CGRect screenRectwidth = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRectwidth.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*3;
    CGFloat finalsswidth =finalHeghtspotlight/2;

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,60,screenRectwidth.size.width,finalHeghtspotlight)];
        transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,60,screenRectwidth.size.width, finalHeghtspotlight)];
        iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width/2-40,finalsswidth-50, 90, 90)];

    }else{
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,50,screenRectwidth.size.width,finalHeghtspotlight)];
        transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,50,screenRectwidth.size.width, finalHeghtspotlight)];
        iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width/2-25,finalsswidth+10, 50, 50)];

    }
    imgview.clipsToBounds = YES;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [indicator setCenter:imgview.center];
    [self.mainscrollview addSubview:indicator];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    [imgview removeFromSuperview];
    [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [indicator stopAnimating];
    }];
    imgview.backgroundColor=[UIColor clearColor];
    [self.mainscrollview addSubview:imgview];
    
   
    transperentBtn.backgroundColor=[UIColor clearColor];
    [transperentBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mainscrollview addSubview:transperentBtn];
    
    iconBtn.backgroundColor=[UIColor clearColor];
    [iconBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventTouchUpInside];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"playimg_1.png"] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:iconBtn];

    NSString *episStr=[NSString stringWithFormat:@"Episode %@ - Synopsis",svo.title];
    episodesynopsisLbl.text=episStr;
    descLbl.text=svo.descr;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)PlayAction{
    
    PlayViewController *play;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        play=[[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];

    }else{
        play=[[PlayViewController alloc] initWithNibName:@"PlayViewController~ipad" bundle:nil];

    }
    appDelegate.videoPathStr=[NSString alloc];
    appDelegate.videoPathStr=appDelegate.keyStr;
    [self.navigationController pushViewController:play animated:NO];
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
