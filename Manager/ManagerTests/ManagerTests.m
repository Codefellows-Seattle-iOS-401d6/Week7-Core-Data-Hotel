//
//  ManagerTests.m
//  ManagerTests
//
//  Created by Erin Roby on 7/20/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+NSManagedObjectContext.h"
#import "DateViewController.h"

@interface ManagerTests : XCTestCase

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) UIDatePicker *startPicker;
@property (strong, nonatomic) UIDatePicker *endPicker;

@end

@implementation ManagerTests

- (void)setUp {
    [self setContext:[NSManagedObjectContext managerContext]];
    [super setUp];
}

- (void)tearDown {
    [self setContext:nil];
    [super tearDown];
}

-(void)testContextCreation {
    XCTAssertNotNil(self.context, @"Context should not be nil!");
}

-(void)testContextOnMainQueue {
    XCTAssertTrue(self.context.concurrencyType == NSMainQueueConcurrencyType, @"Context was not created on main Queue!");
}

-(void)testStartDateCreation {
    self.startPicker = [[UIDatePicker alloc]init];
    NSDate *startDate = [self.startPicker date];
    XCTAssertTrue(startDate, @"NSDate invalid, check DateViewController!");
}



@end
