//
//  MSummary.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSON2Model.h"
@interface MSummary : NSObject <JSON2Model>
//resourceURI (string, optional): The path to the individual event resource.,
@property (nonatomic,copy) NSString *resourceURI;
//name (string, optional): The name of the event.
@property (nonatomic,copy) NSString *name;
 
@end
