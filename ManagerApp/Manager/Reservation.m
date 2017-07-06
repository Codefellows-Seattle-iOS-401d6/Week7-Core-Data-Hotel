//
//  Reservation.m
//  Manager
//
//  Created by David Livingstone on 7/18/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "Reservation.h"
#import "Room.h"
#import "NSObject+NSManagedObjectContext.h"

@implementation Reservation

+(instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room {
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[NSObject managerContext]];
    
    reservation.start = startDate;
    reservation.end = endDate;
    reservation.room = room;
    
    return reservation;
}
@end
