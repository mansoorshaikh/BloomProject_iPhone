//
//  SignInViewController.m
//  Bloom_Project
//
//  Created by arvind on 1/5/16.
//  Copyright © 2016 MWC. All rights reserved.
//

#import "SignInViewController.h"
#import "Reachability.h"
#import "TestHomeViewController.h"
#import "RegisterViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"
#import "MusicViewController.h"
#import "SeriesViewController.h"
#import "FeatureViewController.h"
#import "ShortsViewController.h"
#import "PodcastsViewController.h"
#import "TestHomeViewController.h"
#import "SearchViewController.h"
#import "RegisterViewController.h"
#import "MyAccountViewController.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

@synthesize activityIndicator,emailTxt,passwordTxt,appDelegate,signBtn,overlayView,isMenuVisible,menuNameArray,menuNameButton,navigationmenuBtn,navigationSearchBtn,bloomimg;
- (void)viewDidLoad {
    [super viewDidLoad];
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
    UIButton *revealButtonItem = [UIButton buttonWithType:UIButtonTypeCustom]; [revealButtonItem setFrame:CGRectMake(0, 0, 30, 44)];
    revealButtonItem.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:25];
    [revealButtonItem setTitle:@"\uf0c9" forState:UIControlStateNormal];
    [revealButtonItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [revealButtonItem addTarget:self action:@selector(menuScreenAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnleft = [[UIBarButtonItem alloc] initWithCustomView:revealButtonItem];
    self.navigationItem.leftBarButtonItem = barBtnleft;
    
    
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
        [signBtn removeFromSuperview];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            signBtn =[[UIButton alloc ]initWithFrame:CGRectMake(24,466,screenWidth-50,40)];
            [signBtn.titleLabel setFont:[UIFont systemFontOfSize:26]];
            
        }else{
            signBtn =[[UIButton alloc ]initWithFrame:CGRectMake(24,276,screenWidth-50,40)];
            [signBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
            
        }
        [signBtn.layer setCornerRadius:5.0];
        [signBtn addTarget:self action:@selector(LoginAction) forControlEvents:UIControlEventTouchUpInside];
        [signBtn setTitle: @"Sign In" forState: UIControlStateNormal];
        [[signBtn layer] setBorderWidth:1.0f];
        [[signBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
        [self.view addSubview:signBtn];
        [self.view bringSubviewToFront:signBtn];
    
    emailTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    // Do any additional setup after loading the view from its nib.
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
        if(!isMenuVisible)
        {
            overlayView.hidden=false;
            isMenuVisible=true;
            [self.view bringSubviewToFront:overlayView];
            
        }else{
            overlayView.hidden=true;
            isMenuVisible=false;
        }
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
        [emailTxt resignFirstResponder];
        [passwordTxt resignFirstResponder];
        
    }else{
        overlayView.hidden=true;
        isMenuVisible=false;
        [emailTxt resignFirstResponder];
        [passwordTxt resignFirstResponder];
        
    }
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTxt) {
        [self.passwordTxt becomeFirstResponder];
    }
    else if (textField == self.passwordTxt) {
        [self.passwordTxt resignFirstResponder];
        [self LoginAction];
    }
      return true;
}
/*- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 if([emailTxt.text isEqualToString:@""]){
 emailTxt.text=@"Email";
 }
 
 else if ([firstname.text isEqualToString:@""]){
 firstname.text=@"First Name";
 
 }
 else if ([lastname.text isEqualToString:@""]){
 lastname.text=@"Last Name";
 
 }
 
 [textField resignFirstResponder];
 return YES;
 }*/
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==emailTxt){
        emailTxt.text=@"";
    }
    else if (textField==passwordTxt){
        passwordTxt.text=@"";
    }
       return YES;
}

- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];}

-(void)LoginAction{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BloomProject" message:@"No internet connection available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
        
    }else if([emailTxt.text isEqualToString:@""] || [passwordTxt.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BloomProject" message:@"Please fill the all values" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/login.php?email=%@&password=%@",emailTxt.text,passwordTxt.text];
        //NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/login.php?email=danielassael@gmail.com&password=1234"];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        if([content isEqualToString:@"false"])
        {
            UIAlertView * alertss = [[UIAlertView alloc]initWithTitle:@"BloomProject" message:@"This user does not exist please check user name and password !!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alertss show];
            [activityIndicator stopAnimating];
        }
        else{
            NSString *firstname=[[NSString alloc]init];
            NSString*lastname=[[NSString alloc]init];
            NSString*user_id=[[NSString alloc]init];
            
            NSError *error;
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            user_id=[userDict objectForKey:@"user_id"];
            
            NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
            [prefsid setObject:user_id forKey:@"user_id"];
            [prefsid synchronize];
            
            firstname=[userDict objectForKey:@"user_first_name"];
            lastname=[userDict objectForKey:@"user_last_name"];
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:firstname forKey:@"firstname"];
            [prefs synchronize];
            
            NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
            [prefss setObject:lastname forKey:@"lastname"];
            [prefss synchronize];
            
            [activityIndicator stopAnimating];
            TestHomeViewController *testhome;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                testhome=[[TestHomeViewController alloc] initWithNibName:@"TestHomeViewContoller~ipad" bundle:nil];
            }else{
                testhome=[[TestHomeViewController alloc]initWithNibName:@"TestHomeViewController" bundle:nil];
            }
            [self.navigationController pushViewController:testhome animated:NO];
            
        }
    }
    [activityIndicator stopAnimating];
    
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
