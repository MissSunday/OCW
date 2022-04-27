//
//  OCWTests.m
//  OCWTests
//
//  Created by 朵朵 on 2021/5/20.
//

#import <XCTest/XCTest.h>
#import "Modifier.h"
#import "base62.h"
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
    
    Modifier *model = [[Modifier alloc]init];
  
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
//        NSString *a = @"1xOBZk6w2UChi3muwwfkBwMYOSNiXHJyiswm7OPR5YdeGtDfEhzdoZc3m2UjzqNyQlUiKB0qpXsDbz5VRple2aFkcPUAcG9gcM7581f6QykSWbG6UF1vEmIBpQTbeS8pxvNRaIsiG42pLWJ";
//        
//        NSString *b = [[Base62Decoder decoder]decodeWithString:a key:1650245101441];
//        NSLog(@"- %@",b);
        for (int i = 0; i < 10; i++) {



            static NSString *a = @"1xOBZk6w2UChi3muwwfkBwMYOSNiXHJyiswm7OPR5YdeGtDfEhzdoZc3m2UjzqNyQlUiKB0qpXsDbz5VRple2aFkcPUAcG9gcM7581f6QykSWbG6UF1vEmIBpQTbeS8pxvNRaIsiG42pLWJ";

            NSString *b = [[Base62Decoder decoder]decodeWithString:a key:1650245101441];

            NSLog(@"- %@",b);

        }

    }];
}

@end
