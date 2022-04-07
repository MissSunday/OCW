//
//  OCWTests.m
//  OCWTests
//
//  Created by 朵朵 on 2021/5/20.
//

#import <XCTest/XCTest.h>


@interface OCWTests : XCTestCase

@end

@implementation OCWTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        
        for (int i = 0; i < 100; i++) {
            //float a = kS_W/375;
            float a = XR_Scale(33);
            NSLog(@"%f",a);
        }

    }];
}

@end
