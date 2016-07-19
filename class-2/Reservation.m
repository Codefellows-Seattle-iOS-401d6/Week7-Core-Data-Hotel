//
//  Reservation.m
//  Manager-Class-2
//
//  Created by Sean Champagne on 7/19/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "NSObject+NSObjectContext.h"

@implementation Reservation

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room;
{
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[NSObject managerContext]];
    
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    
    return reservation;
}

@end
