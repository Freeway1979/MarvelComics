//
//  MCharacter.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON2Model.h"
#import "MThumbnail.h"
#import "MURL.h"
#import "MComic.h"
#import "MStory.h"
#import "MEvent.h"
#import "MSeries.h"

@interface MCharacter : NSObject <JSON2Model>
//id (int, optional): The unique ID of the character resource.,
@property (nonatomic,assign) NSInteger id;
//name (string, optional): The name of the character.,
@property (nonatomic,copy) NSString *name;
//description (string, optional): A short bio or description of the character.,
@property (nonatomic,copy) NSString *desc;
//modified (Date, optional): The date the resource was most recently modified.,
@property (nonatomic,strong) NSDate *modified;
//resourceURI (string, optional): The canonical URL identifier for this resource.,
@property (nonatomic,copy) NSString *resourceURI;
//thumbnail (Image, optional): The representative image for this character.,
@property (nonatomic,strong) MThumbnail *thumbnail;
//urls (Array[Url], optional): A set of public web site URLs for the resource.,
@property (nonatomic,strong) NSArray<MURL *> *urls;
//comics (ComicList, optional): A resource list containing comics which feature this character.,
@property (nonatomic,strong) NSArray<MComic*> *comics;
//stories (StoryList, optional): A resource list of stories in which this character appears.,
@property (nonatomic,strong) NSArray<MStory *> *stories;
//events (EventList, optional): A resource list of events in which this character appears.,
@property (nonatomic,strong) NSArray<MEvent *> *events;
//series (SeriesList, optional): A resource list of series in which this character appears.
@property (nonatomic,strong) NSArray<MSeries *> *series;

@end
