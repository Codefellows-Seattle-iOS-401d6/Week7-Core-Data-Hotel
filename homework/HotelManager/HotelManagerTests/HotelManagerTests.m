//
//  HotelManagerTests.m
//  HotelManagerTests
//
//  Created by Sung Kim on 7/20/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import <XCTest/XCTest.h>
//import the file you want to test
#import "NSManagedObjectContext+NSManagedObjectContext.h"

@interface HotelManagerTests : XCTestCase

//testing the context
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation HotelManagerTests

- (void)setUp
{
    [super setUp];
    //set up pointer to the context
    [self setContext:[NSManagedObjectContext managerContext]];
}

- (void)tearDown
{
    //destroy self before you destroy the super
    [self setContext:nil];
    [super tearDown];
}

//custom test
- (void)testContextCreation
{
    //testing to see if context is not nil
    XCTAssertNotNil(self.context, @"Context should not be nil. Check category implementation.");
}

- (void)testContextOnMainQ
{
    //testing to see if the context is on the main queue
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Context should be created on the main Q. What is up?");
}

- (void)testSavingDataIntoCoreData
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    request.resultType = NSCountResultType;
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    NSNumber *count = result.firstObject;
    
    //error pointer should be nil
    XCTAssertNil(error, @"Error performing request.");
    //results should not be nil
    XCTAssertNotNil(result, @"Result array should NOT be nil.");
    //results array should have more than 0 objects after save
    XCTAssertTrue(count.intValue > 0, @"Number of objects in database after save should be greater than 0.");
}


@end
