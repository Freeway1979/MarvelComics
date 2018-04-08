//
//  Marvel_ComicsTests.m
//  Marvel ComicsTests
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MarvelNetProvider.h"
#import "NSString+MD5.h"
#import "CharacterListRequest.h"
#import <objc/runtime.h>
#import "NSString+URLEncode.h"
#import "GroupImageSubtitleVM.h"
#import "NSFileManager+LPExtension.h"

@interface Marvel_ComicsTests : XCTestCase

@end

@implementation Marvel_ComicsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testScreenScale
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSLog(@"screen scale = %f",scale);
}

- (void)testMD5 {
    NSString *str = @"1abcd1234";
    NSLog(@"%@-->%@",str,[[str MD5String] lowercaseString]);
}
//- (void)testNetGetChars {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    NSLog(@"testNetGetChars");
//    [MarvelNetProvider getCharacterList:nil success:^(id responseDic) {
//        NSLog(@"response %@",responseDic);
//    } failure:^(NSError *error) {
//        NSLog(@"error %@",error);
//    }];
//}


- (void) testCharacterListRequest
{
//    CharacterListRequest *request = [CharacterListRequest new];
//    request.limit = 20;
//    request.offset = 2;
//    request.nameStartsWith = @"Jack";
//    
//    NSDictionary *dic1 = [request dictionaryWithValuesForKeys:@[@"limit",@"offset",@"nameStartsWith"]];
//    NSDictionary *dic2 = [request parameterDictionary];
    
}
- (void)testCustomObjectSerialization
{
    GroupImageSubtitleVM *vm = [[GroupImageSubtitleVM alloc] initWithTitle:@"CustomObject" cellArray:nil];
    //write in
    NSDictionary *dic = @{@"CustomObject":vm};
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
    [userDetaults setObject:data forKey:@"CustomObject"];
    [userDetaults synchronize];
    //read out
    NSData *CustomObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"CustomObject"];
    GroupImageSubtitleVM *model  = [NSKeyedUnarchiver unarchiveObjectWithData:CustomObject];
    NSLog(@"%@",model);
}
- (void) testObjectProperties
{
    CharacterListRequest *request = [CharacterListRequest new];
    request.limit = 20;
    request.offset = 2;
    request.nameStartsWith = @"Jack";
    
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([request class], &count);
    
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSLog(@"Key %@",key);
    }
    free(properties);
    
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([request class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"type %s %s ",type, name);
    }
    free(ivars);
}

//- (void)testPerformanceNetGetChars {
//    NSLog(@"testPerformanceNetGetChars");
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}
@end
