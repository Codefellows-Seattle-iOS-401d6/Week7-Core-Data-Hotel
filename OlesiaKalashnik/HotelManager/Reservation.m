//
//  Reservation.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "NSManagedObject+managedContext.h"

@implementation Reservation

+(instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room {
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[NSManagedObject managedContext]];
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    return reservation;
    
}

@end
