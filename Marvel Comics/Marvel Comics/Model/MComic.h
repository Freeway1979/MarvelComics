//
//  MComic.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON2Model.h"
#import "MComicSummary.h"
#import "MMarvel.h"
@interface MComic : MMarvel
//items (Array[EventSummary], optional): The list of returned events in this collection.
@property (nonatomic,strong) NSArray<MComicSummary *> *items;

@end
