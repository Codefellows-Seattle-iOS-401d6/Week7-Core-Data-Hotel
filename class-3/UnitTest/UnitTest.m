//
//  UnitTest.m
//  UnitTest
//
//  Created by Sean Champagne on 7/20/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HotelsViewController.h"


@interface UnitTest : XCTestCase

@property (strong, nonatomic) Room *room;

@end

@implementation UnitTest

- (void)setUp {
    [super setUp];
    
    _room = [[NSManagedObject alloc]init];
}

- (void)tearDown {
    [super tearDown];
    
    _room = nil;
    
}

- (void)testTrue {
    
    XCTAssert(true, @"True should be true!");
}

- (void)testObjectIsNil
{
    NSObject *room;
    XCTAssertNil(room, @"object be nil");
}

- (void)testObjectIsNotNil
{
    XCTAssertNotNil(self.room, @"object should be not nil");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
