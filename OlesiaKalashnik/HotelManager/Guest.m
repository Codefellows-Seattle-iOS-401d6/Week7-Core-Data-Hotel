//
//  Guest.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "NSManagedObject+managedContext.h"
#import "Guest+CoreDataProperties.h"

@implementation Guest

+(instancetype)guestWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[NSManagedObject managedContext]];
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    return guest;
}

@end
