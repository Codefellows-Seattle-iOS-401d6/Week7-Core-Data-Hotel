//
//  ReservationService.h
//  ObjectManager
//
//  Created by Derek Graham on 7/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

@import CoreData;
@import UIKit;
#import "Room.h"
#import "Guest.h"

@interface ReservationService : NSObject

- (NSArray *)checkAvailability: (NSDate *)endDate startDate:(NSDate *)startDate;
- (NSFetchedResultsController *)showAllReservations;
- (BOOL )bookRoomStarting: (NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room guest:(Guest *)guest;

@end
