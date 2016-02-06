//
//  AppDelegate.h
//  Bloom_Project
//
//  Created by MWC on 12/9/15.
//  Copyright © 2015 MWC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,readwrite) int index,indexs;
@property (nonatomic,retain) NSString *series_name,*descStr,*keyStr,*titleStr,*videoPathStr,*timeStr,*SearchCheck,*registerStrCheck;
@property(nonatomic,retain) NSMutableArray *allEpisodeArray,*allTagMainCategoriesArray;
@property(nonatomic,readwrite) int countStr;
@property(nonatomic,readwrite) BOOL isLandscapeOK;
@property (assign, nonatomic) BOOL shouldRotate;
@end

