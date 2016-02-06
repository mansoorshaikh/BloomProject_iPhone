//
//  TagCategoryDataVO.h
//  Bloom_Project
//
//  Created by arvind on 1/1/16.
//  Copyright © 2016 MWC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagCategoryDataVO : NSObject
@property(nonatomic,retain) NSString *status,*sourceurl,*tagname;

@property (nonatomic,retain) NSString *descr,*title,*views,*tags,*sourceformat,*mediatype,*custom,*duration,*upload_session_id,*link,*author,*key,*error,*date,*md5,*sourcetype,*size,*series_name;

@property(nonatomic,retain) NSMutableArray *episodesArray;

@end
