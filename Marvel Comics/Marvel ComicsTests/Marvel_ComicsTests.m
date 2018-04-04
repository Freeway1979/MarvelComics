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
//- (void)testMD5 {
//    NSString *str = @"1abcd1234";
//    NSLog(@"%@-->%@",str,[[str MD5String] lowercaseString]);
//}
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

- (void)testNetGetChars2 {
    //    NSString *url = @"http://gateway.marvel.com/v1/public/characters?ts=1522829299133&apikey=26f078219f521b98b320e9283bc73bd5&hash=735f8dc77f52d737a1c7f0e5370df376";
    
    //对请求路径的说明
    //http://120.25.226.186:32812/login?username=520it&pwd=520&type=JSON
    //协议头+主机地址+接口名称+？+参数1&参数2&参数3
    //协议头(http://)+主机地址(120.25.226.186:32812)+接口名称(login)+？+参数1(username=520it)&参数2(pwd=520)&参数3(type=JSON)
    //GET请求，直接把请求参数跟在URL的后面以？隔开，多个参数之间以&符号拼接
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://gateway.marvel.com/v1/public/characters?ts=1522829299133&apikey=26f078219f521b98b320e9283bc73bd5&hash=735f8dc77f52d737a1c7f0e5370df376"];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSLog(@"%@",dict);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
    
}
//- (void)testPerformanceNetGetChars {
//    NSLog(@"testPerformanceNetGetChars");
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}
@end
