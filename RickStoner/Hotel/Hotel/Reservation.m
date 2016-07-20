//
//  Reservation.m
//  Hotel
//
//  Created by Rick  on 7/18/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "NSManagedObject+NSManagedObjectContextCategory.h"

@implementation Reservation

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room {
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[NSManagedObject managedContext]];
    
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    
    return reservation;
    
}
@end
