//
//  ManagerTests.m
//  ManagerTests
//
//  Created by Jessica Malesh on 7/20/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+NSManagedObjectContext.h"


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
    [self setContext:nil];
    [super tearDown];
}


- (void)testContextCreation
{
    XCTAssertNotNil(self.context, @"Context will not be nil. Check category context.");
}

- (void)testContextOnMainQ
{
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Context should be created on the main Q.");
}




@end
