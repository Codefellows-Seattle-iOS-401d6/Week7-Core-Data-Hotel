//
//  Reservation.m
//  ObjectManager
//
//  Created by Derek Graham on 7/18/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "Room.h"

#import "AppDelegate+CoreDataStack.h"


@implementation Reservation

// Insert code here to add functionality to your managed object subclass
+ (instancetype) reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room{
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:AppDelegate.managedObjectContext];
    
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    return reservation;
}

@end
