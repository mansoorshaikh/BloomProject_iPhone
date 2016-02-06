//
//  SignInViewController.h
//  Bloom_Project
//
//  Created by arvind on 1/5/16.
//  Copyright © 2016 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SignInViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)IBOutlet UITextField *emailTxt,*passwordTxt;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)IBOutlet UIButton *signBtn;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;


@end
