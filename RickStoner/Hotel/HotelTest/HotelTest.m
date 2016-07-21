//
//  HotelTest.m
//  HotelTest
//
//  Created by Rick  on 7/20/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSManagedObject+NSManagedObjectContextCategory.h"
#import "ReservationService.h"

@interface HotelTest : XCTestCase

@property (strong, nonatomic)NSManagedObjectContext *context;
@property (strong, nonatomic)NSArray *lookup;

@end

@implementation HotelTest

- (void)setUp {
    [super setUp];
    [self setContext: [NSManagedObject managedContext]];
    self.lookup = [ReservationService lookupRequest:@"Ri"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [self setContext:nil];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testOnMainQueue{
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Always run items going to the view on the main queue");
}

- (void)testObjectNotNil {
    XCTAssertNotNil(self.lookup, @"oh uh, something went wrong.");
}




@end
