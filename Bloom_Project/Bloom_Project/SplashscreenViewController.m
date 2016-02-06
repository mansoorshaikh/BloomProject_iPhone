//
//  SplashscreenViewController.m
//  Bloom_Project
//
//  Created by arvind on 1/1/16.
//  Copyright © 2016 MWC. All rights reserved.
//
#import "TagCategoryDataVO.h"
#import "SplashscreenViewController.h"
#import "TestHomeViewController.h"
@interface SplashscreenViewController ()

@end

@implementation SplashscreenViewController
@synthesize tagsArray,appDelegate,activityIndicator,splashImg;
- (void)viewDidLoad {
    [super viewDidLoad];
    [activityIndicator startAnimating];
    self.navigationController.navigationBarHidden=YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    tagsArray=[[NSMutableArray alloc]initWithObjects:@"Spotlight",@"Popular",@"Trending Now",@"Feature Doc",@"Short Doc",@"Series",@"Podcast",@"Music", nil];
    // Do any additional setup after loading the view from its nib.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        [splashImg removeFromSuperview];
        splashImg = [[UIImageView alloc] init];
        [splashImg setFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height)];
            [splashImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-Landscapebloom.png"]]];
        [self.view addSubview:splashImg];

    }else{
[splashImg removeFromSuperview];
    splashImg = [[UIImageView alloc] init];
    [splashImg setFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height)];
    //[titleLabel setText:@"BLOOM PROJECT"];
    if(height>=480 && height<568){
        [splashImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default~iphonebloom.png"]]];

    }else if(height>=568 && height<600){
        [splashImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568hbloom@2x.png"]]];
    }else{
        [splashImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-736hbloom@3x.png"]]];
    }
        [self.view addSubview:splashImg];
    }
}

- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    appDelegate.shouldRotate=NO;
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableArray *tagsAccessArray=[[NSMutableArray alloc]initWithObjects:@"Spotlight",@"popular",@"trending",@"Feature Doc",@"Short Doc",@"series,primary video",@"Podcast",@"Music",@"Continue Watching", nil];
        
        for (int tagcount=0; tagcount<[tagsAccessArray count]; tagcount++) {
            
            [self loadAllContentsWithTag:[tagsAccessArray objectAtIndex:tagcount]];
        }
        [activityIndicator stopAnimating];
        
        TestHomeViewController *thvc;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            thvc=[[TestHomeViewController alloc] initWithNibName:@"TestHomeViewContoller~ipad" bundle:nil];
        }else{
            thvc=[[TestHomeViewController alloc] initWithNibName:@"TestHomeViewController" bundle:nil];
        }
        [self.navigationController pushViewController:thvc animated:NO];
    });

}


-(void)loadAllContentsWithTag:(NSString*)tagName{

    
    
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/getVideo.php?tag=%@&limit=3&sort=date&direction=asc",tagName];
    
    
    
        
        
        NSLog(@"string url %@",urlString);
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                         
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
    
        NSDictionary *videosDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
    
        NSArray *videosArray = [videosDict objectForKey:@"videos"];
    
        for (int count=0; count<[videosArray count]; count++) {
            
            NSDictionary *videosData=[videosArray objectAtIndex:count];
            
            TagCategoryDataVO *tagcatVO=[[TagCategoryDataVO alloc] init];
            tagcatVO.status=[[NSString alloc] init];
            tagcatVO.sourceurl=[[NSString alloc] init];
            tagcatVO.descr=[[NSString alloc] init];
            tagcatVO.title=[[NSString alloc] init];
            tagcatVO.views=[[NSString alloc] init];
            tagcatVO.tags=[[NSString alloc] init];
            tagcatVO.sourceformat=[[NSString alloc] init];
            tagcatVO.mediatype=[[NSString alloc] init];
            tagcatVO.custom=[[NSString alloc] init];
            tagcatVO.series_name=[[NSString alloc] init];
            tagcatVO.duration=[[NSString alloc] init];
            tagcatVO.upload_session_id=[[NSString alloc] init];
            tagcatVO.link=[[NSString alloc] init];
            tagcatVO.author=[[NSString alloc] init];
            tagcatVO.key=[[NSString alloc] init];
            tagcatVO.error=[[NSString alloc] init];
            tagcatVO.date=[[NSString alloc] init];
            tagcatVO.md5=[[NSString alloc] init];
            tagcatVO.sourcetype=[[NSString alloc] init];
            tagcatVO.size=[[NSString alloc] init];
            tagcatVO.episodesArray=[[NSMutableArray alloc] init];
            tagcatVO.tagname=[[NSString alloc] init];
            
            if ([videosData objectForKey:@"status"] != [NSNull null])
                tagcatVO.status=[videosData objectForKey:@"status"];
            tagcatVO.sourceurl=[videosData objectForKey:@"sourceurl"];
            tagcatVO.descr=[videosData objectForKey:@"description"];
            tagcatVO.title=[videosData objectForKey:@"title"];
            tagcatVO.views=[videosData objectForKey:@"views"];
            tagcatVO.tags=[videosData objectForKey:@"tags"];
            tagcatVO.sourceformat=[videosData objectForKey:@"sourceformat"];
            tagcatVO.mediatype=[videosData objectForKey:@"mediatype"];
            tagcatVO.custom=[videosData objectForKey:@"custom"];
            NSArray *userArrays=[videosData objectForKey:@"custom"];
            if (![userArrays isKindOfClass:[NSArray class]]){
                NSDictionary *activityDatas=[videosData objectForKey:@"custom"];
                tagcatVO.series_name=[activityDatas objectForKey:@"series_name"];
                if(![tagcatVO.series_name isEqualToString:@""]){
                    [self getAllEpisodes:tagcatVO.series_name :tagName :tagcatVO.episodesArray];
                }
            }
            tagcatVO.duration=[videosData objectForKey:@"duration"];
            tagcatVO.upload_session_id=[videosData objectForKey:@"upload_session_id"];
            tagcatVO.link=[videosData objectForKey:@"link"];
            tagcatVO.author=[videosData objectForKey:@"author"];
            tagcatVO.key=[videosData objectForKey:@"key"];
            tagcatVO.error=[videosData objectForKey:@"error"];
            tagcatVO.date=[videosData objectForKey:@"date"];
            tagcatVO.md5=[videosData objectForKey:@"md5"];
            tagcatVO.sourcetype=[videosData objectForKey:@"sourcetype"];
            tagcatVO.size=[videosData objectForKey:@"size"];
            tagcatVO.tagname=tagName;
            [appDelegate.allTagMainCategoriesArray addObject:tagcatVO];
        }
}

