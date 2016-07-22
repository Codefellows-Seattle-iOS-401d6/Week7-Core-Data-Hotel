//
//  ManagerTests.m
//  ManagerTests
//
//  Created by hannah gaskins on 7/20/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+NSManagedObject.h"

@interface ManagerTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation ManagerTests

- (void)setUp
{
    [super setUp];
    [self setContext:[NSManagedObjectContext managerContext]];
}

- (void)tearDown
{
    [super tearDown];
    [self setContext:nil];
}

- (void)testContectCreation
{
    XCTAssertNotNil(self.context, @"context should not be nil. Check category implementation");
}

- (void)testContextOnMainq
{
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Contet should be created on the main Q");
}

- (void)testCoreDataSave
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    request.resultType = NSCountResultType;
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    NSNumber *count = result.firstObject;
    

    XCTAssertNil(error, @"error performing request.");

    XCTAssertNotNil(result, @"Result array should not be nil");
    
    XCTAssertTrue(count.integerValue > 0,@"Number of objects should not be 0.");
}

@end
