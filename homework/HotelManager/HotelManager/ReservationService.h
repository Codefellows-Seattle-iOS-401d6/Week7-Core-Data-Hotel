//
//  ReservationService.h
//  HotelManager
//
//  Created by Sung Kim on 7/20/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

@import CoreData;
@import UIKit;
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"

@interface ReservationService : NSObject

- (NSArray *)checkAvailabilityWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

- (NSFetchedResultsController *)findAllReservations:(NSFetchRequest *)request;

- (BOOL)saveReservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room guest:(Guest *)guest;

@end