-(void)getAllEpisodes:(NSString*)series_name:(NSString*)tagName:(NSMutableArray*)episodesArray{
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/getVideo.php?tag=%@",series_name];
    
    NSLog(@"string url %@",urlString);
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                         
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    NSError *error;
    
    NSDictionary *videosDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
    NSArray *videosArray = [videosDict objectForKey:@"videos"];
    for (int count=0; count<[videosArray count]; count++) {
        NSDictionary *videosData=[videosArray objectAtIndex:count];
        TagCategoryDataVO *tagcatVO=[[TagCategoryDataVO alloc] init];
        
        tagcatVO.status=[[NSString alloc] init];
        tagcatVO.sourceurl=[[NSString alloc] init];
        tagcatVO.descr=[[NSString alloc] init];
        tagcatVO.title=[[NSString alloc] init];
        tagcatVO.views=[[NSString alloc] init];
        tagcatVO.tags=[[NSString alloc] init];
        tagcatVO.sourceformat=[[NSString alloc] init];
        tagcatVO.mediatype=[[NSString alloc] init];
        tagcatVO.custom=[[NSString alloc] init];
        tagcatVO.series_name=[[NSString alloc] init];
        tagcatVO.duration=[[NSString alloc] init];
        tagcatVO.upload_session_id=[[NSString alloc] init];
        tagcatVO.link=[[NSString alloc] init];
        tagcatVO.author=[[NSString alloc] init];
        tagcatVO.key=[[NSString alloc] init];
        tagcatVO.error=[[NSString alloc] init];
        tagcatVO.date=[[NSString alloc] init];
        tagcatVO.md5=[[NSString alloc] init];
        tagcatVO.sourcetype=[[NSString alloc] init];
        tagcatVO.size=[[NSString alloc] init];
        tagcatVO.episodesArray=[[NSMutableArray alloc] init];
        tagcatVO.tagname=[[NSString alloc] init];
        
        if ([videosData objectForKey:@"status"] != [NSNull null])
            tagcatVO.status=[videosData objectForKey:@"status"];
        tagcatVO.sourceurl=[videosData objectForKey:@"sourceurl"];
        tagcatVO.descr=[videosData objectForKey:@"description"];
        tagcatVO.title=[videosData objectForKey:@"title"];
        tagcatVO.views=[videosData objectForKey:@"views"];
        tagcatVO.tags=[videosData objectForKey:@"tags"];
        tagcatVO.sourceformat=[videosData objectForKey:@"sourceformat"];
        tagcatVO.mediatype=[videosData objectForKey:@"mediatype"];
        tagcatVO.custom=[videosData objectForKey:@"custom"];
        NSArray *userArrays=[videosData objectForKey:@"custom"];
        if (![userArrays isKindOfClass:[NSArray class]]){
            NSDictionary *activityDatas=[videosData objectForKey:@"custom"];
            tagcatVO.series_name=[activityDatas objectForKey:@"series_name"];
            if(![tagcatVO.series_name isEqualToString:@""]){
                
            }
        }
        tagcatVO.duration=[videosData objectForKey:@"duration"];
        tagcatVO.upload_session_id=[videosData objectForKey:@"upload_session_id"];
        tagcatVO.link=[videosData objectForKey:@"link"];
        tagcatVO.author=[videosData objectForKey:@"author"];
        tagcatVO.key=[videosData objectForKey:@"key"];
        tagcatVO.error=[videosData objectForKey:@"error"];
        tagcatVO.date=[videosData objectForKey:@"date"];
        tagcatVO.md5=[videosData objectForKey:@"md5"];
        tagcatVO.sourcetype=[videosData objectForKey:@"sourcetype"];
        tagcatVO.size=[videosData objectForKey:@"size"];
        tagcatVO.tagname=tagName;
        tagcatVO.series_name=series_name;
        [episodesArray addObject:tagcatVO];
    }
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
