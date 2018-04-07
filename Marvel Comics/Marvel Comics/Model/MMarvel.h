//
//  MMarvel.h
//  Marvel Comics
//
//  Created by Liu PingAn on 07/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "JSON2Model.h"

typedef NS_ENUM(NSInteger, MType)
{
    MTypeComic,
    MTypeStory,
    MTypeEvent,
    MTypeSeries,
    MTypeCount
};

@interface MMarvel : NSObject <JSON2Model>
@property (nonatomic,assign) NSInteger mid;
//available (int, optional): The number of total available events in this list. Will always be greater than or equal to the "returned" value.,
@property (nonatomic,assign) NSInteger available;
//returned (int, optional): The number of events returned in this collection (up to 20).,
@property (nonatomic,assign) NSInteger returned;
//collectionURI (string, optional): The path to the full list of events in this collection.,
@property (nonatomic,copy) NSString *collectionURI;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;

@end
