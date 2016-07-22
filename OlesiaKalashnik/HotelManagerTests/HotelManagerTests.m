//
//  HotelManagerTests.m
//  HotelManagerTests
//
//  Created by Olesia Kalashnik on 7/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSManagedObject+ManagedContext.h"
#import "ReservationService.h"

@interface HotelManagerTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) ReservationService *reservationService;

@end

@implementation HotelManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [self setContext: [NSManagedObject managedContext]];
    //self.reservationService = [[ReservationService alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [self setContext:nil];
    [super tearDown];
}

-(void)testContextCreation {
    XCTAssertNotNil(self.context, @"Context should not be nil. Check category implementation.");
}

-(void)testContextOnMainQueue {
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Context should be created on the main queue.");
}

-(void)testContext {
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Context should be created on the main queue.");
}

-(void)testCoreDataSave {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    request.resultType = NSCountResultType;
    NSError *error;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    NSNumber *count = results.firstObject;
    XCTAssertNil(error, @"Error performing request.");
    XCTAssertNotNil(results, @"Results array should not be nil");
    XCTAssertTrue(count.integerValue > 0, "@Num of objects should not be 0");
}

-(void)testRoomsAvailabilityCheck {
    self.reservationService = [[ReservationService alloc]init];
    NSArray *availableRooms = [self.reservationService getAvailableRooms:[NSDate date] endDate:[NSDate dateWithTimeIntervalSinceReferenceDate:604800]]; //there should be available rooms during this period of time
    XCTAssertTrue(availableRooms.count > 0, @"Available rooms numbers should not be nil. Check category implementation.");
}


@end
