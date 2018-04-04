//
//  MEvent.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON2Model.h"
#import "MEventSummary.h"
@interface MEvent : NSObject <JSON2Model>
//available (int, optional): The number of total available events in this list. Will always be greater than or equal to the "returned" value.,
@property (nonatomic,assign) NSInteger available;
//returned (int, optional): The number of events returned in this collection (up to 20).,
@property (nonatomic,assign) NSInteger returned;
//collectionURI (string, optional): The path to the full list of events in this collection.,
@property (nonatomic,copy) NSString *collectionURI;
//items (Array[EventSummary], optional): The list of returned events in this collection.
@property (nonatomic,strong) NSArray<MEventSummary *> *items;

@end
