//
//  ObjectManagerTests.m
//  ObjectManagerTests
//
//  Created by Derek Graham on 7/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+NSManagedObjectContext.h"
#import "AppDelegate+CoreDataStack.h"


@interface ObjectManagerTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation ObjectManagerTests

- (void)setUp {
    [super setUp];
    [self setContext:[NSManagedObjectContext managerContext]];

}

- (void)tearDown {
    [self setContext: nil];
    [super tearDown];
}

- (void)testContextCreation {
    XCTAssertNotNil(self.context, @"Context should not be nil. check category impl");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testContextOnMain {
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Context should be on the main Q");
}

- (void)testCoreDataSave {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    request.resultType = NSCountResultType;
    
    NSError *error;
    
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    
    NSNumber *count = result.firstObject;
    
    XCTAssertNil(error,@"Error performing request");
    XCTAssertNotNil(result, @"Result array should not be nil ");
    XCTAssertTrue(count.intValue > 0, @"number of objects in db after save should be > )");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
