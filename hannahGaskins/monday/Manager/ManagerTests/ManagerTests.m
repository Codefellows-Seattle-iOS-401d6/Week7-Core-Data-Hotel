//
//  ManagerTests.m
//  ManagerTests
//
//  Created by hannah gaskins on 7/20/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import <XCTest/XCTest.h>

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
    XCTestAssertNotNil(self.context, @"context should not be nil. check category implementation.");
}

- (void)testContextOnMainq
{
    XCTestAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Contet should be created on the main Q");
}

- (void)testCoreDataSave
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    request.resultType = NSCountResultType;
    
    NSError *error;
    NSArray *result = [self.contect executeFetchRequest:request error:&error];
    NSNumber *count = result.firstObject;
    
    XCTestAssertNil(error, @"error performing request.");
    XCTestNotNil(result, @"Result array should not be nil");
    XCTestAssertTrue(count.integerValue > 0,@"Number of objects should not be 0.");
}

@end
