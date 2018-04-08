//
//  NSFileManager+LPExtension.h
//  Marvel Comics
//
//  Created by Liu PingAn on 08/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (LPExtension)

-(NSString *)pathForLibraryDirectory;
-(NSString *)pathForDocumentDirectory;
-(NSString *)getDocumentDirectoryFileFullPathWithFileName:(NSString *)fileName;

@end


