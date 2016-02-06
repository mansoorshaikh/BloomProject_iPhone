//
//  HomeViewController.m
//  Bloom_Project
//
//  Created by MWC on 12/9/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "AsyncImageView.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "UIImage+FontAwesome.h"
#import "MainViewController.h"
#import "NSString+FontAwesome.h"
#import "SearchViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize activityIndicator,sptlVO,spotlightarray,mainscrollview,spotlightScrollview,testimgArray1,testimgarray2,tagnamearray,contiWatchArray,popularArray,TrabingnowArray,featureArray,shortArray,MainTableView,appDelegate,revealButtonleft;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];
    UIImageView *titleLabel = [[UIImageView alloc] init];
    [titleLabel setFrame:CGRectMake(50, 5, 170, 33)];
    //[titleLabel setText:@"BLOOM PROJECT"];
    [titleLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bloom Project_Logo-white.png"]]];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        revealButtonleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"revealicon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain target:self action:@selector(menuScreenAction)];
        self.navigationItem.leftBarButtonItem = revealButtonleft;
        
        UIBarButtonItem *revealButtonItems = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"searchicon(2).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(SearchAction)];
        self.navigationItem.rightBarButtonItem = revealButtonItems;
    }else{
        UIBarButtonItem *revealButtonleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"revealicon_iphone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain target:self action:@selector(menuScreenAction)];
        self.navigationItem.leftBarButtonItem = revealButtonleft;
        
        UIBarButtonItem *revealButtonItems = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"searchicon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(SearchAction)];
        self.navigationItem.rightBarButtonItem = revealButtonItems;
        
    }
}

-(IBAction)menuScreenAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
    [self performSelector:@selector(onViewAppear) withObject:nil afterDelay:0.1f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(IBAction)SearchAction{
    SearchViewController *search;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        search=[[SearchViewController alloc] initWithNibName:@"SearchViewController~ipad" bundle:nil];
        [self.navigationController pushViewController:search animated:YES];
    }else{
        search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        [self.navigationController pushViewController:search animated:YES];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
    return 85;
    }else{
        return 55;
 
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    UILabel *menuItemTextLabel;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
    menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 580, 65)];
        menuItemTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:50.0f];
    }else{
        menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(2, 5, 320, 45)];
        menuItemTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:27.0f];
    }
    menuItemTextLabel.textColor=[UIColor colorWithHexString:@"fefeff"];
   cell.backgroundColor=[UIColor clearColor];
    if (row == 0)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"homeicon.png"];
        menuItemTextLabel.text = @"   Welcome";
        [menuItemTextLabel.layer setCornerRadius:10];
    }else if (row == 1)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"homeicon.png"];
        menuItemTextLabel.text = @"   Feature Documentaries";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    
    else if (row == 2)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        menuItemTextLabel.text = @"   Short Documentaries";
        [menuItemTextLabel.layer setCornerRadius:10];
    }else if (row == 3)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        menuItemTextLabel.text = @"   Series";
        [menuItemTextLabel.layer setCornerRadius:10];
    }else if (row == 4)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        menuItemTextLabel.text = @"   Podcasts";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    else if (row == 5)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        menuItemTextLabel.text = @"   Music";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    else if (row == 6)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        menuItemTextLabel.text = @"   Sign In";
        [menuItemTextLabel.layer setCornerRadius:10];
    }else if (row == 7)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        menuItemTextLabel.text = @"   Register";
        [menuItemTextLabel.layer setCornerRadius:10];
    }else if (row == 8)
    {
        //menuItemImageView.image=[UIImage imageNamed:@"camera.png"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {

        [menuItemTextLabel setFont:[UIFont systemFontOfSize:35.0]];
        }else{
            [menuItemTextLabel setFont:[UIFont systemFontOfSize:20.0]];

        }
        menuItemTextLabel.text = @"     Settings";
        [menuItemTextLabel.layer setCornerRadius:10];
    }
    [menuItemTextLabel.layer setMasksToBounds:YES];
    //[cell.contentView addSubview:menuItemImageView];
    [cell.contentView addSubview:menuItemTextLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We know the frontViewController is a NavigationController
    NSInteger row = indexPath.row;
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=row;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
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
