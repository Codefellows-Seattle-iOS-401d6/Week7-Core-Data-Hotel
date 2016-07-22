//
//  Reservation.m
//  Manager
//
//  Created by hannah gaskins on 7/18/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "Room.h"

#import "NSObject+NSManagedObject.h"

@implementation Reservation

// Insert code here to add functionality to your managed object subclass

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room
{
    // creation methods for reservation that returns the created object. any time we create a new object the context will have it
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[NSObject managerContext]];
    
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    
    return reservation;
}


@end
