//
//  RearViewController.m
//  Chatapp
//
//  Created by arvind on 7/13/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import "RearViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "UIImage+FontAwesome.h"
#import "MainViewController.h"
#import "NSString+FontAwesome.h"
@interface RearViewController ()

@end

@implementation RearViewController
@synthesize rearTableView = _rearTableView;
@synthesize appDelegate,usernameLabel,selectedMenuItem,titleLabel,imageLogo;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.rearTableView.separatorColor = [UIColor clearColor];
    appDelegate=[[UIApplication sharedApplication] delegate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    self.view.backgroundColor=[UIColor colorWithHexString:@"000000"];
    self.rearTableView.backgroundColor=[UIColor colorWithHexString:@"000000"];
    self.rearTableView.alwaysBounceVertical = NO;
    self.navigationController.navigationBarHidden=YES;
    usernameLabel.text=[prefs objectForKey:@"username"];
    UIFont *customFont = [UIFont fontWithName:@"OpenSans-Light" size:16];
    usernameLabel.font = customFont;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor=[UIColor whiteColor];
    
    
    UILabel *menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 260, 45)];
    [menuItemTextLabel setFont:[UIFont systemFontOfSize:22.0]];

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
    }else if (row == 6)
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
        [menuItemTextLabel setFont:[UIFont systemFontOfSize:16.0]];
        menuItemTextLabel.text = @"   Settings.";
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
