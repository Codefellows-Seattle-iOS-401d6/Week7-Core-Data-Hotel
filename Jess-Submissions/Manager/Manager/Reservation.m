//
//  Reservation.m
//  Manager
//
//  Created by Jessica Malesh on 7/19/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataProperties.h"
#import "NSObject+NSManagedObjectContext.h"

@implementation Reservation

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room
{
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[NSManagedObjectContext managerContext]];
    
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    
    return reservation;
    
}

@end