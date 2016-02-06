//
//  MenuViewController.m
//  Bloom_Project
//
//  Created by arvind on 1/2/16.
//  Copyright © 2016 MWC. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize menuNameArray,menuNameButton,overlayView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"Sign In",@"Register",@"Settings", nil];
    overlayView = [[UIView alloc] initWithFrame:self.view.frame];
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.alpha = 0.95;

    int yValue=0;
    for (int count=0; count<[menuNameArray count]; count++) {
        menuNameButton=[[UIButton alloc] initWithFrame:CGRectMake(10, yValue, 280, 38)];
        [menuNameButton setTitle:[menuNameArray objectAtIndex:count] forState:UIControlStateNormal];
        menuNameButton.tag=count;
        [menuNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuNameButton setBackgroundColor:[UIColor blackColor]];
        [menuNameButton addTarget:self action:@selector(buttonAction:)
      forControlEvents:UIControlEventTouchUpInside];
        [overlayView addSubview:menuNameButton];

        yValue=yValue+44;
    }

    [self.view addSubview:overlayView];

    
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
