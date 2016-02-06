//
//  RegisterViewController.h
//  Bloom_Project
//
//  Created by arvind on 12/12/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "AppDelegate.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain) MainViewController *mvc;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)IBOutlet UITextField *emailTxt,*passwordTxt,*firstname,*lastname;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)IBOutlet UIButton *signBtn,*RegisterBtn;
@property(nonatomic,retain)IBOutlet UILabel *firatnameLbl,*lastnameLbl,*signLbl,*RegisterLbl;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;

@end
