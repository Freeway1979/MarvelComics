//
//  MURL.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON2Model.h"
@interface MURL : NSObject <JSON2Model>
//type (string, optional): A text identifier for the URL.,
@property (nonatomic,copy) NSString *type;
//url (string, optional): A full URL (including scheme, domain, and path).
@property (nonatomic,copy) NSString *url;
@end
